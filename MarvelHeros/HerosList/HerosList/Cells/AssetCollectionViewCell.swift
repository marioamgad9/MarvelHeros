import UIKit
import Common

/// Represents a comic, series, story, or an event for a character (Lives inside AssetsCollectionView)
class AssetCollectionViewCell: NiblessCollectionViewCell {
    
    // MARK: - Views
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(size: .small)
        label.textColor = Colors.Text.details
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Methods
    func configure(title: String, imageURL: URL?) {
        titleLabel.text = title
        imageView.sd_setImage(with: imageURL)
    }
    
    override func configureViewHierarchy() {
        // Configure imageview
        add(imageView, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor),
                $0.heightAnchor.constraint(equalToConstant: 200),
                $0.widthAnchor.constraint(equalToConstant: 150)
            ])
        })
        
        // Configure title label
        add(titleLabel, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            ])
        })
    }
}
