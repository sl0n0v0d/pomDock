
import Foundation

class POMDockIcon {
    
    // Text shown on dock icon
    var text: String? {
        didSet {
            dockIconView.text = text
        }
    }
    
    var time: Double? {
        didSet {
            dockIconView.time = time
        }
    }
    
    private let dockIconView = POMDockIconView()
    
    init() {
        waitFocus()
    }
    
    func waitFocus(){
        dockIconView.dockIconViewBackground.layer?.backgroundColor = #colorLiteral(red: 0.8715433478, green: 0.3254662156, blue: 0.276635766, alpha: 1)
        dockIconView.text = "Focus"
    }
    
    func waitDiffuse() {
        dockIconView.dockIconViewBackground.layer?.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        dockIconView.text = "Diffuse"
    }
}
