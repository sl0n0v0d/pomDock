
import Cocoa

class POMDockIconViewBackground: NSView {
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        wantsLayer = true
        layer?.cornerRadius = 10
        layer?.backgroundColor = #colorLiteral(red: 0.8715433478, green: 0.3254662156, blue: 0.276635766, alpha: 1)
        layer?.borderWidth = 1
        layer?.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
    }
}
