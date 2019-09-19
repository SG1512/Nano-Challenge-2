//
//  HomeTableViewCell.swift
//  Nano Challenge 2
//
//  Created by Steven Gunawan on 19/09/19.
//  Copyright © 2019 Steven Gunawan. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var namaMakananHome: UILabel!
    @IBOutlet weak var jumlahKaloriHome: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
