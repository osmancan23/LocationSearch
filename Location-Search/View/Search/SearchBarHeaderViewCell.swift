//
//  SearchBarHeaderViewCell.swift
//  Location-Search
//
//  Created by Teyfik Yılmaz on 24.04.2024.
//

import UIKit

class HeaderView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "location.circle"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Konumunuz"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var headerStackView : UIStackView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        headerStackView = UIStackView(arrangedSubviews: [imageView,label])
        headerStackView.distribution = .fillEqually
        headerStackView.axis = .vertical
        headerStackView.spacing = 15
        
        addSubview(headerStackView)
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 10),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -10),
            headerStackView.bottomAnchor.constraint(equalTo: bottomAnchor )]
        )
        
        self.backgroundColor = .systemBackground

  
    }
   
}
