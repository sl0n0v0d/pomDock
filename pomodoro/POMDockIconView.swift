
import Cocoa

class POMDockIconView {
    
    private let appDockTile =  NSApplication.shared.dockTile
    
    @IBOutlet var dockIconView: NSView!
    @IBOutlet var dockIconLabel: NSTextField!
    
    // Text shown on dock icon
    var text: String? {
        didSet {
            dockIconLabel.stringValue = "\(text ?? "")"
            let fontHeight = fontSizeToFitIconSize(dockIconView!.bounds.size)
            dockIconLabel.font = NSFont.systemFont(ofSize: fontHeight) // Set font height by re-setting font
            refreshDockIcon()
        }
    }
    
    required init() {
        let bundle = Bundle(for: type(of: self))
        let nib = NSNib(nibNamed: .init(String(describing: type(of: self))), bundle: bundle)!
        _ = nib.instantiate(withOwner: self, topLevelObjects: nil)
        appDockTile.contentView = dockIconView
    }
    
    private func refreshDockIcon() {
        appDockTile.display()
    }
    
    // Calculation is valid only for one line
    private func fontSizeToFitIconSize(_ size:NSSize) -> CGFloat {
        let targetWidth = size.width - size.width / 4
        let minFontSize = 20
        let maxFontSize = 100
        
        var result = minFontSize
        for fs in minFontSize...maxFontSize {
            let rect = dockIconLabel.stringValue.boundingRect(with: size, options: .usesDeviceMetrics, attributes: [NSAttributedString.Key.font:NSFont.systemFont(ofSize: CGFloat(fs))])
            
            if (rect.width >= targetWidth) {
                break
            } else {
                result = fs
            }
        }
        
        return CGFloat(result)
        
    }
}
