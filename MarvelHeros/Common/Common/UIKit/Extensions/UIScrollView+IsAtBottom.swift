import UIKit

extension UIScrollView {
    /// Checks whether the scrollview is at bottom or not
    public var isAtBottom: Bool {
        return contentOffset.y >= -contentInset.top
    }
}
