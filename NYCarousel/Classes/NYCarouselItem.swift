//
//  NYCarouselItem.swift
//  FBSnapshotTestCase
//
//  Created by nie yu on 2020/7/10.
//

import UIKit

public enum NYCarouselItemImageType {
    case local(imageName: String)
    case url(imageUrl: String, placeholder: String?)
}

public class NYCarouselItem: NSObject {
    
//    public var image: UIImage?
    public var imageNameType: NYCarouselItemImageType?
    public var content: String?
    public var contentPosition: CGPoint = CGPoint.zero
        
}
