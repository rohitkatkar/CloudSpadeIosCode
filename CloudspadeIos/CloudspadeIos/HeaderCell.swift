//
//  HeaderCell.swift
//  CloudspadeIos
//
//  Created by GNS065 on 28/10/20.
//  Copyright © 2020 CloudspadeIosOrganizationName. All rights reserved.
//
import UIKit
import Foundation

class HeaderCell: UITableViewCell {

    
  
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var headerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
