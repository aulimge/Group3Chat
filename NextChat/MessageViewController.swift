import UIKit
import FirebaseDatabase

class MessageViewController: UIViewController {
    
    
    @IBOutlet weak var messageName: UILabel!
   
    var selectedProfileContact : Contact?
    
    var messages : [Message] = []
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
     
        
        guard let nameMessage = selectedProfileContact?.name
            else {return}
        
        messageName.text = nameMessage
        
        fetchMessageData()
    }
    
    
}

func fetchMessageData() {
    
    
}

extension MessageViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let message = messages[indexPath.row]
 
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellUser", for: indexPath) as? CurrentUserTableViewCell
                else { return UITableViewCell() }

            
            cell.currentUserName.text = message.senderName
            cell.msgCurrentUser.text = message.message
            cell.timeStampCurrentUser.text = message.msgTimestamp
            
            return cell
            
        } else {
            //display OtherUserCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "othersUser", for: indexPath) as? OthersUserTableViewCell
                else { return UITableViewCell() }
            
            
            cell.othersUserName.text = message.otherUserName
            cell.othersUserName.text = message.message
            cell.timeStampOthersUser.text = message.msgTimestamp
            
            return cell
        }

        
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
//        
//        if let cellUser = cell as? CurrentUserTableViewCell {
//            //1. Set the Delegate
//            cellUser.delegate = self
//            return cellUser
//        }
//        
//        if let cellOthers = cell as? OthersUserTableViewCell {
//            //1. Set the Delegate
//            cellOthers.delegate = self
//            return cellOthers
//        }


        
        
        
        
       // cell.emailLabel.text = contact.email
        
        
        
        
        // let imageURL = student.imageURL
        
        //  cell.profileImageView.loadImage(from: imageURL)
        
        //return cell
        
    }
    
}


