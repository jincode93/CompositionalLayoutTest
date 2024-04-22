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
    case horizontal
    case listCarousel
}

fileprivate enum Item: Hashable {
    case bannerItem(HomeModel)
    case horizontalItem(HomeModel)
    case listCarouselItem(HomeModel)
}

class HomeViewController: UIViewController {
    let bannerImageUrl = "https://img.hankyung.com/photo/202307/01.34116003.1.jpg"
    let horizontalImageUrl = "https://img.hankyung.com/photo/202307/01.34116002.1.jpg"
    let listImageUrl = "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FF1vZT%2FbtrslU6PmAF%2FcVXxfCK1S3iBo8WmwDVsF0%2Fimg.jpg"
    
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
        collectionView.register(HorizontalCell.self, forCellWithReuseIdentifier: HorizontalCell.id)
        collectionView.register(ListCarouselCell.self, forCellWithReuseIdentifier: ListCarouselCell.id)
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
                case .horizontalItem(let item):
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: HorizontalCell.id,
                        for: indexPath
                    ) as? HorizontalCell else { return UICollectionViewCell() }
                    
                    cell.config(title: item.title, desc: item.desc, imageUrl: item.imageUrl)
                    return cell
                case .listCarouselItem(let item):
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: ListCarouselCell.id,
                        for: indexPath
                    ) as? ListCarouselCell else { return UICollectionViewCell() }
                    
                    cell.config(title: item.title, desc: item.desc, imageUrl: item.imageUrl)
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
        let bannerItems: [Item] = [Int](1...3).map { num in
            Item.bannerItem(HomeModel(title: "춘식이 \(num)번",
                                      imageUrl: bannerImageUrl))
        }
        snapshot.appendItems(bannerItems, toSection: bannerSection)
        
        // MARK: - HorizontalSection
        let horizontalSection = Section.horizontal
        snapshot.appendSections([horizontalSection])
        let horizontalItems: [Item] = [Int](1...6).map { num in
            Item.horizontalItem(HomeModel(title: "춘식이 \(num)번",
                                          desc: "\(num)번 춘식이는 귀여워",
                                          imageUrl: horizontalImageUrl))
        }
        snapshot.appendItems(horizontalItems, toSection: horizontalSection)
        
        // MARK: - ListCarouselSection
        let listCarouselSection = Section.listCarousel
        snapshot.appendSections([listCarouselSection])
        let listCarouselItems: [Item] = [Int](1...9).map { num in
            Item.listCarouselItem(HomeModel(title: "춘식이 \(num)번",
                                            desc: "\(num)번 춘식이는 귀여워",
                                            imageUrl: listImageUrl))
        }
        snapshot.appendItems(listCarouselItems, toSection: listCarouselSection)
        
        dataSource?.apply(snapshot)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 30
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            switch section {
            case .banner:
                return self?.createBannerSection()
            case .horizontal:
                return self?.createHorizontalSection()
            case .listCarousel:
                return self?.createListCarouselSection()
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
    
    private func createHorizontalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(160),
                                               heightDimension: .estimated(230))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createListCarouselSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(230))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     repeatingSubitem: item,
                                                     count: 3)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}

