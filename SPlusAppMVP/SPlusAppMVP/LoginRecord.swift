
import Foundation

struct LoginRecord: Codable, Identifiable {
    var id = UUID()
    var userID: String
    var loginTime: Date
    var logoutTime: Date?
    var ipAddress: String
}
