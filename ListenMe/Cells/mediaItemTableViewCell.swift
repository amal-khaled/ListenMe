/*!
 @class mediaItemTableViewCell.swift
 
 @brief Contain implemntation for media_cell
 
 @superclass SuperClass: UITableViewCell
 @coclass    ViewController
 @helps ViewController
 
 @author Amal Elgalant
 @copyright  © 2019 Amal Elgalant. All rights reserved.
 @version    1
 */

import UIKit

class mediaItemTableViewCell: UITableViewCell {

        @IBOutlet weak var itemImage: UIImageView!
        @IBOutlet weak var title: UILabel!
        
        @IBOutlet weak var type: UILabel!
        @IBOutlet weak var artist: UILabel!
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            artist.sizeToFit()
            title.sizeToFit()
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
            // Configure the view for the selected state
        }
        
}
