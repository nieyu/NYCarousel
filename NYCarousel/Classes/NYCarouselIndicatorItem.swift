//
//  NYCarouselIndicatorItem.swift
//  NYCarousel
//
//  Created by nie yu on 2020/7/11.
//

import UIKit


public enum NYCarouselIndicatorItemState {
    case normal
    case highlight
}

public class NYCarouselIndicatorItem: UIView {

    
    public var state: NYCarouselIndicatorItemState = .normal {
        didSet { setState() }
    }
    
    public var normalBackgroundColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    public var hightlightBackgroundColor: UIColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    
    private var circelView: UIView = UIView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        circelView.backgroundColor = normalBackgroundColor
        circelView.layer.masksToBounds = true
        circelView.layer.cornerRadius = 3
        addSubview(circelView)
        circelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circelView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circelView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circelView.widthAnchor.constraint(equalToConstant: 6),
            circelView.heightAnchor.constraint(equalToConstant: 6)
        ])
    }
    
    private func setState() {
        switch state {
        case .normal:
            circelView.backgroundColor = normalBackgroundColor
        case .highlight:
            circelView.backgroundColor = hightlightBackgroundColor
        }
    }
    
}
