//
//  UserCell.swift
//  ClapChat
//
//  Created by Luke Klepfer on 12/7/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var userNameLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCheckMark(selected: false)
    }
    
    func updateUI(user: User){
    
        userNameLbl.text = user.firstName
    }
    
    func setCheckMark(selected: Bool){
        let imgString = selected ? "messageindicatorchecked1" : "messageindicator1"
        self.accessoryView = UIImageView(image: UIImage(named: imgString))
    }

}
