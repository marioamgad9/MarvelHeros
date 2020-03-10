import Foundation

extension String {
    ///Gets a localized string from Localizable.strings
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
