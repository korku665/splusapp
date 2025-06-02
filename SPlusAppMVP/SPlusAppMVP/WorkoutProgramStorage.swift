
import Foundation

struct WorkoutProgramStorage {
    static func key(for userID: String) -> String {
        "program_\(userID)"
    }

    static func save(_ program: [WorkoutTask], for userID: String) {
        if let data = try? JSONEncoder().encode(program) {
            UserDefaults.standard.set(data, forKey: key(for: userID))
        }
    }

    static func load(for userID: String) -> [WorkoutTask] {
        guard let data = UserDefaults.standard.data(forKey: key(for: userID)),
              let program = try? JSONDecoder().decode([WorkoutTask].self, from: data) else {
            return []
        }
        return program
    }
}
