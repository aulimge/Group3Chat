//
//  SignUpViewController.swift
//  NextChat
//
//  Created by Audrey Lim on 09/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class SignUpViewController: UIViewController {
    
    var ref : DatabaseReference!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            signUpButton.addTarget(self, action: #selector(signUpUser), for: .touchUpInside)
        }
    }
    
  
    
    func signUpUser() {
        guard let name = nameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let confirmPassword = confirmPasswordTextField.text else {return}
        
        if password != confirmPassword {
            createErrorAlert("Password Error", "Passwords do not match")
            return
        } else if email == "" || password == ""{
            createErrorAlert("Missing input field", "Input field must be filled")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let validError = error {
                self.createErrorAlert("Error", validError.localizedDescription)
            }
            
            if let validUser = user {
                let ref = Database.database().reference()
                
                //let randomAge = arc4random_uniform(30) + 1
                
                
              //  let post : [String : Any] = ["age" : randomAge, "name" : email, "imageURL" : self.profilePicURL, "filename" : self.currFilename]
                let post : [String : Any] = ["name" : name ,"email" : email ]

                ref.child("contacts").child(validUser.uid).setValue(post)
                
                self.navigationController?.popViewController(animated: true)
                
            }
        }
    }
    
    
    func createErrorAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
   
    
    
}



