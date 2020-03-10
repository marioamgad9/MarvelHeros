import Foundation

/// Defines how navigation should work in HerosList
public protocol HerosListNavigator {
    func navigate(to view: HerosListViewState)
}
