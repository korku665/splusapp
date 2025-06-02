
import Foundation

struct OccupancyRecord: Codable, Identifiable {
    let id: UUID
    let date: Date
    let count: Int
}
