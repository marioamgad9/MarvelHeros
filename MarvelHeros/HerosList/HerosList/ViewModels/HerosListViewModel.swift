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
    private let charactersSubject = PublishSubject<MarvelCharactersAPIResponse>()
    private let isLoadingSubject = PublishSubject<Bool>()
    private let errorMessageSubject = PublishSubject<ErrorMessage>()
    
    // MARK: - Initializer
    public init(contentRepository: ContentRepository,
                herosListNavigator: HerosListNavigator) {
        self.contentRepository = contentRepository
        self.herosListNavigator = herosListNavigator
        
        input = Input()
        output = Output(characters: charactersSubject
            .map({$0.data.results})
            .asDriver(onErrorJustReturn: []),
                        isLoading: isLoadingSubject.asDriver(onErrorJustReturn: false),
                        errorMessage: errorMessageSubject.asObservable())
        
        subscribeForFetch()
        subscribeForCharactersSubjectToUpdateIsLoading()
    }
    
    // MARK: - Methods
    func characterCellViewModel(for character: MarvelCharacter) -> CharacterTableViewCellViewModel {
        return CharacterTableViewCellViewModel(character: character)
    }
    
    private func subscribeForFetch() {
        input.fetch.subscribe(onNext: {
            self.isLoadingSubject.onNext(true)
            self.reloadCharacters()
        }).disposed(by: disposeBag)
    }
    
    private func subscribeForCharactersSubjectToUpdateIsLoading() {
        charactersSubject.subscribe(onNext: { _ in
            self.isLoadingSubject.onNext(false)
        }).disposed(by: disposeBag)
    }
    
    private func reloadCharacters() {
        contentRepository.getMarvelCharacters(nameStartsWith: nil, offset: 0).done {
            self.charactersSubject.onNext($0)
        }.catch(handleError)
    }
    
    private func handleError(_ error: Error) {
        switch error {
        default:
            errorMessageSubject.onNext(ErrorMessage(title: "error_title.cannot_load_characters".localized,
                                                    message: "error_message.cannot_load_characters".localized))
        }
    }
}
