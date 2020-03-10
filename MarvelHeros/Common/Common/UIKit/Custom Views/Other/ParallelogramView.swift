import UIKit

public class ParallelogramView: UIView {
    
    // MARK: - Properties
    public var offset:    CGFloat = 30 { didSet { setNeedsDisplay() } }
    public var fillColor: UIColor = Colors.Backgrounds.marvelCharacterName { didSet { setNeedsDisplay() } }
    
    // MARK: - Methods
    public override func draw(_ rect: CGRect) {
        let path = UIBezierPath()

        path.move(to: CGPoint(x: bounds.minX + offset, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX - offset, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))

        // Close the path. This will create the last line automatically.
        path.close()
        fillColor.setFill()
        path.fill()
    }
}
