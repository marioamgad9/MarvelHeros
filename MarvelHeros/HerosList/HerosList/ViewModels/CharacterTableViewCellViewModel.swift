import UIKit
import MarvelHerosKit
import RxSwift
import RxCocoa

/// The view model for CharacterTableViewCell
class CharacterTableViewCellViewModel: ViewModelType {
    
    // MARK: - Input & Output
    let input: CharacterTableViewCellViewModel.Input
    let output: CharacterTableViewCellViewModel.Output
    
    struct Input {}
    
    struct Output {
        let name: String
        let image: Driver<UIImage>
    }
    
    // MARK: - Properties
    private let imageLoader: ImageLoader
    
    // MARK: - Subjects
    private let imageSubject = PublishSubject<UIImage>()
    
    // MARK: - Methods
    init(character: MarvelCharacter, imageLoader: ImageLoader) {
        self.imageLoader = imageLoader
        input = Input()
        output = Output(name: character.name, image: imageSubject.asDriver(onErrorJustReturn: UIImage()))
        
        if let imageUrl = character.thumbnail.url {
            _ = imageLoader.loadImage(url: imageUrl).done { self.imageSubject.onNext($0) }
        }
    }
}
