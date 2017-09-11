import UIKit
import FirebaseDatabase
import FirebaseStorage


class MessageViewController: UIViewController {
    
    
    @IBOutlet weak var messageName: UILabel!
   
    var selectedProfileContact : Contact?
    
    var messages : [Message] = []
    var ref : DatabaseReference!

    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
     
        
        guard let nameMessage = selectedProfileContact?.name
            else {return}
        
        messageName.text = nameMessage
        
        fetchMessageData()
    }
    
    


func fetchMessageData() {
    
    ref = Database.database().reference()
    
    
    //observer child added works as a loop return each child individually
    ref.child("messages").observe(.childAdded, with: { (snapshot) in
        guard let info =  snapshot.value as? [String : Any] else {return}
        print("info : \(info)")
        print(snapshot)
        print(snapshot.key)
        
        //cast snapshot.value to correct Datatype
        if let message = info["message"] as? String,
            let timestamp = info["msgTimestamp"] as? String,
            let senderName = info["senderName"] as? String,
            let senderEmail = info["senderEmail"] as? String,
            let otherUserName = info["senderName"] as? String,
            let otherUserEmail = info["senderEmail"] as? String,
            let imageURL = info["imageURL"] as? String,
            let filename = info["filename"] as? String {
            
            //create new message object
          //  let newMessage = Message(anID: snapshot.key, aName: name, anAge: age, anEmail: "", anImageURL: imageURL, anFilename: filename)
        
            let newMessage = Message(anID: snapshot.key, anMessage: message, anMsgTimestamp: timestamp, anSenderName: senderName, anSenderEmail: senderEmail, anOtherUserName: otherUserName, anOtherUserEmail: otherUserEmail, anImageURL: imageURL, anFilename: filename)
            
            //append to message array
            self.messages.append(newMessage)
        

            //insert indv rows as we retrive idv items
            let  index = self.messages.count - 1
            let indexPath = IndexPath(row: index, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .right)
            
            
        }
    })
    
    ref.child("messages").observe(.value, with: {
        (snapshot) in
        guard let info = snapshot.value as? [String : Any]
            else {return}
        print(info)
    })
    
    ref.child("messages").observe(.childRemoved, with: { (snapshot) in
        guard let info = snapshot.value as? [String:Any] else {return}
        print(info)
        
        let deletedID = snapshot.key
        
        //filters through messages returns index where Boolean condition is fullfilled
        if let deletedIndex = self.messages.index(where: { (message) -> Bool in
            return message.id == deletedID
        }) {
            //remove message when deletedIndex is found
            self.messages.remove(at: deletedIndex)
            //let index = self.students.count - 1
            let indexPath = IndexPath(row: deletedIndex, section: 0)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    })
    
    ref.child("messages").observe(.childChanged, with: { (snapshot) in
        guard let info = snapshot.value as? [String:Any] else {return}
        
        guard let message = info["message"] as? String,
            let timestamp = info["msgTimestamp"] as? String,
            let senderName = info["senderName"] as? String,
            let senderEmail = info["senderEmail"] as? String,
            let otherUserName = info["senderName"] as? String,
            let otherUserEmail = info["senderEmail"] as? String,
            let imageURL = info["imageURL"] as? String,
            let filename = info["filename"] as? String
            else {return}
        
     
        
        if let matchedIndex = self.messages.index(where: { (message) -> Bool in
            return message.id == snapshot.key
        }) {
            let changedMessage = self.messages[matchedIndex]
            changedMessage.message = message
            //changedMessage.imageURL = imageURL
            
            
            let indexPath = IndexPath(row: matchedIndex, section: 0)
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
    })
    
    
} //end fetchMessageData
    
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

     
        
        
        // let imageURL = student.imageURL
        
        //  cell.profileImageView.loadImage(from: imageURL)
        
        //return cell
        
    }
    
}


