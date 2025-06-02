
import Foundation

struct OccupancyStorage {
    static let key = "OccupancyData"

    static func load() -> [OccupancyRecord] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([OccupancyRecord].self, from: data) else {
            return []
        }
        return decoded
    }

    static func save(_ data: [OccupancyRecord]) {
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    static func delete(_ record: OccupancyRecord) {
        var current = load()
        current.removeAll { $0.id == record.id }
        save(current)
    }

    static func clearAll() {
        UserDefaults.standard.removeObject(forKey: key)
        NotificationCenter.default.post(name: NSNotification.Name("OccupancyCleared"), object: nil)
    }
}
