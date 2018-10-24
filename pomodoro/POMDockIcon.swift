
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
        dockIconView.text = "Focus"
    }
    
    func waitDiffuse() {
        dockIconView.text = "Diffuse"
    }
}
