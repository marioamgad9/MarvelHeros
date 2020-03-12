import UIKit
import MarvelHerosKit

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
    
    // MARK: - Methods
    init(character: MarvelCharacter) {
        input = Input()
        output = Output(name: character.name, imageURL: character.thumbnail.getUrl(quality: .landscapeIncredible))
    }
}
