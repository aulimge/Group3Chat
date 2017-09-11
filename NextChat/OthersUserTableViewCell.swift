//
//  OthersUserTableViewCell.swift
//  NextChat
//
//  Created by Hoang Thu Ha on 11/9/17.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit

class OthersUserTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var othersUserName: UILabel!
    
    @IBOutlet weak var msgOthersUser: UITextView!
    
    @IBOutlet weak var timeStampOthersUser: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
