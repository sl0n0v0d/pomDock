
import Foundation

enum PomodoroMode {
    case waitingFocus
    case waitingDiffuse
    case focused
    case diffused
    
    var isIdle: Bool {
        switch self {
        case .waitingFocus, .waitingDiffuse:
            return true
        case .focused, .diffused:
            return false
        }
    }
}

class POMAppController {
    
    private let dockIcon = POMDockIcon()
    private let pomtimer = POMTimer()
    private let attentionGrabber = POMUserAttentionGrabber()
    
    private var appMode:PomodoroMode = PomodoroMode.waitingFocus {
        didSet {
            attentionGrabber.appModeChanged(to: appMode)
        }
    }
    
    func dockIconClicked() {
        switch appMode {
        case .waitingDiffuse:
            diffuseMode()
        case .waitingFocus:
            focusMode()
        case .focused, .diffused:
            break
        }
    }
    
    private func handleTick(_ timer: POMTimer) {
        if appMode.isIdle {
            Log.info("Timer ticked in idle mode, ignoring")
            return
        }
        
        if timer.timeLeft < 0 {
            timerFinished(timer)
        } else {
            self.dockIcon.text = "\(timer.timeLeft)"
        }
    }
    
    private func focusMode() {
        appMode = .focused
        pomtimer.start(from: 2.0, tick: 0.5) { timer in
            self.handleTick(timer)
        }
    }
    
    private func diffuseMode() {
        appMode = .diffused
        pomtimer.start(from: 1.0, tick: 0.5) { timer in
            self.handleTick(timer)
        }
    }
    
    private func waitFocusMode() {
        appMode = .waitingFocus
        dockIcon.waitFocus()
    }
    
    private func waitDiffuseMode() {
        appMode = .waitingDiffuse
        dockIcon.waitDiffuse()
    }
    
    private func timerFinished(_ timer: POMTimer) {
        timer.stop()
        
        switch appMode {
        case .diffused:
            waitFocusMode()
        case .focused:
            waitDiffuseMode()
        case .waitingFocus, .waitingDiffuse:
            break
        }
    }
}

