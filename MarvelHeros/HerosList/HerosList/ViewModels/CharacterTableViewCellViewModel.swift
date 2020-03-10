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
        let imageURL: URL?
    }
    
    // MARK: - Subjects
    private let imageSubject = PublishSubject<UIImage>()
    
    // MARK: - Methods
    init(character: MarvelCharacter) {
        input = Input()
        output = Output(name: character.name, imageURL: character.thumbnail.url)
    }
}
