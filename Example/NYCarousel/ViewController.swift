//
//  ViewController.swift
//  NYCarousel
//
//  Created by nieyuchina@163.com on 07/10/2020.
//  Copyright (c) 2020 nieyuchina@163.com. All rights reserved.
//

import UIKit
import NYCarousel


public class ViewController: UIViewController {
    
    var carousel: NYCarousel = NYCarousel(frame: CGRect.init(x: 10, y: 100, width: 400, height: 200))

    var carouselItems: [NYCarouselItem] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        carousel.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        view.addSubview(carousel)
        carousel.delegate = self
        carousel.dataSource = self
        let item1 = NYCarouselItem.init()
        item1.imageNameType = .local(imageName: "image1")
        item1.content = "1"
        carouselItems.append(item1)

        let item2 = NYCarouselItem.init()
        item2.imageNameType = .local(imageName: "image2")
        item2.content = "2"
        carouselItems.append(item2)
        
        let item3 = NYCarouselItem.init()
        item3.imageNameType = .local(imageName: "image3")
        item3.content = "3"
        carouselItems.append(item3)
        
        let item4 = NYCarouselItem.init()
//        item4.imageNameType = .local(imageName: "image4")
        item4.imageNameType = .url(imageUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594479195669&di=75a886e47eb33c427263ac4984f9a2b8&imgtype=0&src=http%3A%2F%2Fdesk.fd.zol-img.com.cn%2Fg5%2FM00%2F02%2F0E%2FChMkJlbK5pqIcV7dAAQDU4JGja0AALKWgKa4WUABANr295.jpg", placeholder: "image4")
        item4.content = "4"
        carouselItems.append(item4)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        carousel.reloadData()
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: NYCarouselDataSource {
    public func nycarouselNumberOfItems(carousel: NYCarousel) -> Int {
        return carouselItems.count
    }
}

extension ViewController: NYCarouselDelegate {
    public func nycarouselWillDisplay(carousel: NYCarousel, indexPath: IndexPath) -> NYCarouselItem {
        let row = indexPath.row
        return carouselItems[row]
    }

    public func nycarouselDidEndDisplay(carousel: NYCarousel, indexPath: IndexPath) -> NYCarouselItem {
        let row = indexPath.row
        return carouselItems[row]
    }

}


