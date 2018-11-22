
import Cocoa

class POMNotificationHUDWindow: NSWindow {
    
    private class func makeWindow(with text: String) -> NSWindow {
        let window = NSPanel(contentRect: NSMakeRect(0, 0, 200, 200), styleMask: [.hudWindow, .nonactivatingPanel, .borderless], backing: .buffered, defer: false)
        window.hidesOnDeactivate = true
        window.backgroundColor = .clear
        window.hasShadow = false
        window.contentView?.wantsLayer = true
        window.contentView?.layer?.cornerRadius = 20
        
        
        let blurredView = NSVisualEffectView(frame: NSMakeRect(0, 0, 200, 200))
        blurredView.blendingMode = .behindWindow
        blurredView.state = .active
        blurredView.material = .light
        window.contentView?.addSubview(blurredView)
        
        let label = NSTextField(wrappingLabelWithString: text)
        label.isSelectable = false
        label.frame = NSMakeRect(20, 80, 160, 40)
        label.alignment = .center
        label.font = NSFont.systemFont(ofSize: 40)
        label.textColor = NSColor.secondaryLabelColor
        blurredView.addSubview(label)
        
        return window
    }
    
    class func show(with text: String) {
    
        guard NSApp.isActive else { return }
    
        let window = makeWindow(with: text)
        window.center()
        window.makeKeyAndOrderFront(nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(400)) {
            window.animator().alphaValue = 0.5
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(600)) {
            window.close()
            NSApp.hide(nil)
        }
        
    }

}
