import Foundation

struct LoginHistoryStorage {
    static func key(for userID: String) -> String { "login_\(userID)" }

    static func load(for userID: String) -> [LoginRecord] {
        guard let data = UserDefaults.standard.data(forKey: key(for: userID)) else { return [] }
        return (try? JSONDecoder().decode([LoginRecord].self, from: data)) ?? []
    }

    static func save(_ record: LoginRecord, for userID: String) {
        var all = load(for: userID)
        all.append(record)
        if let encoded = try? JSONEncoder().encode(all) {
            UserDefaults.standard.set(encoded, forKey: key(for: userID))
        }
    }

    static func saveAll(_ records: [LoginRecord], for userID: String) {
        if let encoded = try? JSONEncoder().encode(records) {
            UserDefaults.standard.set(encoded, forKey: key(for: userID))
        }
    }
}
