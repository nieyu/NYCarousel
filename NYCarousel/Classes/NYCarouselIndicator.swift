//
//  NYCarouselIndicator.swift
//  NYCarousel
//
//  Created by nie yu on 2020/7/10.
//

import UIKit

public enum NYCarouselIndicatorPosition {
    case left
    case right
    case top
    case bottom
}

public class NYCarouselIndicator: UIView {
    
    public var position: NYCarouselIndicatorPosition = .bottom
    public var itemNormalBackgroundColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    public var itemHightlightBackgroundColor: UIColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    
    public var itemCount: Int = 0 {
        didSet {
            if oldValue != itemCount {
                stackView.arrangedSubviews.forEach { (item) in
                    item.removeFromSuperview()
                }
                indicatorItems.removeAll()
                setupItems()
            } else {
                
            }
            
        }
    }
    
    private var stackView: UIStackView = UIStackView()
    private var indicatorItems: [NYCarouselIndicatorItem] = []
    private var hightlightItemIndex: Int = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(stackView)
        stackView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0.5
    }
    
    private func setupItems() {
        for _ in 0..<itemCount {
            let indicatorItem = NYCarouselIndicatorItem()
            indicatorItem.normalBackgroundColor = itemNormalBackgroundColor
            indicatorItem.hightlightBackgroundColor = itemHightlightBackgroundColor
            indicatorItems.append(indicatorItem)
            stackView.addArrangedSubview(indicatorItem)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
    
    public func setHighlight(index: Int = 0) {
        let preIndicatorItem = indicatorItems[hightlightItemIndex]
        preIndicatorItem.state = .normal
        let currentIndicatorItem = indicatorItems[index]
        currentIndicatorItem.state = .highlight
        hightlightItemIndex = index
    }
    
}
