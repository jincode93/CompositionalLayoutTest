//
//  HorizontalCell.swift
//  CompositionalLayoutTest
//
//  Created by Zerom on 4/22/24.
//

import UIKit
import Kingfisher

class HorizontalCell: UICollectionViewCell {
    static let id = "HorizontalCell"
    
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
        
        mainImage.contentMode = .scaleAspectFill
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        descLabel.font = .systemFont(ofSize: 16)
        
        mainImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(160)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(mainImage.snp.bottom).offset(8)
        }
        
        descLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
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
