
import Cocoa

@NSApplicationMain
class POMAppDelegate: NSObject, NSApplicationDelegate {
    
    private let appController = POMAppController()
    
    func applicationDidBecomeActive(_ notification: Notification) {
        appController.appActivated()
    }
    
    func applicationDidResignActive(_ notification: Notification) {
        // aborting modal dialog will resume current countdown timer
        NSApp.abortModal()
    }
    
    func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
        let dockMenu = POMDockMenu()
        dockMenu.pomMenuDelegate = appController
        return dockMenu
    }
}
