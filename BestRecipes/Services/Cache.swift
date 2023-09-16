//
//  Cache.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 07.09.2023.
//

import Foundation
import OSLog

final class Cache<Key: Hashable, Value> {
    //MARK: - Private properties
    private let wrapped = NSCache<WrappedKey, Entry>()
    private let dateProvider: () -> Date
    private let entryLifeTime: TimeInterval
    private let keyTracker = KeyTracker()
    
    //MARK: - init(_:)
    init(
        dateProvider: @escaping () -> Date = Date.init,
        entryLifeTime: TimeInterval = 12 * 60 * 60,
        maximumEntryCount: Int = 50
    ) {
        self.dateProvider = dateProvider
        self.entryLifeTime = entryLifeTime
        wrapped.countLimit = maximumEntryCount
        wrapped.delegate = keyTracker
        
        Logger.system.debug("Cache: \(#function)")
    }
    
    deinit {
        Logger.system.debug("Cache: \(#function)")
    }
    
    //MARK: - Public methods
    func insert(_ value: Value, forKey key: Key) {
        let date = dateProvider().addingTimeInterval(entryLifeTime)
        let entry = Entry(
            key: key,
            value: value,
            expirationDate: date
        )
        insert(entry: entry)
        Logger.system.debug("Set new cache for key: \(String(describing: key))")
    }
    
    func value(forKey key: Key) -> Value? {
        return entry(forKey: key)?.value
    }
    
    func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
        Logger.system.debug("Remover value for key: \(String(describing: key))")
    }
    
    //MARK: - Subscript
    subscript(key: Key) -> Value? {
        get { value(forKey: key) }
        set {
            guard let value = newValue else {
                removeValue(forKey: key)
                return
            }
            insert(value, forKey: key)
        }
    }
}

private extension Cache {
    func entry(forKey key: Key) -> Entry? {
        guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
            Logger.system.debug("No entry for key: \(String(describing: key))")
            return nil
        }
        
        guard dateProvider() < entry.expirationDate else {
            Logger.system.debug("Entry for key: \(String(describing: key)) expired.")
            removeValue(forKey: key)
            return nil
        }
        
        return entry
    }
    
    func insert(entry: Entry) {
        wrapped.setObject(entry, forKey: WrappedKey(entry.key))
        keyTracker.keys.insert(entry.key)
    }
}

private extension Cache {
    //MARK: - WrappedKey
    final class WrappedKey: NSObject {
        let key: Key
        
        init(_ key: Key) {
            self.key = key
        }
        
        override var hash: Int {
            key.hashValue
        }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }
            return value.key == key
        }
    }
}

private extension Cache {
    //MARK: - Entry
    final class Entry {
        let key: Key
        let value: Value
        let expirationDate: Date
        
        init(
            key: Key,
            value: Value,
            expirationDate: Date
        ) {
            self.key = key
            self.value = value
            self.expirationDate = expirationDate
        }
    }
}

private extension Cache {
    //MARK: - KeyTracker
    final class KeyTracker: NSObject, NSCacheDelegate {
        var keys: Set<Key> = .init()
        
        func cache(
            _ cache: NSCache<AnyObject, AnyObject>,
            willEvictObject obj: Any
        ) {
            guard let entry = obj as? Entry else {
                return
            }
            
            keys.remove(entry.key)
        }
    }
}

extension Cache: Codable where Key: Codable, Value: Codable {
    convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.singleValueContainer()
        let entries = try container.decode([Entry].self)
        entries.forEach(insert)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(keyTracker.keys.compactMap(entry))
    }
}

extension Cache where Key: Codable, Value: Codable {
    func saveToDisk(
        withName name: String,
        using fileManager: FileManager = .default
    ) throws {
        let folderURLs = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )
        let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
        let data = try JSONEncoder().encode(self)
        try data.write(to: fileURL)
    }
}

extension Cache.Entry: Codable where Key: Codable, Value: Codable {}

