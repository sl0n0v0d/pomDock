
import Cocoa

class POMUserAttentionGrabber {
    
    var timer: Timer? = nil
    
    func appModeChanged(to mode:PomodoroMode) {
        switch mode {
        case .waitingFocus, .waitingDiffuse:
        
            POMNotificationHUDWindow.show(with: "Idle...")
        
            // icon jump with interval
            let attentionId = NSApp.requestUserAttention(.informationalRequest)
            timer = Timer.scheduledTimer(withTimeInterval: Config.shared.grabAttentionInterval, repeats: true, block: { (timer) in
                NSApp.cancelUserAttentionRequest(attentionId)
                NSApp.requestUserAttention(.informationalRequest)
            })
        case .focused:
            POMNotificationHUDWindow.show(with: "Focus!")
            timer?.invalidate()
        case .diffused:
            POMNotificationHUDWindow.show(with: "Diffuse.")
            timer?.invalidate()
        }
    }
}
