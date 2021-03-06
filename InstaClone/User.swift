//
//  User.swift
//  InstaClone
//
//  Created by Tong Lin on 2/8/17.
//  Copyright © 2017 C4Q-3.2. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class User {
    let email: String
    var profileImage: Photo?
    var votes: [String : Bool]
    var uploaded: [String]
    
    init(email: String, profileImage: Photo?, votes: [String: Bool], uploaded: [String]) {
        self.email = email
        self.profileImage = profileImage
        self.votes = votes
        self.uploaded = uploaded
    }
    
    static func createUserInDatabase(email: String, completion: @escaping (() -> Void)) {
        
        let newUser = User(email: email, profileImage: nil, votes: [:], uploaded: [])
        
        let databaseUserReference = FIRDatabase.database().reference().child("users")
        
        let newUserRef = databaseUserReference.child("\(FIRAuth.auth()!.currentUser!.uid)")
        
        let newUserDetails: [String : AnyObject] = [
            "username" : newUser.email as AnyObject,
            "votes" : newUser.votes as AnyObject
        ]
        
        newUserRef.setValue(newUserDetails) { (error, reference) in
            if error != nil {
                print("Error creating new user: \(error)")
            }
            completion()
        }
    }
    
    
    
}
