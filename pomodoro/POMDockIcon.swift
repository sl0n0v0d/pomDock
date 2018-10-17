
import Foundation

class POMDockIcon {
    
    private let dockIconView = POMDockIconView()
    
    // Text shown on dock icon
    var text: String? {
        didSet {
            dockIconView.text = text
        }
    }
    
    init() {
        dockIconView.text = "Start"
    }
}
