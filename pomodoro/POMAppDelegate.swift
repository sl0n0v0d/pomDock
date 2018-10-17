
import Cocoa

@NSApplicationMain
class POMAppDelegate: NSObject, NSApplicationDelegate {
    
    private let appController = POMAppController()
    
    private var time:DispatchTime!
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        appController.dockIconClicked()

        return true
    }
    
}
