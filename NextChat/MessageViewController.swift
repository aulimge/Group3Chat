import UIKit
import FirebaseDatabase

class MessageViewController: UIViewController {
    
    
    @IBOutlet weak var messageName: UILabel!
   
    var selectedProfileContact : Contact?
    
    var messages : [Message] = []
    
    
    @IBOutlet var tableView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        //CurrentUserTableViewCell.dataSource = self
        //OthersUserTableViewCell.dataSource = self
        
        
        guard let nameMessage = selectedProfileContact?.name
            else {return}
        
        messageName.text = nameMessage
        
    }
    
    
}


extension MessageViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var identifier = ""
        
        if indexPath.row == 0 {
            //display foodcell
            identifier = "cellUser"
            
        } else {
            //display drinkcell
            identifier = "cellOthers"
        }

        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if let cellUser = cell as? CurrentUserTableViewCell {
            //1. Set the Delegate
            cellUser.delegate = self
            return cellUser
        }
        
        if let cellOthers = cell as? OthersUserTableViewCell {
            //1. Set the Delegate
            cellOthers.delegate = self
            return cellOthers
        }


        
        let message = messages[indexPath.row]
        
        cell.currentUserName.text = message.senderName
        cell.msgCurrentUser.text = message.message
        cell.timeStampCurrentUser.text = message.msgTimestamp

        
        
       // cell.emailLabel.text = contact.email
        
        
        
        
        // let imageURL = student.imageURL
        
        //  cell.profileImageView.loadImage(from: imageURL)
        
        return cell
        
    }
    
}


