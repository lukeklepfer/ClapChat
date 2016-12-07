//
//  User.swift
//  ClapChat
//
//  Created by Luke Klepfer on 12/7/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import Foundation

struct User {
    
    private var _firstName: String
    private var _uid: String
    
    init(uid: String, firstName: String) {
        _uid = uid
        _firstName = firstName
        
    }
    
    var uid: String{
        return _uid
    }
    var firstName: String{
        return _firstName
    }
    
}
