
import Foundation

class POMTimer {

    var timeLeft:Double = 0
    var startTime:Double = 0
    
    private var tickInterval:Double = 0
    private var tickTimer:DispatchSourceTimer?
    private var tickClosure:((POMTimer)->())?
    
    func start(from countdown:Double, tick interval:Double, tickClosure:@escaping (POMTimer)->()) {
        timeLeft = countdown
        tickInterval = interval
        self.tickClosure = tickClosure
        
        tickTimer?.cancel()
        tickTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        tickTimer?.schedule(deadline: .now(), repeating: interval)
        tickTimer?.setEventHandler(handler: {
            tickClosure(self)
            self.timeLeft -= interval
        })
        tickTimer?.resume()
    }
    
    func stop() {
        tickTimer?.cancel()
        timeLeft = 0
        startTime = 0
        tickClosure = nil
    }
    
    func pause() {
        tickTimer?.cancel()
    }
    
    func resume() {
        guard let tickClosure = tickClosure else { return }
        start(from: timeLeft, tick: tickInterval, tickClosure: tickClosure)
    }
}
