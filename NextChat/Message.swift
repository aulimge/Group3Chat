//
//  Message.swift
//  NextChat
//
//  Created by Audrey Lim on 11/09/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import Foundation

class Message {
    var id : String = ""
    var message : String = ""
    var msgTimestamp : String = ""
    var senderName : String = ""
    var senderEmail : String = ""
    var otherUserName : String = ""
    var otherUserEmail : String = ""
    var imageURL : String = ""
    var filename : String = ""
    
    
    init(anID : String, anMessage : String, anMsgTimestamp : String, anSenderName : String, anSenderEmail : String, anOtherUserName : String, anOtherUserEmail : String, anImageURL : String, anFilename : String) {
        id = anID
        message = anMessage
        msgTimestamp = anMsgTimestamp
        senderName = anSenderName
        senderEmail = anSenderEmail
        otherUserName = anOtherUserName
        otherUserEmail = anOtherUserEmail
        imageURL = anImageURL
        filename = anFilename
    }
    
}
