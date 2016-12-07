//
//  AuthService.swift
//  ClapChat
//
//  Created by Luke Klepfer on 12/7/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import Foundation
import FirebaseAuth


typealias Completion = (_ errMSg: String?, _ data: Any?) -> Void

class AuthService {
    private static let _instance = AuthService()
    
    static var instance: AuthService{
        return _instance
    }
    
    func login(email: String, pass: String, onComplete: Completion?){
        
        FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: { (user, error) in
            
            if error != nil {
                if let errorCode = FIRAuthErrorCode(rawValue: error!._code){
                    if errorCode == FIRAuthErrorCode.errorCodeUserNotFound{
                        FIRAuth.auth()?.createUser(withEmail: email, password: pass, completion: { (user, error) in
                            if error != nil{
                                self.handleFireBaseError(error: error! as NSError, onComplete: onComplete)
                            }else{
                                //user created
                                if user?.uid != nil{
                                    DataService.instance.saveUser(uid: user!.uid)//app user created.
                                    FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: { (user, error) in
                                        
                                        if error != nil{
                                            //sign in error
                                            self.handleFireBaseError(error: error! as NSError, onComplete: onComplete)
                                        }else{
                                            //logged in
                                            onComplete?(nil, user)
                                        }
                                    })
                                }
                            }
                        })
                    }
                    else{
                        //other errors
                        self.handleFireBaseError(error: error! as NSError, onComplete: onComplete)
                    }
                }
                
            }else{
                //signed in previous user
                onComplete?(nil, user)
            }
        })
    }
    
    func handleFireBaseError(error: NSError, onComplete: Completion?){
        print(error.debugDescription)
        if let errorCode = FIRAuthErrorCode(rawValue: error._code){
            switch (errorCode) {
            case .errorCodeInvalidEmail:
                onComplete?("Invalid Email Address", nil)
                break
            case .errorCodeWrongPassword:
                onComplete?("Invalid Password", nil)
                break
            case .errorCodeEmailAlreadyInUse,
                .errorCodeAccountExistsWithDifferentCredential:
                onComplete?("Email already in use", nil)
                break
            default:
                onComplete?("There was a problem Authenticating, try again.", nil)
                
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
}
