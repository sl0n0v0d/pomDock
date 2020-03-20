
import Foundation

class POMDeepNightTimer {

    private let timer: Timer?
    
    init(block: @escaping () -> Void) {
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: Date())
        let deepNightDate = calendar.date(byAdding: .hour, value: 27, to: startOfToday)
        let oneDayInSeconds = 24*60*60.0;
        timer = Timer(fire: deepNightDate!, interval: oneDayInSeconds, repeats: true, block: { (timer) in
            block()
        })
        RunLoop.current.add(timer!, forMode: .common)
    }
}
