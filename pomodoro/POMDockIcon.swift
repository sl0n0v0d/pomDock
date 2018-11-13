
import AppKit

class POMDockIcon {
    
    // Text shown on dock icon
    var text: String? {
        didSet {
            dockIconView.text = text
            dockIconView.show()
        }
    }
    
    var time: Double? {
        didSet {
            dockIconView.time = time
            dockIconView.show()
        }
    }
    
    private let dockIconView = POMDockIconView()
    private var observerToken: Any!
    
    init() {
        let darkModeNotificationName = NSNotification.Name(rawValue: "AppleInterfaceThemeChangedNotification")
        observerToken = DistributedNotificationCenter.default().addObserver(forName: darkModeNotificationName,
                                                                            object: nil, queue: nil) { _ in
                                                                                self.dockIconView.show()
        }
        waitFocus()
    }
    
    deinit {
        DistributedNotificationCenter.default().removeObserver(observerToken)
    }
    
    func waitFocus(){
        dockIconView.dockIconViewBackground.colorMode = .focused
        dockIconView.text = "Focus"
        dockIconView.show()
    }
    
    func waitDiffuse() {
        dockIconView.dockIconViewBackground.colorMode = .diffused
        dockIconView.text = "Diffuse"
        dockIconView.show()
    }
}
