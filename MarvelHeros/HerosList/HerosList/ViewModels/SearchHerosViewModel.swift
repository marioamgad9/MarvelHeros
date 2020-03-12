import MarvelHerosKit
import RxSwift
import RxCocoa

/// The view model for SearchHerosViewController
public class SearchHerosViewModel: ViewModelType {
    
    // MARK: - Input & Output
    public let input: SearchHerosViewModel.Input
    public let output: SearchHerosViewModel.Output
    
    public struct Input {
        let searchText = PublishSubject<String>()
        let itemSelected = PublishSubject<IndexPath>()
    }
    
    public struct Output {
        let characters: Driver<[MarvelCharacter]>
        let errorMessage: Observable<ErrorMessage>
        let dismiss: Observable<()>
    }
    
    // MARK: - Subjects
    private let charactersSubject = BehaviorSubject<[MarvelCharacter]>(value: [])
    private let errorMessageSubject = PublishSubject<ErrorMessage>()
    private let dismissSubject = PublishSubject<()>()
    
    // MARK: - Properties
    private let contentRepository: ContentRepository
    private let herosListNavigator: HerosListNavigator
    private let disposeBag = DisposeBag()

    // MARK: - Methods
    public init(contentRepository: ContentRepository,
                herosListNavigator: HerosListNavigator) {
        self.contentRepository = contentRepository
        self.herosListNavigator = herosListNavigator
        
        input = Input()
        output = Output(characters: charactersSubject.asDriver(onErrorJustReturn: []),
                        errorMessage: errorMessageSubject.asObservable(),
                        dismiss: dismissSubject.asObservable())
        
        // Subscribe for input events
        subscribeForSearchTextChanges()
        subscribeForItemSelected()
    }
    
    func characterCellViewModel(for character: MarvelCharacter) -> CharacterTableViewCellViewModel {
        return CharacterTableViewCellViewModel(character: character)
    }
    
    private func reloadCharacters(nameStartsWith searchText: String) {
        contentRepository.getMarvelCharacters(nameStartsWith: searchText, offset: 0).done {
            self.charactersSubject.onNext($0.data.results)
        }.catch(handleError)
    }
    
    private func subscribeForSearchTextChanges() {
        input.searchText.subscribe(onNext: {
            print("TEST - Search text changed: \($0)")
            self.reloadCharacters(nameStartsWith: $0)
        }).disposed(by: disposeBag)
    }
    
    private func subscribeForItemSelected() {
        input.itemSelected
            .subscribe(onNext: {
                let characters = self.getCharactersValue()
                let selectedCharacter = characters[$0.row]
                self.dismissSubject.onNext(())
                self.herosListNavigator.navigate(to: .heroDetails(characterId: selectedCharacter.id))
            }).disposed(by: disposeBag)
    }
    
    private func getCharactersValue() -> [MarvelCharacter] {
        if let value = try? charactersSubject.value() {
            return value
        } else {
            return []
        }
    }
    
    private func handleError(_ error: Error) {
        switch error {
        default:
            errorMessageSubject.onNext(ErrorMessage(title: "error_title.cannot_load_characters".localized,
                                                    message: "error_message.cannot_load_characters".localized))
        }
    }
}
