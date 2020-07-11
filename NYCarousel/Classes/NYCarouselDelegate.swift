//
//  NYCarouselDelegate.swift
//  FBSnapshotTestCase
//
//  Created by nie yu on 2020/7/10.
//

import UIKit

public protocol NYCarouselDelegate: NSObjectProtocol {
    
    func nycarouselWillDisplay(carousel: NYCarousel, indexPath: IndexPath) -> NYCarouselItem
    func nycarouselDidEndDisplay(carousel: NYCarousel, indexPath: IndexPath) -> NYCarouselItem
    
    
}
