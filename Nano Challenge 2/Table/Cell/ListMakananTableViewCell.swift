//
//  ListMakananTableViewCell.swift
//  Nano Challenge 2
//
//  Created by Steven Gunawan on 18/09/19.
//  Copyright © 2019 Steven Gunawan. All rights reserved.
//

import UIKit

class ListMakananTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var namaMakanan: UILabel!
    @IBOutlet weak var jumlahKalori: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
