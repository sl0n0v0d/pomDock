
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

class POMAppController: DockMenuDelegate {

    private let dockIcon = POMDockIcon()
    private let pomtimer = POMTimer()
    private let attentionGrabber = POMUserAttentionGrabber()
    
    private var appMode:PomodoroMode = PomodoroMode.waitingFocus {
        didSet {
            attentionGrabber.appModeChanged(to: appMode)
        }
    }
    
    //MARK: - Mode setters
    
    private func focusMode() {
        appMode = .focused
        pomtimer.start(from: Config.focusTime, tick: Config.tickInterval) { timer in
            self.handleTick(timer)
        }
    }
    
    private func diffuseMode() {
        appMode = .diffused
        pomtimer.start(from: Config.diffuseTime, tick: Config.tickInterval) { timer in
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
    
    //MARK: - Events
    
    func dockIconClicked() {
        switch appMode {
        case .waitingDiffuse:
            diffuseMode()
        case .waitingFocus:
            focusMode()
        case .diffused:
            pomtimer.stop()
            waitFocusMode()
        case .focused:
            pomtimer.paused ? pomtimer.resume() : pomtimer.pause()
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
            self.dockIcon.time = timer.timeLeft
        }
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
    
    func dockMenuCancelAction() {
        switch appMode {
        case .waitingDiffuse, .waitingFocus:
            break
        case .diffused:
            pomtimer.stop()
            waitFocusMode()
        case .focused:
            pomtimer.stop()
            waitDiffuseMode()
        }
    }
}
