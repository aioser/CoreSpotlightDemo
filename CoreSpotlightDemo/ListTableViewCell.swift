//
//  ListTableViewCell.swift
//  ListTableViewCell
//
//  Created by sama 刘 on 2021/8/20.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var landmarkImageView: UIImageView!
    @IBOutlet weak var landmarkTitleLabel: UILabel!
    @IBOutlet weak var landmarkDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
