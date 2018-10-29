
import Cocoa

protocol DockMenuDelegate: class {
    func dockMenuCancelAction()
}

class POMDockMenu: NSMenu {

    weak var pomDelegate: DockMenuDelegate?

    init() {
        super.init(title: "")
        self.addItem(withTitle: "Cancel", action: #selector(didSelectCancelItem), keyEquivalent: "").target = self
    }
    
    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didSelectCancelItem() {
        pomDelegate?.dockMenuCancelAction()
    }
}
