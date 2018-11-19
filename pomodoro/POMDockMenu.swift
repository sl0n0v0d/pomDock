
import Cocoa

protocol DockMenuDelegate: class {
    func cancelAction()
    func diffuseAction()
}

class POMDockMenu: NSMenu {
    
    weak var pomMenuDelegate: DockMenuDelegate?
    
    private var pomodoroIntervalsMinutes: [String] {
        get {
            #if DEBUG
            return ["0.05", "5", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55", "60"]
            #else
            return ["5", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55", "60"]
            #endif
        }
    }
    
    private var diffuseIntervalsMinutes: [String] {
        get {
            #if DEBUG
            return ["0.033", "5", "10", "15", "20", "25", "30"]
            #else
            return ["5", "10", "15", "20", "25", "30"]
            #endif
        }
    }
    
    init() {
        super.init(title: "")
        
        self.addItem(withTitle: "Pomodoros today: \(POMStatistics.finishedPomodorosToday())", action: nil, keyEquivalent: "")
        
        self.addItem(withTitle: "Cancel", action:#selector(didSelectCancelItem), keyEquivalent: "").target = self
        
        self.addItem(withTitle: "Diffuse", action:#selector(didSelectDiffuseItem), keyEquivalent: "").target = self
        
        // pomodoro time interval submenu
        let setPomodoroIntervalMenu = NSMenu()
        let currentFocusIntervalMinutes = Config.shared.focusTime / 60
        for intervalMinutes in pomodoroIntervalsMinutes {
            var intervalMinutesString = "\(intervalMinutes)"
            if currentFocusIntervalMinutes == Double(intervalMinutes) {
                intervalMinutesString += " ✓"
            }
            setPomodoroIntervalMenu.addItem(withTitle: intervalMinutesString,
                                            action:  #selector(didSelectPomodoroInterval),
                                            keyEquivalent: "").target = self
        }
        let pomodoroTimeSubmenu = self.addItem(withTitle: "Pomodoro Minutes", action: nil, keyEquivalent: "")
        self.setSubmenu(setPomodoroIntervalMenu, for: pomodoroTimeSubmenu)
        
        // diffuse time interval submenu
        let setDiffuseIntervalMenu = NSMenu()
        let currentDiffuseIntervalMinutes = Config.shared.diffuseTime / 60
        for intervalMinutes in diffuseIntervalsMinutes {
            var intervalMinutesString = "\(intervalMinutes)"
            if currentDiffuseIntervalMinutes == Double(intervalMinutes) {
                intervalMinutesString += " ✓"
            }
            setDiffuseIntervalMenu.addItem(withTitle: intervalMinutesString,
                                           action:  #selector(didSelectDiffuseInterval),
                                           keyEquivalent: "").target = self
        }
        let diffuseTimeSubmenu = self.addItem(withTitle: "Diffuse Minutes", action: nil, keyEquivalent: "")
        self.setSubmenu(setDiffuseIntervalMenu, for: diffuseTimeSubmenu)
    }
    
    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didSelectDiffuseInterval(sender: NSMenuItem) {
        if let intervalMinutes = Double(sender.title), intervalMinutes > 0 {
            Config.shared.diffuseTime = intervalMinutes * 60
        }
    }
    
    @objc private func didSelectPomodoroInterval(sender: NSMenuItem) {
        if let intervalMinutes = Double(sender.title), intervalMinutes > 0 {
            Config.shared.focusTime = intervalMinutes * 60
        }
    }
    
    @objc private func didSelectCancelItem() {
        pomMenuDelegate?.cancelAction()
    }
    
    @objc private func didSelectDiffuseItem() {
        pomMenuDelegate?.diffuseAction()
    }
}
