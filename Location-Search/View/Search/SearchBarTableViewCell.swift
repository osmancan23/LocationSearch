//
//  SearchBarTableViewCell.swift
//  Location-Search
//
//  Created by Teyfik Yılmaz on 24.04.2024.
//

import UIKit

class SearchBarTableViewCell: UITableViewCell {
    // MARK: - Properties
    var searchTableViewModel: SearchTableViewModel? {
        didSet {
            locationName.text = searchTableViewModel?.locationName
            distance.text = searchTableViewModel?.distance
            
        }
    }
    var locationName : UILabel = {
        let lbl = UILabel()
        lbl.text = "konum"
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.frame = CGRect(x: 90, y: 30, width: UIScreen.main.bounds.width - 60, height: 30)
        return lbl
    }()
    var distance : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.text = "10km"
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.frame = CGRect(x: 20, y:60, width: 100, height: 30)
        return lbl
    }()
    
    let timeImage : UIImageView = {
        let imgView = UIImageView(image: UIImage(systemName: "clock.arrow.circlepath"))
        imgView.tintColor = .black
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.frame = CGRect(x: 20, y: 20, width: 35, height: 30)
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(distance)
        contentView.addSubview(locationName)
        contentView.addSubview(timeImage)

        
        


        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}
