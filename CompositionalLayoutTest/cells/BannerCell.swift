//
//  BannerCell.swift
//  CompositionalLayoutTest
//
//  Created by Zerom on 4/22/24.
//

import UIKit
import SnapKit
import Kingfisher

final class BannerCell: UICollectionViewCell {
    static let id = "BannerCell"
    let titleLabel = UILabel()
    let backgroundImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        self.addSubview(backgroundImage)
        self.addSubview(titleLabel)
        
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        backgroundImage.contentMode = .scaleAspectFill
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func config(title: String, imageUrl: String) {
        titleLabel.text = title
        backgroundImage.kf.setImage(with: URL(string: imageUrl))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
