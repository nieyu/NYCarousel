//
//  NYCarousel+CollectionViewDelegate.swift
//  FBSnapshotTestCase
//
//  Created by nie yu on 2020/7/10.
//

import UIKit
import Kingfisher

extension NYCarousel: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.contentView.subviews.forEach { view in
            view.removeFromSuperview()
        }
        guard let carouselItem = delegate?.nycarouselWillDisplay(carousel: self, indexPath: getDisplayRectifyIndexPath(indexPath)) else {
            return
        }
        let cellWidth = cell.contentView.frame.size.width
        let cellHeight = cell.contentView.frame.size.height
        if let imageNameType = carouselItem.imageNameType {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight)
            imageView.contentMode = .scaleAspectFill
            cell.contentView.addSubview(imageView)
            switch imageNameType {
            case .local(let imageName):
                imageView.image = UIImage(named: imageName)
            case .url(let imageUrl, let placeholder):
                let url = URL.init(string: imageUrl)
                imageView.kf.setImage(with: url,
                                      placeholder: UIImage(named: placeholder ?? ""),
                                      options: nil,
                                      progressBlock: nil,
                                      completionHandler: { (image, error, cache, _) in
                                        imageView.image = image
                })
            }
        }
        
        if let content = carouselItem.content {
            let label = UILabel(frame: CGRect(x: 0, y: 0,
                                              width: cellWidth,
                                              height: cellHeight))
            label.text = content
            label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            label.textAlignment = .center
            cell.contentView.addSubview(label)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.contentView.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDraging = true
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if currentIndex == carouselCount + 1 {
            collectionView.scrollToItem(at: IndexPath(row: 1,
                                                      section: 0),
                                        at: .centeredHorizontally,
                                        animated: false)
            currentIndex = 1
        }
        indicator.setHighlight(index: currentIndex - 1)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(#function)
        currentIndex = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        isDraging = false
    }
    
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print(currentIndex)
        let indexPath = IndexPath(row: Int(currentIndex), section: 0)
        if let _movedRectifyIndexPath = getMoveRectifyIndexPath(indexPath)  {
            collectionView.scrollToItem(at: _movedRectifyIndexPath, at: .centeredHorizontally, animated: false)
            currentIndex = _movedRectifyIndexPath.row
            movedRectifyIndexPath = nil
        }
        
    }
    
    private func getDisplayRectifyIndexPath(_ indexPath: IndexPath) -> IndexPath {
        let count = carouselCount
        let rectifyIndexPath: IndexPath
        if count > 1  {
            if indexPath.row == 0 {
                rectifyIndexPath = IndexPath.init(row: count - 1, section: 0)
            } else if indexPath.row == count + 1 {
                rectifyIndexPath = IndexPath.init(row: 0, section: 0)
            } else {
                rectifyIndexPath = IndexPath.init(row: indexPath.row - 1, section: 0)
            }
            return rectifyIndexPath
        }
        return indexPath
    }
}

internal func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

internal func main(closure:@escaping ()->()) {
    DispatchQueue.main.async(execute: closure)
}

internal func global(closure:@escaping ()->()) {
    DispatchQueue.global().async(execute: closure)
}

internal func queue(label: String, closure:@escaping ()->()) {
    let queue = DispatchQueue(label: label)
    queue.async(execute: closure)
}
