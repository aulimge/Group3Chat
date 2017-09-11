import UIKit

class MessageViewController: UIViewController {
    
    @IBOutlet weak var messageName: UILabel!
    var selectedProfileContact : Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let nameMessage = selectedProfileContact?.name
            else {return}
        
        messageName.text = nameMessage
        
    }
    
    
}
