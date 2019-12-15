//
//  SingleItemGroup.swift
//  DiffableDataSourceAnimationVerification
//
//  Created by 松岡 利人 on 2019/12/15.
//  Copyright © 2019 rihitenLab. All rights reserved.
//

import UIKit

struct SingleItemGroup: ItemGroup {
    func create() -> NSCollectionLayoutGroup {
        let itemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10.0,
                                                     leading: 10.0,
                                                     bottom: 10.0,
                                                     trailing: 10.0)
        
        let containerGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                              heightDimension: .fractionalWidth(0.85 / 16 * 9))
        let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupLayoutSize,
                                                                subitems: [item])

        return containerGroup
    }
}
