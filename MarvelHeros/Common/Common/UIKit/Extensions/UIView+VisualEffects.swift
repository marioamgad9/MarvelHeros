import UIKit

extension UIView {
    /// Adds a blur visual effect
    public func addBlurEffect(style: UIBlurEffect.Style = .dark) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
    
    public func addShadeEffect(opacity: CGFloat = 0.7) {
        let shadeView = UIView()
        shadeView.backgroundColor = .black
        shadeView.alpha = opacity
        shadeView.frame = bounds
        shadeView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(shadeView)
    }
}
