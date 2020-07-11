//
//  NYCarousel+CollectionViewDatasource.swift
//  FBSnapshotTestCase
//
//  Created by nie yu on 2020/7/10.
//

import UIKit

extension NYCarousel: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int)
        ->
        Int
    {
        return caculatorNumberOfItems()
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath)
        ->
        UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NYCarousel.kCollectionViewCell,
                                                      for: indexPath)
        cell.contentView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        return cell
    }
    
    internal func caculatorNumberOfItems() -> Int {
        carouselCount = dataSource?.nycarouselNumberOfItems(carousel: self) ?? 0
        indicator.itemCount = carouselCount
        if carouselCount <= 1 {
            return carouselCount
        }
        isNeedScroll = true
        return carouselCount + 2
    }
    
    internal func getMoveRectifyIndexPath(_ indexPath: IndexPath) -> IndexPath? {
        if isNeedScroll {
            let row = indexPath.row
            let rectifyIndexPath : IndexPath?
            if row == 0 {
                rectifyIndexPath = IndexPath(row: carouselCount, section: 0)
            } else if row == carouselCount + 1 {
                rectifyIndexPath = IndexPath(row: 1, section: 0)
            } else {
                rectifyIndexPath = nil
            }
            return rectifyIndexPath
        }
        return nil
    }
    
}
