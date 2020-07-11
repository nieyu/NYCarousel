//
//  NYCarouselDataSource.swift
//  NYCarousel
//
//  Created by nie yu on 2020/7/10.
//

import UIKit

public protocol NYCarouselDataSource: NSObjectProtocol {
    
    func nycarouselNumberOfItems(carousel: NYCarousel) -> Int
    
}
