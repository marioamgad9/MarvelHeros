import UIKit
import Common
import RxSwift

/// The cell representing a marvel character in a table view
class CharacterTableViewCell: NiblessTableViewCell {
    
    // MARK: - Views
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let characterNameBackgroundView = ParallelogramView()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bold(size: .big)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = Colors.Text.marvelCharacterName
        return label
    }()
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    
    // MARK: - Methods
    func configure(withViewModel viewModel: CharacterTableViewCellViewModel) {
        characterNameLabel.text = viewModel.output.name
        viewModel.output.image.drive(characterImageView.rx.image).disposed(by: disposeBag)
    }
    
    override func configureViewHierarchy() {
        // Configure character imageview
        addAndConstraintToEdges(characterImageView, withSpacing: 0)
        
        // Configure character name background view
        add(characterNameBackgroundView, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
                $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32),
                $0.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 32),
                $0.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -32),
                $0.heightAnchor.constraint(equalToConstant: 50)
            ])
        })
        
        // Configure character name label
        characterNameBackgroundView.addAndConstraintToEdges(characterNameLabel, withSpacing: 16)
    }
}
