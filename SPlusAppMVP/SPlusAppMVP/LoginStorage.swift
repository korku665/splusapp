
import Foundation

struct LoginStorage {
    static let key = "login_records"

    static func load() -> [LoginRecord] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([LoginRecord].self, from: data)) ?? []
    }

    static func save(_ records: [LoginRecord]) {
        if let data = try? JSONEncoder().encode(records) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    static func simulateAdd(for userID: String) {
        var all = load()
        let new = LoginRecord(userID: userID, loginTime: Date(), logoutTime: nil, ipAddress: "192.168.1.1")
        all.append(new)
        save(all)
    }
    
    static func delete(_ record: LoginRecord) {
            var all = load()
            all.removeAll { $0.id == record.id }
            save(all)
        }
    
    static func clearAll() {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}
