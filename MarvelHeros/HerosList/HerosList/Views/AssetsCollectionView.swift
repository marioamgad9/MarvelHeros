import UIKit
import Common

/// Handles showing assets like comics, series, stories, or events inside HeroDetails
class AssetsCollectionView: NiblessView {
    
    // MARK: - Views
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bold(size: .small)
        label.textColor = Colors.Text.detailsTitle
        return label
    }()
    
    let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.itemSize = CGSize(width: 150, height: 230)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Methods
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
    }
    
    override func configureViewHierarchy() {
        // Configure title label
        add(titleLabel, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
        })
        
        add(collectionView, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
                $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor),
                $0.heightAnchor.constraint(equalToConstant: 230)
            ])
        })
    }
    
    override func viewHierarchyDidConfigure() {
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.registerCellFromClass(AssetCollectionViewCell.self)
    }
}
