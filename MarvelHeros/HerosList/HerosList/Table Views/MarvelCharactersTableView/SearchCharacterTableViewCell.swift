import UIKit
import Common
import SDWebImage

/// The cell representing a marvel character in a search list
class SearchCharacterTableViewCell: NiblessTableViewCell {
    
    // MARK: - Views
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bold(size: .big)
        label.textAlignment = .center
        label.textColor = Colors.Text.marvelCharacterName
        return label
    }()
    
    // MARK: - Methods
    func configure(withViewModel viewModel: CharacterTableViewCellViewModel) {
        characterNameLabel.text = viewModel.output.name
        characterImageView.sd_setImage(with: viewModel.output.imageURL)
    }
    
    override func configureViewHierarchy() {
        // Configure character imageView
        add(characterImageView, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor),
                $0.widthAnchor.constraint(equalTo: heightAnchor)
            ])
        })
        
        // Configure name label
        add(characterNameLabel, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
                $0.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ])
        })
    }
    
    override func viewHierarchyDidConfigure() {
        // Set background
        backgroundColor = Colors.Backgrounds.searchCharacter
    }
}
