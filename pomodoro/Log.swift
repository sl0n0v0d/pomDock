
import os.log
import Foundation

class Log{
    class func info(_ message: StaticString, _ args: CVarArg...) {
        if #available(OSX 10.14, *) {
            os_log(.info, message, args)
        } else {
            NSLog("\(message)", args)
        }
    }
}
