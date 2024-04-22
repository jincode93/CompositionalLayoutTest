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
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let descLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        addSubview(mainImage)
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descLabel)
        
        mainImage.contentMode = .scaleAspectFill
        stackView.axis = .vertical
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        descLabel.font = .systemFont(ofSize: 12)
        
        mainImage.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(mainImage.snp.trailing).offset(8)
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
