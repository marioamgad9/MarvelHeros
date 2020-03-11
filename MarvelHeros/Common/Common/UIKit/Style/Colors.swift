import UIKit

/// Holds all the colors used by the app
public struct Colors {
    /// Holds all background colors
    public struct Backgrounds {
        public static let marvelNavigationBar = UIColor(named: "background-marvel-navigation-bar")!
        public static let marvelCharacterName = UIColor(named: "background-marvel-character-name")!
        public static let searchCharacter = UIColor(named: "background-search-character")!
        public static let main = UIColor(named: "background-main")!
    }
    
    /// Holds all text colors
    public struct Text {
        public static let marvelCharacterName = UIColor(named: "text-marvel-character-name")!
        public static let navigationBarButton = UIColor(named: "text-navigation-bar-button")!
    }
}
