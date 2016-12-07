//
//  AuthService.swift
//  ClapChat
//
//  Created by Luke Klepfer on 12/7/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import Foundation
import FirebaseAuth


class AuthService {
    private static let _instance = AuthService()
    
    static var instance: AuthService{
        return _instance
    }
    
    func login(email: String, pass: String){
        
    }
}
