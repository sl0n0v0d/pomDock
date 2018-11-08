
import Cocoa

protocol DockMenuDelegate: class {
    func cancelAction()
}

class POMDockMenu: NSMenu {

    weak var pomMenuDelegate: DockMenuDelegate?

    init() {
        super.init(title: "")
        self.addItem(withTitle: "Pomodoros today: \(POMStatistics.finishedPomodorosToday())", action: nil, keyEquivalent: "")
        self.addItem(withTitle: "Cancel", action: #selector(didSelectCancelItem), keyEquivalent: "").target = self
    }
    
    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didSelectCancelItem() {
        pomMenuDelegate?.cancelAction()
    }
}
