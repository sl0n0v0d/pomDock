
import Cocoa

extension NSAppearance {
    class var isDarkMode: Bool {
        let currentMode = UserDefaults.standard.string(forKey: "AppleInterfaceStyle")
        return currentMode == "Dark"
    }
}
