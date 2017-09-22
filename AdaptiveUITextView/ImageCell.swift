//
//  ImageCell.swift
//  AdaptiveUITextView
//
//  Created by Amos  on 9/20/17.
//  Copyright © 2017 Arun. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var myImage: UIImageView! {
        didSet {
            myImage.image = UIImage(named: "defaultPhoto")
        }
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
