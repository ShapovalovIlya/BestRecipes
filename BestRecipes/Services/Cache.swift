//
//  Cache.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 07.09.2023.
//

import Foundation

final class Cache<Key: Hashable, Value> {
    //MARK: - Private properties
    private let wrapped = NSCache<WrappedKey, Entry>()
    private let dateProvider: () -> Date
    private let entryLifeTime: TimeInterval
    
    //MARK: - init(_:)
    init(
        dateProvider: @escaping () -> Date = Date.init,
        entryLifeTime: TimeInterval = 12 * 60 * 60
    ) {
        self.dateProvider = dateProvider
        self.entryLifeTime = entryLifeTime
    }
    
    //MARK: - Public methods
    func insert(_ value: Value, forKey key: Key) {
        let date = dateProvider().addingTimeInterval(entryLifeTime)
        let entry = Entry(
            value: value,
            expirationDate: date
        )
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }
    
    func value(forKey key: Key) -> Value? {
        guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
            return nil
        }
        guard dateProvider() < entry.expirationDate else {
            removeValue(forKey: key)
            return nil
        }
        return entry.value
    }
    
    func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
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
        let value: Value
        let expirationDate: Date
        
        init(
            value: Value,
            expirationDate: Date
        ) {
            self.value = value
            self.expirationDate = expirationDate
        }
    }
}
