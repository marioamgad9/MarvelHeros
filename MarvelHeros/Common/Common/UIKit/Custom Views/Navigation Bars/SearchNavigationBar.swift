import UIKit

/// The navigation bar that handles showing search textfield
public class SearchNavigationBar: NiblessView {
    
    // MARK: - Views
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Backgrounds.marvelNavigationBar
        return view
    }()
    
    public let searchTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.regular(size: .normal)
        textField.backgroundColor = .clear
        textField.attributedPlaceholder = NSAttributedString(string: "placeholder.search_characters".localized,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textField
    }()
    
    private let searchTextFieldBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Dimens.cornerRadius
        view.clipsToBounds = true
        return view
    }()
    
    private let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "ic-search")!
        imageView.image = image.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .gray
        return imageView
    }()
    
    public let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Colors.Text.navigationBarButton, for: .normal)
        button.titleLabel?.font = UIFont.semiBold(size: .normal)
        button.setTitle("btn.cancel".localized, for: .normal)
        return button
    }()
    
    // MARK: - Methods
    public override func configureViewHierarchy() {
        // Configure search textfield
        searchTextFieldBackground.add(searchImageView, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.heightAnchor.constraint(equalToConstant: 15),
                $0.widthAnchor.constraint(equalToConstant: 15),
                $0.leadingAnchor.constraint(equalTo: searchTextFieldBackground.leadingAnchor, constant: 16),
                $0.topAnchor.constraint(equalTo: searchTextFieldBackground.topAnchor, constant: 8),
                $0.bottomAnchor.constraint(equalTo: searchTextFieldBackground.bottomAnchor, constant: -8)
            ])
        })
        
        searchTextFieldBackground.add(searchTextField, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: searchImageView.trailingAnchor, constant: 8),
                $0.topAnchor.constraint(equalTo: searchTextFieldBackground.topAnchor, constant: 8),
                $0.bottomAnchor.constraint(equalTo: searchTextFieldBackground.bottomAnchor, constant: -8),
                $0.trailingAnchor.constraint(equalTo: searchTextFieldBackground.trailingAnchor, constant: -16)
            ])
        })
        
        backgroundView.add(searchTextFieldBackground, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                $0.topAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.topAnchor, constant: 8),
                $0.bottomAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.bottomAnchor, constant: -8)
            ])
        })
        
        // Configure cancel button
        backgroundView.add(cancelButton, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: searchTextFieldBackground.safeAreaLayoutGuide.trailingAnchor, constant: 16),
                $0.topAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.topAnchor, constant: 8),
                $0.bottomAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
                $0.trailingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
        })
        
        // Configure background view
        addAndConstraintToEdges(backgroundView, withSpacing: 0)
    }
}
