//
//  ViewController.swift
//  CompositionalLayoutTest
//
//  Created by Zerom on 4/22/24.
//

import UIKit
import SnapKit

fileprivate enum Section: Hashable {
    case banner
}

fileprivate enum Item: Hashable {
    case bannerItem(HomeModel)
}

class HomeViewController: UIViewController {
    let bannerImageUrl = "https://img.hankyung.com/photo/202307/01.34116003.1.jpg"
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCollectionView()
        setDataSource()
        setSnapShot()
    }

    private func setUI() {
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setCollectionView() {
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.id)
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                switch itemIdentifier {
                case .bannerItem(let item):
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: BannerCell.id,
                        for: indexPath
                    ) as? BannerCell else { return UICollectionViewCell() }
                    cell.config(title: item.title, imageUrl: item.imageUrl)
                    return cell
                }
            }
        )
    }
    
    private func setSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        // MARK: - BannerSection
        let bannerSection = Section.banner
        snapshot.appendSections([bannerSection])
        let bannerItems = [
            Item.bannerItem(HomeModel(title: "춘식이 1번",
                                 imageUrl: bannerImageUrl)),
            Item.bannerItem(HomeModel(title: "춘식이 2번",
                                 imageUrl: bannerImageUrl)),
            Item.bannerItem(HomeModel(title: "춘식이 3번",
                                 imageUrl: bannerImageUrl))
        ]
        snapshot.appendItems(bannerItems, toSection: bannerSection)
        dataSource?.apply(snapshot)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 30
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            switch sectionIndex {
            case 0:
                return self?.createBannerSection()
            default:
                return self?.createBannerSection()
            }
        }, configuration: config)
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(230))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}

