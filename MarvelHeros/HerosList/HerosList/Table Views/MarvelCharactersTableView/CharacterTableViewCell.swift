import UIKit
import Common
import RxSwift

/// The cell representing a marvel character in a table view
class CharacterTableViewCell: NiblessTableViewCell {
    
    // MARK: - Views
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let shadeView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.2
        return view
    }()
    
    private let characterNameBackgroundView = ParallelogramView()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bold(size: .big)
        label.textAlignment = .center
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
        
        // Configure shade view
        addAndConstraintToEdges(shadeView, withSpacing: 0)
        
        // Configure character name background view
        add(characterNameBackgroundView, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
                $0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32),
                $0.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 32),
                $0.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -32),
                $0.heightAnchor.constraint(equalToConstant: 35)
            ])
        })
        
        // Configure character name label
        characterNameBackgroundView.add(characterNameLabel, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: characterNameBackgroundView.leadingAnchor, constant: 16),
                $0.topAnchor.constraint(equalTo: characterNameBackgroundView.topAnchor, constant: 8),
                $0.trailingAnchor.constraint(equalTo: characterNameBackgroundView.trailingAnchor, constant: -16),
                $0.bottomAnchor.constraint(equalTo: characterNameBackgroundView.bottomAnchor, constant: -8),
                $0.widthAnchor.constraint(greaterThanOrEqualToConstant: 150)
            ])
        })
    }
    
    override func viewHierarchyDidConfigure() {
        // Set background
        backgroundColor = .black
        
        // Set character name background view color
        characterNameBackgroundView.backgroundColor = .clear
    }
}
