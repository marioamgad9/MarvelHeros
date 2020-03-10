import UIKit

extension UIFont {
    private static func getCustomFont(name: String, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: name, size: size) else {
            fatalError("Failed to load the \(name) font")
        }
        
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        
        return fontMetrics.scaledFont(for: customFont)
    }
    
    public static func light(size: FontSize) -> UIFont {
        return getCustomFont(name: FontNames.light,
                             size: CGFloat(size.rawValue))
    }
    
    public static func regular(size: FontSize) -> UIFont {
        return getCustomFont(name: FontNames.regular,
                             size: CGFloat(size.rawValue))
    }
    
    public static func semiBold(size: FontSize) -> UIFont {
        return getCustomFont(name: FontNames.semiBold,
                             size: CGFloat(size.rawValue))
    }
    
    public static func bold(size: FontSize) -> UIFont {
        return getCustomFont(name: FontNames.bold,
                             size: CGFloat(size.rawValue))
    }
}

