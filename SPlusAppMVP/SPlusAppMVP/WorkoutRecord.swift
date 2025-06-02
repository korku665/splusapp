
import Foundation

struct WorkoutRecord: Codable, Identifiable {
    var id = UUID()
    var date: Date
    var duration: Int
    var programSummary: [WorkoutTask] = []
}
