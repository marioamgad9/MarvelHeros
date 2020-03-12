import UIKit
import MarvelHerosKit

/// The view model for HeroDetailsHeader
class HeroDetailsHeaderViewModel: ViewModelType {
    
    // MARK: - Input & Output
    let input: HeroDetailsHeaderViewModel.Input
    let output: HeroDetailsHeaderViewModel.Output
    
    struct Input {}
    
    struct Output {
        let name: String
        let description: String
        let imageURL: URL?
    }
    
    // MARK: - Methods
    init(character: MarvelCharacter) {
        input = Input()
        output = Output(name: character.name, description: character.description, imageURL: character.thumbnail.url)
    }
}
