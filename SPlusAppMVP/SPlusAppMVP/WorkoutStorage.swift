import Foundation

struct WorkoutStorage {
    static func key(for userID: String) -> String {
        "workouts_\(userID)"
    }

    static func load(for userID: String) -> [WorkoutRecord] {
        guard let data = UserDefaults.standard.data(forKey: key(for: userID)) else { return [] }
        return (try? JSONDecoder().decode([WorkoutRecord].self, from: data)) ?? []
    }

    static func save(records: [WorkoutRecord], for userID: String) {
        if let data = try? JSONEncoder().encode(records) {
            UserDefaults.standard.set(data, forKey: key(for: userID))
        }
    }
    
    static func delete(_ item: WorkoutRecord, for userID: String) {
        var all = load(for: userID)
        all.removeAll { $0.id == item.id }
        save(records: all, for: userID)
    }
}
