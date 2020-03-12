import UIKit
import Common
import SDWebImage

protocol HeroDetailsHeaderResponder {
    func backTapped()
}

/// A view that holds the image, name and description of a hero
class HeroDetailsHeader: NiblessView {
    
    // MARK: - Views
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic-back")
        imageView.tintColor = Colors.Text.details
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bold(size: .small)
        label.textColor = Colors.Text.detailsTitle
        label.text = "title.details_name".localized
        return label
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(size: .normal)
        label.textColor = Colors.Text.details
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bold(size: .small)
        label.textColor = Colors.Text.detailsTitle
        label.text = "title.details_description".localized
        return label
    }()
    
    private let characterDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(size: .normal)
        label.textColor = Colors.Text.details
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Properties
    private let responder: HeroDetailsHeaderResponder
    
    // MARK - Methods
    init(responder: HeroDetailsHeaderResponder) {
        self.responder = responder
        super.init(frame: .zero)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backImageViewTapped))
        backImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func configure(withViewModel viewModel: HeroDetailsHeaderViewModel) {
        characterNameLabel.text = viewModel.output.name
        characterDescriptionLabel.text = viewModel.output.description
        characterImageView.sd_setImage(with: viewModel.output.imageURL)
    }
    
    override func configureViewHierarchy() {
        // Configure character imageview
        add(characterImageView, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor),
                $0.heightAnchor.constraint(equalToConstant: 400)
            ])
        })
        
        // Configure back imageview
        add(backImageView, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
                $0.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
                $0.heightAnchor.constraint(equalToConstant: 25),
                $0.widthAnchor.constraint(equalToConstant: 25)
            ])
        })
        
        // Configure name title and value labels
        add(nameTitleLabel, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
                $0.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 16),
                $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
        })
        
        add(characterNameLabel, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
                $0.topAnchor.constraint(equalTo: nameTitleLabel.bottomAnchor, constant: 8),
                $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
        })
        
        // Configure description title and value labels
        add(descriptionTitleLabel, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
                $0.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 16),
                $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
        })
        
        add(characterDescriptionLabel, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
                $0.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 8),
                $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
                $0.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
            ])
        })
    }
    
    @objc
    private func backImageViewTapped() {
        responder.backTapped()
    }
}
