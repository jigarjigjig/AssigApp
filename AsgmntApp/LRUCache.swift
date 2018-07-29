//
//  LRUCache.swift
//  AsgmntApp
//
//  Created by Jigar on 29/07/18.
//  Copyright © 2018 Jigar. All rights reserved.
//

import Foundation


final class CacheLRU<Key: Hashable, Value> {
    
    private struct CachePayload {
        let key: Key
        let value: Value
    }
    
    private let capacity: Int
    private let list = DoublyLinkedList<CachePayload>()
    private var nodesDict = [Key: DoublyLinkedListNode<CachePayload>]()
    
    func getStoredObject(key : String) -> Data? {
        let data : Data?  = nil ;
        if  let data = UserDefaults.standard.data(forKey: key){
            return data;
        }
        return data ;
    }
    
    func setStoredObject(key :String , data : Data) -> Void {
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func eraseStoredObject(key : String) -> Void {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    init(capacity: Int) {
        self.capacity = max(0, capacity)
    }
    
    func setValue(_ value: Value, for key: Key) {
        let payload = CachePayload(key: key, value: value)
        
        if let node = nodesDict[key] {
            node.payload = payload
            list.moveToHead(node)
        } else {
            let node = list.addHead(payload)
            nodesDict[key] = node
            setStoredObject(key: key as! String,data: value as! Data);
        }
        
        if list.count > capacity {
            let nodeRemoved = list.removeLast()
            if let key = nodeRemoved?.payload.key {
                nodesDict[key] = nil
                eraseStoredObject(key: key as! String);
            }
        }
    }
    
    func getValue(for key: Key) -> Value? {
        if let node = nodesDict[key] {
            list.moveToHead(node)
        }
        return getStoredObject(key: key as! String) as? Value;
    }
}


typealias DoublyLinkedListNode<T> = DoublyLinkedList<T>.Node<T>

final class DoublyLinkedList<T> {
    final class Node<T> {
        var payload: T
        var previous: Node<T>?
        var next: Node<T>?
        
        init(payload: T) {
            self.payload = payload
        }
    }
    
    private(set) var count: Int = 0
    
    private var head: Node<T>?
    private var tail: Node<T>?
    
    func addHead(_ payload: T) -> Node<T> {
        let node = Node(payload: payload)
        defer {
            head = node
            count += 1
        }
        
        guard let head = head else {
            tail = node
            return node
        }
        
        head.previous = node
        
        node.previous = nil
        node.next = head
        
        return node
    }
    
    func moveToHead(_ node: Node<T>) {
        guard node !== head else { return }
        let previous = node.previous
        let next = node.next
        
        previous?.next = next
        next?.previous = previous
        
        node.next = head
        node.previous = nil
        
        if node === tail {
            tail = previous
        }
        
        self.head = node
    }
    
    func removeLast() -> Node<T>? {
        guard let tail = self.tail else { return nil }
        
        let previous = tail.previous
        previous?.next = nil
        self.tail = previous
        
        if count == 1 {
            head = nil
        }
        
        count -= 1
        
        return tail
    }
}




