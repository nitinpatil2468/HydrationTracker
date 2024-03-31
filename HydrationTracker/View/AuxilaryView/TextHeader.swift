//
//  TextHeader.swift
//  WaterTracker
//
//  Created by Abcom on 31/03/24.
//

import UIKit

class TextHeader: UIView {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
    }

    func configUI(text:String){
        label.text = text
    }
}
