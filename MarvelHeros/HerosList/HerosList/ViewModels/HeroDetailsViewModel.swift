import MarvelHerosKit
import RxSwift
import RxCocoa

/// The viewmodel for HeroDetailsViewController
public class HeroDetailsViewModel: ViewModelType {
    
    // MARK: - Input & Output
    public let input: HeroDetailsViewModel.Input
    public let output: HeroDetailsViewModel.Output
    
    public struct Input {
        let fetch = PublishSubject<()>()
    }
    
    public struct Output {
        let character: Driver<MarvelCharacter>
        let comics: Driver<[Comic]>
        let series: Driver<[Series]>
        let isLoading: Driver<Bool>
        let errorMessage: Observable<ErrorMessage>
    }
    
    // MARK: - Properties
    private let characterId: Int
    private let contentRepository: ContentRepository
    private let disposeBag = DisposeBag()
    
    // MARK: - Subjects
    private let characterSubject = PublishSubject<MarvelCharacter>()
    private let comicsSubject = PublishSubject<[Comic]>()
    private let seriesSubject = PublishSubject<[Series]>()
    private let isLoadingSubject = BehaviorSubject<Bool>(value: false)
    private let errorMessageSubject = PublishSubject<ErrorMessage>()
    
    // MARK: - Methods
    public init(characterId: Int, contentRepository: ContentRepository) {
        self.characterId = characterId
        self.contentRepository = contentRepository
        
        input = Input()
        output = Output(character: characterSubject.asDriver(onErrorJustReturn: MarvelCharacter.empty),
                        comics: comicsSubject.asDriver(onErrorJustReturn: []),
                        series: seriesSubject.asDriver(onErrorJustReturn: []),
                        isLoading: isLoadingSubject.asDriver(onErrorJustReturn: false),
                        errorMessage: errorMessageSubject.asObservable())
        
        subscribeForFetch()
    }
    
    private func subscribeForFetch() {
        input.fetch
            .subscribe(onNext: {
                self.reloadCharacterDetails()
                self.loadComics()
                self.loadSeries()
        }).disposed(by: disposeBag)
    }
    
    private func reloadCharacterDetails() {
        isLoadingSubject.onNext(true)
        contentRepository.getMarvelCharacterDetails(id: characterId).done {
            self.characterSubject.onNext($0.data.results.first ?? .empty)
        }
        .catch(handleError)
        .finally {
            self.isLoadingSubject.onNext(false)
        }
    }
    
    private func loadComics() {
        contentRepository.getComicsForCharacter(id: characterId).done {
            self.comicsSubject.onNext($0.data.results)
        }.catch(handleError)
    }
    
    private func loadSeries() {
        contentRepository.getSeriesForCharacter(id: characterId).done {
            self.seriesSubject.onNext($0.data.results)
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
