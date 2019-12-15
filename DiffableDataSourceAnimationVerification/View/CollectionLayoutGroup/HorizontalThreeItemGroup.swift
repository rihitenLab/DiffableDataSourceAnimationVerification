//
//  HorizontalThreeItemGroup.swift
//  DiffableDataSourceAnimationVerification
//
//  Created by 松岡 利人 on 2019/12/15.
//  Copyright © 2019 rihitenLab. All rights reserved.
//

import UIKit

struct HorizontalThreeItemGroup: ItemGroup {
    func create() -> NSCollectionLayoutGroup {
        let itemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 3),
                                                    heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5.0,
                                                     leading: 10.0,
                                                     bottom: 5.0,
                                                     trailing: 10.0)
        
        let containerGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                              heightDimension: .fractionalWidth(0.85 / 16 * 9))
        let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupLayoutSize,
                                                                subitem: item, count: 3)

        return containerGroup
    }
}

