
import os.log

class Log{
    class func info(_ message: StaticString, _ args: CVarArg...) {
        os_log(.info, message, args)
    }
}
