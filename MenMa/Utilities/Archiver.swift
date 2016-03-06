//
//  Archiver.swift
//  MenMa
//
//  Created by Keita Ito on 3/5/16.
//  Copyright © 2016 Keita Ito. All rights reserved.
//

import Foundation

/**
    A struct manages archiving objects. This struct has a couple of type methods, archiving and unarchiving. This struct is expected to take an object of type Array, and an element should be of class type.
*/
struct Archvier<T: AnyObject> {
    
    /**
        Archivies an object to data.
     
        - parameter objects: The object that gets archived. It should be of type Array, and its element should be of class type.
        - returns: The archived object of type NSData.
    */
    static func archive(objects: [T]) -> NSData {
        NSKeyedArchiver.setClassName(String(T), forClass: T.self)
        let archivedObject = NSKeyedArchiver.archivedDataWithRootObject(objects)
        return archivedObject
    }
    
    /**
        Unarchives data to an object. When it is used, a specific type should be added with Archiver, e.g., Archiver<NSString>.unarchive(data)
        
        - parameter data: The data that gets unarchived. It should be of type NSData.
        - returns: The unarchived object. It should be of type Array of T.
     */
    static func unarchive(data: NSData) -> [T]? {
        NSKeyedUnarchiver.setClass(T.self, forClassName: String(T))
        let unarchivedObject = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [T]
        return unarchivedObject
    }
    
    /**
        Gets the class name string of the passed object.
        - parameter object: The object used for retrieving the class name.
        - returns: String of the class name.
    */
    static func getStringOfClassName(object: T) -> String {
        return String(T)
    }
}
