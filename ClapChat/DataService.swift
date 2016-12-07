//
//  DataService.swift
//  ClapChat
//
//  Created by Luke Klepfer on 12/7/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class DataService {
    private static let _instance = DataService()
    
    static var instance: DataService{
        return _instance
    }
    
    var mainRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    var usersRef: FIRDatabaseReference{
        return mainRef.child("users")
    }
    var mainStorRef: FIRStorageReference{
        return FIRStorage.storage().reference(forURL: "gs://clapchat-9b5ff.appspot.com")
    }
    var imgStorRef: FIRStorageReference{
        return mainStorRef.child("images")
    }
    var vidStorRef: FIRStorageReference{
        return mainStorRef.child("videos")
    }
    
    
    func saveUser(uid: String){
        let profile: Dictionary<String, Any> = ["firstName": "", "lastName": ""]
        mainRef.child("users").child(uid).child("profile").setValue(profile)
    }
    
}
