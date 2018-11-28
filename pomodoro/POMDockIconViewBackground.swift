
import Cocoa

class POMDockIconViewBackground: NSView {
    
    enum ColorMode {
        case focused
        case diffused
    }
    
    var colorMode = ColorMode.focused {
        didSet {
            refresh()
        }
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        wantsLayer = true
        layer?.cornerRadius = 10
        layer?.borderWidth = 0.5
        layer?.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
    }
    
    override func updateLayer() {
        refresh()
    }
    
    private func refresh() {
        switch colorMode {
        case .focused:
            if NSAppearance.isDarkMode {
                layer?.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            } else {
                layer?.backgroundColor = #colorLiteral(red: 0.8715433478, green: 0.3254662156, blue: 0.276635766, alpha: 1)
            }
        case .diffused:
            if NSAppearance.isDarkMode {
                layer?.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            } else {
                layer?.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }
        }
    }
}
