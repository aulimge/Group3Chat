//
//  ViewController.swift
//  NextChat
//
//  Created by Audrey Lim on 09/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//


import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {
    
    var ref : DatabaseReference!
    var contacts : [Contact] = []
    
    @IBOutlet weak var contactsTableView: UITableView! {
        didSet {
            contactsTableView.delegate = self
            contactsTableView.dataSource = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchContacts()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(signOutUser))
        
        
    }
    
    func signOutUser() {
        
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
    }
    
    func fetchContacts() {
        ref = Database.database().reference()
        
        //observer child added works as a loop return each child individually
        ref.child("contacts").observe(.childAdded, with: { (snapshot) in
            guard let info =  snapshot.value as? [String : Any] else {return}
            print("info : \(info)")
            print(snapshot)
            print(snapshot.key)
            
            //cast snapshot.value to correct Datatype
            if let name = info["name"] as? String,
                let email = info["email"] as? String
            {
                
                //create new contact object
                let newContact = Contact(anID: snapshot.key, aName: name, anEmail: email)
                
                //append to contact array
                self.contacts.append(newContact)
                
                //this is more efficient
                //insert indv rows as we retrive idv items
                let  index = self.contacts.count - 1
                let indexPath = IndexPath(row: index, section: 0)
                self.contactsTableView.insertRows(at: [indexPath], with: .right)
                
                
                
            }
        })
        
        ref.child("contacts").observe(.value, with: {
            (snapshot) in
            guard let info = snapshot.value as? [String : Any]
                else {return}
            print(info)
        })
        
        ref.child("contacts").observe(.childRemoved, with: { (snapshot) in
            guard let info = snapshot.value as? [String:Any] else {return}
            print(info)
            
            let deletedID = snapshot.key
            
            //filters through contacts returns index where Boolean condition is fullfilled
            if let deletedIndex = self.contacts.index(where: { (contact) -> Bool in
                return contact.id == deletedID
            }) {
                //remove contact when deletedIndex is found
                self.contacts.remove(at: deletedIndex)
                
                let indexPath = IndexPath(row: deletedIndex, section: 0)
                
                self.contactsTableView.deleteRows(at: [indexPath], with: .fade)
            }
        })
        
        ref.child("contacts").observe(.childChanged, with: { (snapshot) in
            guard let info = snapshot.value as? [String:Any] else {return}
            
            guard let name = info["name"] as? String
                else {return}
            
            if let matchedIndex = self.contacts.index(where: { (contact) -> Bool in
                return contact.id == snapshot.key
            }) {
                let changedContact = self.contacts[matchedIndex]
                changedContact.name = name
                
                
                
                let indexPath = IndexPath(row: matchedIndex, section: 0)
                self.contactsTableView.reloadRows(at: [indexPath], with: .none)
            }
        })
        
        
    } // fetchContacts
    
    
} //end ViewController

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as?
            ContactTableViewCell
            else { return UITableViewCell() }
        
        let contact = contacts[indexPath.row]
        
        cell.nameLabel.text = contact.name
        cell.emailLabel.text = contact.email
        
        
        
        
        // let imageURL = student.imageURL
        
        //  cell.profileImageView.loadImage(from: imageURL)
        
        return cell
        
    }
    
}



extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else {return}
        
        
        let selectedContact = contacts[indexPath.row]
        
        destination.selectedContact = selectedContact
        navigationController?.pushViewController(destination, animated: true)
        
        
    }
    
    
    
}





