import Foundation
import PromiseKit

/// Defines how image loading should be
protocol ImageLoader {
    func loadImage(url: URL) -> Promise<UIImage>
}
