import UIKit
import Common

protocol HeroDetailsRootViewResponder {
    func backTapped()
}

/// The rootview for HeroDetailsViewController
class HeroDetailsRootView: NiblessView {
    
    // MARK: - Views
    let background: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.addShadeEffect()
        imageView.addBlurEffect()
        return imageView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private(set) lazy var header: HeroDetailsHeader = {
        return HeroDetailsHeader(responder: self)
    }()
    
    let comicsCollectionView = AssetsCollectionView(title: "title.details_comics".localized)
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // MARK: - Properties
    private let responder: HeroDetailsRootViewResponder
    
    // MARK: - Methods
    init(responder: HeroDetailsRootViewResponder) {
        self.responder = responder
        super.init(frame: .zero)
    }
    
    override func configureViewHierarchy() {
        // Configure background
        addAndConstraintToEdges(background, withSpacing: 0)
        
        // Configure activity indicator
        add(activityIndicator, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
                $0.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            ])
        })
        
        // Configure header
        contentView.add(header, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                $0.topAnchor.constraint(equalTo: contentView.topAnchor),
                $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        })
        
        // Configure comics collectionview
        contentView.add(comicsCollectionView, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                $0.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 16),
                $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        })
        
        // Configure scrollview
        scrollView.add(contentView, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            let heightAnchor = $0.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            heightAnchor.priority = .defaultLow
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: scrollView.topAnchor),
                $0.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                $0.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                $0.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                heightAnchor
            ])
        })
        
        addAndConstraintToEdges(scrollView, withSpacing: 0)
    }
    
    override func viewHierarchyDidConfigure() {
        // Set background color
        backgroundColor = .black
    }
}

// MARK: - HeroDetailsHeaderResponder
extension HeroDetailsRootView: HeroDetailsHeaderResponder {
    func backTapped() {
        responder.backTapped()
    }
}
