
import Foundation

class POMAppController {
    
    private let dockIcon = POMDockIcon()
    private let pomtimer = POMTimer()
    
    func dockIconClicked() {
        pomtimer.start(from: 10.0, tick: 0.5){timer in
            self.dockIcon.text = "\(timer.timeLeft)"
        }
    }
    
}
