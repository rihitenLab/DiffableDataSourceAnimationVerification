//
//  LeftOneRightTwoItemGroup.swift
//  DiffableDataSourceAnimationVerification
//
//  Created by 松岡 利人 on 2019/12/15.
//  Copyright © 2019 rihitenLab. All rights reserved.
//

import UIKit

struct LeftOneRightTowItemGroup: ItemGroup {
    func create() -> NSCollectionLayoutGroup {
        let itemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .fractionalHeight(1.0))
        let containerGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                              heightDimension: .fractionalWidth(1.0 / 16 * 9))
        let leftGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 3),
                                                         heightDimension: .fractionalHeight(1.0))
        let rightGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2 / 3),
                                                          heightDimension: .fractionalHeight(1.0))

        
        let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 10.0, bottom: 5.0, trailing: 10.0)

        let leftGroup = NSCollectionLayoutGroup.vertical(layoutSize: leftGroupLayoutSize,
                                                         subitem: item,
                                                         count: 1)
        leftGroup.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)

        let rightGroup = NSCollectionLayoutGroup.vertical(layoutSize: rightGroupLayoutSize,
                                                          subitem: item,
                                                          count: 2)
        rightGroup.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)

        let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupLayoutSize,
                                                                subitems: [leftGroup, rightGroup])
        return containerGroup
    }
}
