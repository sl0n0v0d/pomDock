
import Cocoa

class POMUserAttentionGrabber {
    func appModeChanged(to mode:PomodoroMode) {
        switch mode {
        case .waitingFocus, .waitingDiffuse:
            print("start attention grabbing: informationalRequest")
            NSApp.requestUserAttention(.informationalRequest)
        case .focused, .diffused:
            print("finish attention grabbing")
            NSApp.requestUserAttention(.criticalRequest)
        }
    }
}
