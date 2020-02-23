
import Foundation

class Config {
    static let shared = Config()
    
    let tickInterval = 1.0
    let grabAttentionInterval = 2.0
    
    private let userDefaultsFocusKey = "focusTime"
    private let userDefaultsDiffuseKey = "defuseTime"
    
    var focusTime = 25 * 60.0 {
        didSet {
            UserDefaults.standard.set(focusTime, forKey:userDefaultsFocusKey)
        }
    }
    
    var diffuseTime = 5 * 60.0 {
        didSet {
            UserDefaults.standard.set(focusTime, forKey:userDefaultsFocusKey)
        }
    }
    
    init() {
        if let focusTime = UserDefaults.standard.object(forKey: userDefaultsFocusKey) as? Double, focusTime > 0 {
            self.focusTime = focusTime
        }
        
        if let diffuseTime = UserDefaults.standard.object(forKey: userDefaultsDiffuseKey) as? Double, diffuseTime > 0 {
            self.diffuseTime = diffuseTime
        }
    }
}
