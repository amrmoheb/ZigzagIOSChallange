//
//  LineTableViewCell.swift
//  zigzagIOSChallange
//
//  Created by Mac on 7/5/21.
//

import UIKit

class LineTableViewCell: UITableViewCell {

    @IBOutlet weak var LineName: UILabel!
    
    @IBOutlet weak var EstimatedTmeLable: UILabel!
    @IBOutlet weak var ArrivalTimeLable: UILabel!
    
    @IBOutlet weak var PublishedLineVIew: UIView!
    @IBOutlet weak var PublishedLineName: UILabel!
    @IBOutlet weak var OriginName: UILabel!
    
    @IBOutlet weak var GateName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PublishedLineVIew.layer.cornerRadius = 10
        // Initialization code
     //  EstimatedTmeLable.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func SetLineName(name : String)  {
        LineName.text = name
        
    }

}
