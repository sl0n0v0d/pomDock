
import Cocoa

@NSApplicationMain
class POMAppDelegate: NSObject, NSApplicationDelegate {
    
    private let appController = POMAppController()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // give focus back to previously active app
        NSApp.hide(self)
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        // give focus back to previously active app
        NSApp.hide(self)
        appController.dockIconClicked()
        
        return false
    }
    
    func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
        let dockMenu = POMDockMenu()
        dockMenu.pomDelegate = appController
        return dockMenu
    }
}
