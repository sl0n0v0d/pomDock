
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
    
    private func setFocusMode() {
        appMode = .focused
        pomtimer.start(from: Config.shared.focusTime, tick: Config.shared.tickInterval) { timer in
            self.handleTick(timer)
        }
    }
    
    private func setDiffuseMode() {
        appMode = .diffused
        pomtimer.start(from: Config.shared.diffuseTime, tick: Config.shared.tickInterval) { timer in
            self.handleTick(timer)
        }
    }
    
    private func setWaitFocusMode() {
        appMode = .waitingFocus
        dockIcon.waitFocus()
    }
    
    private func setWaitDiffuseMode() {
        appMode = .waitingDiffuse
        dockIcon.waitDiffuse()
    }
    
    //MARK: - Events
    
    func dockIconClicked() {
        switch appMode {
        case .waitingDiffuse:
            setDiffuseMode()
        case .waitingFocus:
            setFocusMode()
        case .diffused:
            pomtimer.stop()
            setWaitFocusMode()
        case .focused:
            if pomtimer.paused {
                pomtimer.resume()
            } else {
                pomtimer.pause()
                let answer = POMModalQuestion.dialogYesNo(question: "Cancel current interval?")
                if answer == true {
                    cancelAction()
                } else {
                    pomtimer.resume()
                }
            }
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
            setWaitFocusMode()
        case .focused:
            POMStatistics.pomodoroDone()
            setWaitDiffuseMode()
        case .waitingFocus, .waitingDiffuse:
            break
        }
    }
    
    func cancelAction() {
        pomtimer.stop()
        
        switch appMode {
        case .waitingDiffuse, .waitingFocus:
            break
        case .diffused, .focused:
            setWaitFocusMode()
        }
    }
}
