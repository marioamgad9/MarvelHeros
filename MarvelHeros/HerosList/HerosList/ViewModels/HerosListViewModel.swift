import MarvelHerosKit
import RxSwift
import RxCocoa

/// The view model for HerosListViewController
public class HerosListViewModel: ViewModelType {
    
    // MARK: - Input & Output
    public let input: HerosListViewModel.Input
    public let output: HerosListViewModel.Output
    
    public struct Input {
        let fetch = PublishSubject<()>()
    }
    
    public struct Output {
        let characters: Observable<MarvelCharactersAPIResponse>
        let errorMessage: Observable<ErrorMessage>
    }
    
    // MARK: - Properties
    private let contentRepository: ContentRepository
    private let disposeBag = DisposeBag()
    
    // MARK: - Subjects
    private let charactersSubject = PublishSubject<MarvelCharactersAPIResponse>()
    private let errorMessageSubject = PublishSubject<ErrorMessage>()
    
    // MARK: - Initializer
    public init(contentRepository: ContentRepository) {
        self.contentRepository = contentRepository
        
        input = Input()
        output = Output(characters: charactersSubject.asObservable(),
                        errorMessage: errorMessageSubject.asObservable())
        
        subscribeForFetch()
    }
    
    // MARK: - Methods
    private func subscribeForFetch() {
        input.fetch.subscribe(onNext: {
            self.reloadCharacters()
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
