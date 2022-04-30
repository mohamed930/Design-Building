//
//  FieldCell.swift
//  Design engineering
//
//  Created by Mohamed Ali on 30/04/2022.
//

import UIKit

class FieldCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var CheckedImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func ConfigureCell(field: FieldsModel) {
        titleLabel.text = field.filedTitle
        
        if field.checked {
            self.contentView.layer.backgroundColor = UIColor().hexStringToUIColor(hex: "#FEF1EE").cgColor
            self.CheckedImageView.isHidden = false
        }
        else {
            self.contentView.layer.backgroundColor = UIColor().hexStringToUIColor(hex: "#FFFFFF").cgColor
            self.CheckedImageView.isHidden = true
        }
    }
    
    
    
}
