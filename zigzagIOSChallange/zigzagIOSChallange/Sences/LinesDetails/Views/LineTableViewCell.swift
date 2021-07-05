//
//  LineTableViewCell.swift
//  zigzagIOSChallange
//
//  Created by Mac on 7/5/21.
//

import UIKit

class LineTableViewCell: UITableViewCell {

    @IBOutlet weak var LineName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func SetLineName(name : String)  {
        LineName.text = name
    }

}
