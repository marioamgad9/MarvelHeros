import UIKit

/// Font names used in the app. (These are just the names, to access the fonts, check UIFont+Extensions)
struct FontNames {
    static let light = "Cairo-Light"
    static let regular = "Cairo-Regular"
    static let semiBold = "Cairo-SemiBold"
    static let bold = "Cairo-Bold"
}

/// Available font sizes
public enum FontSize: Int {
    case micro = 10
    case small = 12
    case normal = 14
    case big = 16
    case huge = 18
}
