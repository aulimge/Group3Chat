import UIKit

class MessageViewController: UIViewController {
    
    @IBOutlet weak var messageName: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var msgUserName: UITextView!
    
    @IBOutlet weak var othersUserName: UILabel!
    
    @IBOutlet weak var msgOthersUserName: UITextView!
    
    @IBOutlet weak var timeStamp: UITextField!
    
    var selectedProfileContact : Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let nameMessage = selectedProfileContact?.name
            else {return}
        
        messageName.text = nameMessage
        
    }
    
    
}
