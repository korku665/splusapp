
import Foundation

struct WorkoutTask: Codable, Identifiable {
    var id = UUID()
    var name: String
    var sets: Int
    var completedSets: Int
}
