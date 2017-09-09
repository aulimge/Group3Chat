//
//  ProfileViewController.swift
//  NextChat
//
//  Created by Audrey Lim on 09/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//


import UIKit
import FirebaseDatabase
import FirebaseStorage
    
    
class ProfileViewController: UIViewController {
        
        var selectedContact : Contact?
        var ref : DatabaseReference!
        var idEdit : Bool = true
        
        //var profilePicURL : String = ""
        
        //@IBOutlet weak var profileImageView: UIImageView!
        
        
        
        @IBOutlet weak var nameTextField: UITextField! {
            didSet {
                nameTextField.isUserInteractionEnabled = false  //cannot tapped
                
            }
        }
    
    
        
        @IBOutlet weak var editButton: UIButton! {
            didSet {
                editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
                
            }
        }
        
        func editButtonTapped() {
            if idEdit == true {
                nameTextField.isUserInteractionEnabled = true
                editButton.setTitle("Done", for: .normal)
                idEdit = false
            } else {
                ref = Database.database().reference()
                guard let id = selectedContact?.id,
                    let name = nameTextField.text
                    else {return}
                
                let post : [String : Any] = ["name" : name]
                
                //dig paths to reach a specific contact
                ref.child("contacts").child(id).updateChildValues(post)
                editButton.setTitle("Edit", for: .normal)
                idEdit = true
                nameTextField.isUserInteractionEnabled = false
            }
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            guard let name = selectedContact?.name
                else {return}
            
            nameTextField.text = name
            editButton.titleLabel?.text = "Edit"
            
            
          // profileImageView.loadImage(from: imageURL)
            
        }
        
    
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
}

