
import Cocoa

class POMUserAttentionGrabber {
    
    var timer: Timer? = nil
    
    func appModeChanged(to mode:PomodoroMode) {
        switch mode {
        case .waitingFocus, .waitingDiffuse:
            let attentionId = NSApp.requestUserAttention(.informationalRequest)
            timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (timer) in
                NSApp.cancelUserAttentionRequest(attentionId)
                NSApp.requestUserAttention(.informationalRequest)
            })
        case .focused, .diffused:
            timer?.invalidate()
        }
    }
}
