
import Cocoa

class POMModalQuestion {
    class func dialogYesNo(question: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = question
        alert.alertStyle = .warning
        alert.addButton(withTitle: "Yes")
        alert.addButton(withTitle: "No")
        let result = alert.runModal()
        return result == .alertFirstButtonReturn
    }
}
