import Foundation

/// Represents the states a HerosList view can be in
public enum HerosListViewState {
    case herosList
    case heroDetails(characterId: Int)
}
