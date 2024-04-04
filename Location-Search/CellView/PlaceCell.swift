//
//  PlaceCell.swift
//  Location-Search
//
//  Created by Bartuğ Kaan Çelebi on 4.04.2024.
//

import UIKit

class PlaceCell: UITableViewCell {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeDetailLabel: UILabel!
    @IBOutlet weak var placeDetailButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func viewDetailTapped(_ sender: UIButton) {
    }
}
