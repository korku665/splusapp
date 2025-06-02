
import Foundation

struct HealthStorage {
    static func key(for userID: String) -> String {
        "health_\(userID)"
    }

    static func load(for userID: String) -> [HealthData] {
        guard let data = UserDefaults.standard.data(forKey: key(for: userID)) else { return [] }
        return (try? JSONDecoder().decode([HealthData].self, from: data)) ?? []
    }

    static func save(_ entry: HealthData, for userID: String) {
        var all = load(for: userID)
        all.append(entry)
        if let encoded = try? JSONEncoder().encode(all) {
            UserDefaults.standard.set(encoded, forKey: key(for: userID))
        }
    }
    
    static func saveAll(_ all: [HealthData], for userID: String) {
        if let encoded = try? JSONEncoder().encode(all) {
            UserDefaults.standard.set(encoded, forKey: key(for: userID))
        }
    }
    
    static func delete(_ item: HealthData, for userID: String) {
        var all = load(for: userID)
        all.removeAll { $0.id == item.id }
        saveAll(all, for: userID)
    }
}
