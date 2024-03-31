//
//  LogCell.swift
//  WaterTracker
//
//  Created by Abcom on 30/03/24.
//

import UIKit

class LogCell: UITableViewCell {

    @IBOutlet weak var updateButton: UIButton!{
        didSet{
            updateButton.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    
    var onClickUpdate:(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(reading:Reading){
        quantityLbl.text = "\(Int(reading.quantity))"
        dateLbl.text = "\(TimeHandler.getDateInFormate(date: reading.date!))"
    }
    
    @IBAction func onClick_update(_ sender: UIButton) {
        onClickUpdate?()
    }
}
