import UIKit

class CurrentUserTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var currentUserName: UILabel!
    
    @IBOutlet weak var msgCurrentUser: UITextView!

    @IBOutlet weak var timeStampCurrentUser: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
