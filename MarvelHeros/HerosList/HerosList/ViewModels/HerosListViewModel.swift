import MarvelHerosKit
import RxSwift
import RxCocoa
import PromiseKit

/// The view model for HerosListViewController
public class HerosListViewModel: ViewModelType {
    
    // MARK: - Input & Output
    public let input: HerosListViewModel.Input
    public let output: HerosListViewModel.Output
    
    public struct Input {
        let fetch = PublishSubject<()>()
        let searchButtonTapped = PublishSubject<()>()
        let itemSelected = PublishSubject<IndexPath>()
    }
    
    public struct Output {
        let characters: Driver<[MarvelCharacter]>
        let isLoading: Driver<Bool>
        let errorMessage: Observable<ErrorMessage>
    }
    
    // MARK: - Properties
    private let contentRepository: ContentRepository
    private let herosListNavigator: HerosListNavigator
    private let disposeBag = DisposeBag()
    
    // MARK: - Subjects
    private let charactersSubject = BehaviorSubject<[MarvelCharacter]>(value: [])
    private let isLoadingSubject = BehaviorSubject<Bool>(value: false)
    private let errorMessageSubject = PublishSubject<ErrorMessage>()
    
    // MARK: - Methods
    public init(contentRepository: ContentRepository,
                herosListNavigator: HerosListNavigator) {
        self.contentRepository = contentRepository
        self.herosListNavigator = herosListNavigator
        
        input = Input()
        output = Output(characters: charactersSubject.asDriver(onErrorJustReturn: []),
                        isLoading: isLoadingSubject.asDriver(onErrorJustReturn: false),
                        errorMessage: errorMessageSubject.asObservable())
        
        subscribeForSearchButtonTapped()
        subscribeForFetch()
        subscribeForItemSelected()
    }
    
    func characterCellViewModel(for character: MarvelCharacter) -> CharacterTableViewCellViewModel {
        return CharacterTableViewCellViewModel(character: character)
    }
    
    private func subscribeForSearchButtonTapped() {
        input.searchButtonTapped.subscribe(onNext: {
            self.herosListNavigator.navigate(to: .searchHeros)
        }).disposed(by: disposeBag)
    }
    
    private func subscribeForFetch() {
        input.fetch
            .withLatestFrom(Observable.combineLatest(output.isLoading.asObservable(), output.characters.asObservable()))
            .subscribe(onNext: { (isLoading, characters) in
                guard !isLoading else { return }
                self.reloadCharacters(offsetBy: characters.count)
        }).disposed(by: disposeBag)
    }
    
    private func subscribeForItemSelected() {
        input.itemSelected
            .subscribe(onNext: {
                let characters = self.getCharactersValue()
                let selectedCharacter = characters[$0.row]
                self.herosListNavigator.navigate(to: .heroDetails(characterId: selectedCharacter.id))
            }).disposed(by: disposeBag)
    }
    
    private func reloadCharacters(offsetBy offset: Int) {
        isLoadingSubject.onNext(true)
        contentRepository.getMarvelCharacters(nameStartsWith: nil, offset: offset).done {
            self.charactersSubject.onNext(self.getCharactersValue() + $0.data.results)
        }
        .catch(handleError)
        .finally {
            self.isLoadingSubject.onNext(false)
        }
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
