import UIKit

public protocol MarvelNavigationBarDelegate {
    func searchTapped()
}

/// The default navigation bar for the app
public class MarvelNavigationBar: NiblessView {
    
    // MARK: - Views
    private let marvelLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "marvel-logo")
        
        return imageView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Backgrounds.marvelNavigationBar
        
        return view
    }()
    
    private let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic-search")
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    // MARK: - Properties
    public var delegate: MarvelNavigationBarDelegate?
    
    // MARK: - Methods
    public override func configureViewHierarchy() {
        add(backgroundView, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        })
        
        add(marvelLogoImageView, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.heightAnchor.constraint(equalToConstant: 40),
                $0.centerXAnchor.constraint(equalTo: centerXAnchor),
                $0.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
            ])
        })
        
        add(searchImageView, then: {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.heightAnchor.constraint(equalToConstant: 25),
                $0.widthAnchor.constraint(equalToConstant: 25),
                $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
                $0.centerYAnchor.constraint(equalTo: marvelLogoImageView.centerYAnchor)
            ])
        })
    }
    
    public override func viewHierarchyDidConfigure() {
        // Register tap gesture recognizer on search imageview
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchImageViewTapped))
        searchImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func searchImageViewTapped() {
        delegate?.searchTapped()
    }
}
