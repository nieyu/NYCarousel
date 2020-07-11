
import UIKit



public class NYCarousel: UIView {
    
    
    
    public weak var dataSource: NYCarouselDataSource?
    public weak var delegate:   NYCarouselDelegate?
    public var scrollDuration: TimeInterval = 2.4
    public var indicatorPosition: NYCarouselIndicatorPosition = .bottom {
        didSet {
            
        }
    }
    
    internal var carouselItems: [NYCarouselItem] = []
    internal var carouselCount: Int = 0
    internal var isNeedScroll = false
    internal var isDraging = false
    internal var movedRectifyIndexPath: IndexPath?
    internal var currentIndex: Int = 0
    internal var indicator: NYCarouselIndicator = NYCarouselIndicator()
    public   var indicatorItemNormalBackgroundColor: UIColor {
        didSet {
            indicator.itemNormalBackgroundColor = indicatorItemNormalBackgroundColor
        }
    }
    public   var indicatorItemHightlightBackgroundColor: UIColor {
        didSet {
            indicator.itemHightlightBackgroundColor = indicatorItemHightlightBackgroundColor
        }
    }
    
    internal var timer: Timer?
    
    static let kCollectionViewCell = "kCollectionViewCell"
    
    
    internal lazy var collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout.init()
        flowlayout.minimumLineSpacing = 0
        flowlayout.minimumInteritemSpacing = 0
        flowlayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let _collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowlayout)
        _collectionView.scrollsToTop = false
        _collectionView.showsHorizontalScrollIndicator = false
        _collectionView.isPagingEnabled = true
        _collectionView.bounces = false
        _collectionView.delegate = self
        _collectionView.dataSource = self
        _collectionView.register(UICollectionViewCell.self,
                                 forCellWithReuseIdentifier: NYCarousel.kCollectionViewCell)
        if #available(iOS 11.0, *) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }
        return _collectionView
    }()
    
    public override init(frame: CGRect) {
        indicatorItemNormalBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        indicatorItemHightlightBackgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        indicatorItemNormalBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        indicatorItemHightlightBackgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        super.init(coder: coder)
    }
    
    private func setup() {
        addSubview(collectionView)
        addSubview(indicator)
        setupIndicatorConstraint(postion: indicatorPosition)
    }
    
    private func setupIndicatorConstraint(postion: NYCarouselIndicatorPosition) {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 10),
            indicator.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = bounds
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = bounds.size
        
    }
    
    public func reloadData() {
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: false)
        indicator.setHighlight()
        let fireTime = Date(timeIntervalSinceNow: scrollDuration)
        if #available(iOS 10.0, *) {
            timer = Timer(fire: fireTime, interval: scrollDuration, repeats: true, block: { (_timer) in
                self.scrollToNextItem()
            })
        } else {
            timer = Timer(timeInterval: scrollDuration, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
        }
        RunLoop.current.add(timer!, forMode: .default)
    }
    
    @objc private func scrollToNextItem() {
        if isDraging {
           return
        }
        if currentIndex == carouselCount + 1 {
            collectionView.scrollToItem(at: IndexPath(row: currentIndex + 1,
                          section: 0),
                                        at: .centeredHorizontally,
                                        animated: true)
        } else {
            collectionView.scrollToItem(at: IndexPath(row: currentIndex + 1,
                                                      section: 0),
                                        at: .centeredHorizontally,
                                        animated: true)
        }
    }
    
}
