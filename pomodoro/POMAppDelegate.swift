
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
        
        appController.dockIconClicked()
        NSApp.hide(self)
        
        return false
    }
    
    func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
        let dockMenu = POMDockMenu()
        dockMenu.pomMenuDelegate = appController
        return dockMenu
    }
}
