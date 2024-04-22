//
//  ListCarouselCell.swift
//  CompositionalLayoutTest
//
//  Created by Zerom on 4/22/24.
//

import UIKit
import Kingfisher

class ListCarouselCell: UICollectionViewCell {
    static let id = "ListCarouselCell"
    
    private let mainImage = UIImageView()
    private let titleLabel = UILabel()
    private let descLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        addSubview(mainImage)
        addSubview(titleLabel)
        addSubview(descLabel)
        
        mainImage.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(mainImage.snp.trailing).offset(8)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(mainImage.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
        }
    }
    
    func config(title: String, desc: String?, imageUrl: String) {
        titleLabel.text = title
        descLabel.text = desc
        mainImage.kf.setImage(with: URL(string: imageUrl))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
