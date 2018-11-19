
import Cocoa

@NSApplicationMain
class POMAppDelegate: NSObject, NSApplicationDelegate {
    
    private let appController = POMAppController()
    
    func applicationDidBecomeActive(_ notification: Notification) {
        // give focus back to previously active app
        appController.appActivated()
        NSApp.hide(self)
        NSApp.deactivate()
    }
    
     func applicationDidFinishLaunching(_ notification: Notification) {
        // give focus back to previously active app
        NSApp.hide(self)
    }
    
    func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
        let dockMenu = POMDockMenu()
        dockMenu.pomMenuDelegate = appController
        return dockMenu
    }
}
