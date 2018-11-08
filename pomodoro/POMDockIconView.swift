
import Cocoa

class POMDockIconView {
    
    private let appDockTile =  NSApplication.shared.dockTile
    
    @IBOutlet var dockIconView: NSView!
    @IBOutlet var dockIconLabel: NSTextField!
    
    // Text shown on dock icon (one line)
    var text: String? {
        didSet {
            dockIconLabel.textColor = #colorLiteral(red: 0.9857949611, green: 0.9857949611, blue: 0.9857949611, alpha: 1)
            dockIconLabel.stringValue = "\(text ?? "")"
            let fontHeight = fontSizeToFitIconSize(dockIconView!.bounds.size)
            dockIconLabel.font = NSFont.systemFont(ofSize: fontHeight) // Set font height by re-setting font
            refreshDockIcon()
        }
    }
    
    var time: Double? {
        didSet {
            guard let time = time else {
                return
            }
            
            let fontSize = fontSizeFitting(time: time)
            
            // Set font height by re-setting font
            dockIconLabel.font = NSFont.monospacedDigitSystemFont(ofSize: CGFloat(fontSize), weight: .regular)
            
            dockIconLabel.stringValue = clockTime(from: time)
            refreshDockIcon()
        }
    }
    
    required init() {
        let bundle = Bundle(for: type(of: self))
        let nib = NSNib(nibNamed: .init(String(describing: type(of: self))), bundle: bundle)!
        _ = nib.instantiate(withOwner: self, topLevelObjects: nil)
        appDockTile.contentView = dockIconView
    }
    
    private func clockTime(from seconds: Double) -> String {
        let minutes = String(format:"%02.0f",(seconds/60.0).rounded(.down))
        let seconds = String(format:"%02.0f",seconds.truncatingRemainder(dividingBy: 60))
        let result = minutes + ":" + seconds
        
        return result
    }
    
    private func fontSizeFitting(time: Double) -> CGFloat {
        let targetWidth = dockIconView!.bounds.size.width
        let minFontSize = 10
        let maxFontSize = 100
        
        let minutes = time / 60
        var widestPossibleTime = "0"
        
        switch minutes {
        case 0..<100:
            widestPossibleTime = "44:44"
        case 100...:
            widestPossibleTime = "444:44"
        default:
            fatalError()
        }
        
        var result = minFontSize
        
        for fs in minFontSize...maxFontSize {
            let rect = widestPossibleTime.boundingRect(with: dockIconView!.bounds.size, options: .usesDeviceMetrics, attributes: [NSAttributedString.Key.font:NSFont.monospacedDigitSystemFont(ofSize: CGFloat(fs), weight: .black)]) //systemFont(ofSize: CGFloat(fs))])
            
            if (rect.width >= targetWidth) {
                break
            } else {
                result = fs
            }
        }
        
        return CGFloat(result)
    }
    
    // Calculation is valid only for one line
    private func fontSizeToFitIconSize(_ size:NSSize) -> CGFloat {
        let targetWidth = size.width - size.width / 5
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
    
    private func refreshDockIcon() {
        appDockTile.display()
    }
}
