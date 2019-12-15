//
//  ViewController.swift
//  DiffableDataSourceAnimationVerification
//
//  Created by rihitenLab on 2019/12/15.
//  Copyright © 2019 rihitenLab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct Section: Hashable {
        let identifier = UUID()
        let title: String
        let items: [Item]

        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }

        static func == (lhs: Section, rhs: Section) -> Bool {
            return lhs.identifier == rhs.identifier
        }
    }

    struct Item: Hashable {
        let number: Int
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        static func == (lhs: Item, rhs: Item) -> Bool {
            return lhs.identifier == rhs.identifier
        }
    }

    let data = [Section(title: "section-1",
                        items: (1...3).map{ Item(number: $0) }),
                Section(title: "section-2",
                        items: (1...6).map{ Item(number: $0) }),
                Section(title: "section-3",
                        items: (1...6).map{ Item(number: $0) })
    ]


    static let headerElementKind = "header-element-kind"

    @IBOutlet private weak var containerView: UIView!
    private var collectionView: UICollectionView! = nil

    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    private var itemGroup: ItemGroup = SingleItemGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
    }

    @IBAction func selectedSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            itemGroup = SingleItemGroup()

        case 1:
            itemGroup = HorizontalThreeItemGroup()

        case 2:
            itemGroup = LeftOneRightTowItemGroup()

        default:
            itemGroup = SingleItemGroup()
        }
        let snapshot = dataSource.snapshot()
        dataSource.apply(snapshot, animatingDifferences: true)
    }

}

extension ViewController {

    func createLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: {
            (sectionIndex:Int, layoutEnvironment:NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let sectionLayout = NSCollectionLayoutSection(group: self.itemGroup.create())
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(0.2)),
                                               elementKind: ViewController.headerElementKind,
                                               alignment: .top)
            
            sectionLayout.boundarySupplementaryItems = [sectionHeader]
            
            return sectionLayout
        }, configuration: config)
        
        return layout
    }

    func configureHierarchy() {
        collectionView = UICollectionView(frame: containerView.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reuseIdentifier)
        collectionView.register(
            TitleSupplementaryView.self,
            forSupplementaryViewOfKind: ViewController.headerElementKind,
            withReuseIdentifier: TitleSupplementaryView.reuseIdentifier)
        containerView.addSubview(collectionView)
        collectionView.delegate = self
    }
}

extension ViewController {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
                (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.reuseIdentifier, for: indexPath) as? TextCell
            else { fatalError("Cannot create new cell") }

            cell.backgroundColor = .lightGray
            cell.layer.cornerRadius = 20
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.cornerRadius = 20
            cell.label.textAlignment = .center
            cell.label.font = UIFont.preferredFont(forTextStyle: .title1)

            cell.label.text = item.number.description
            return cell
        }

        dataSource.supplementaryViewProvider = { [weak self]
            (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            guard let self = self, let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TitleSupplementaryView.reuseIdentifier,
                for: indexPath) as? TitleSupplementaryView else { fatalError("Cannot create new header") }
            let snapshot = self.dataSource.snapshot()
            let section = snapshot.sectionIdentifier(containingItem: self.dataSource.itemIdentifier(for: indexPath) ?? Item(number: 1))
            header.label.text = section?.title
            return header
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        data.forEach{
            snapshot.appendSections([$0])
            snapshot.appendItems($0.items, toSection: $0)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
