//
//  Cache.swift
//  avito
//
//  Created by Melanie Kofman on 18.10.2022.
//

import Foundation
import UIKit
final class Cache<Key: Hashable, Value> {
    //    обертка Key для NSCache
    private let wrapped = NSCache<WrappedKey, Entry>()
    private let dateProvider: ()-> Date
    private let entryTimeInterval: TimeInterval
    
    init(dateProvide: @escaping ()-> Date = Date.init,
         entryTimeInterval: TimeInterval = 1*60*60) {
        self.dateProvider = dateProvide
        self.entryTimeInterval = entryTimeInterval
    }
    
    func insert(value: Value, forKey key: Key) {
        let date = dateProvider().addingTimeInterval(entryTimeInterval)
        let entry = Entry(value: value, expDate: date)
        wrapped.setObject(entry, forKey: WrappedKey(key: key))
    }
    func remove(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key: key))
    }
    func value(forKey key: Key) -> Value? {
        let entry = wrapped.object(forKey: WrappedKey(key: key))
        return entry?.value
    }
}

private extension Cache {
    final class WrappedKey: NSObject {
        let key: Key
        
        init(key: Key) {
            self.key = key
        }
        
        override var hash: Int { return key.hashValue}
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {return false}
            return value.key == key
        }
    }
}

private extension Cache {
    final class Entry {
        let value: Value
        let expDate: Date
        
        init(value: Value, expDate: Date) {
            self.value   = value
            self.expDate = expDate
        }
    }
}
