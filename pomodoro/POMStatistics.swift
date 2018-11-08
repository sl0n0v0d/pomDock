
import Cocoa

class POMStatistics {
    private static let userDefaultsKey = "finishedPomodorsDates"

    class func pomodoroDone() {
        var finishedDatesToSave = [Date]()
        
        if let finishedPomodorsDates = UserDefaults.standard.object(forKey:userDefaultsKey) as? [Date] {
            finishedDatesToSave = finishedPomodorsDates
        }
        
        finishedDatesToSave.append(Date())
        
        UserDefaults.standard.set(finishedDatesToSave, forKey:userDefaultsKey)
    }
    
    class func finishedPomodorosToday() -> Int {
        removeOutdatedPomodoros()
        
        guard let finishedPomodorsDates = UserDefaults.standard.object(forKey:userDefaultsKey) as? [Date] else {
            return 0
        }
    
        return finishedPomodorsDates.count
    }

    private class func removeOutdatedPomodoros() {
        guard let finishedPomodorsDates = UserDefaults.standard.object(forKey:userDefaultsKey) as? [Date] else {
            return
        }
        
        var finishedDatesToSave = [Date]()
        
        for date in finishedPomodorsDates {
            if Calendar.current.isDateInToday(date) {
                finishedDatesToSave.append(date)
            }
        }
        
        UserDefaults.standard.set(finishedDatesToSave, forKey:userDefaultsKey)
    }

}
