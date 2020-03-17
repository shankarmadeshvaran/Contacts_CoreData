//
//  CellContact.swift
//  ListContacts
//
//  Created by Shankar on 01/02/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import UIKit

class CellContact: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPhonenumber: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
