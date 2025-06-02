
import Foundation

struct HealthData: Codable, Identifiable {
    var id = UUID()
    var height: Float
    var weight: Float
    var muscleMass: Float
    var age: Int
    var date: Date = Date()

    var bmi: Float {
        if height == 0 { return 0 }
        return weight / pow(height / 100, 2)
    }
}
