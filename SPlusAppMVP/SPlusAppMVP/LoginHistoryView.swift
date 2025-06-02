
import SwiftUI

struct LoginHistoryView: View {
    @State private var grouped: [(key: String, value: [LoginRecord])] = []
    @AppStorage("userRole") var userRole: String = ""

    var body: some View {
        List {
            ForEach(grouped, id: \.key) { date, records in
                Section(header: Text(date)) {
                    ForEach(records) { record in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Giriş: \(record.loginTime.formatted(.dateTime.hour().minute()))")
                            Text("Kullanıcı: \(record.userID)").font(.caption)
                            Text("IP: \(record.ipAddress)").font(.caption2)
                        }
                    }
                    .onDelete { indexSet in
                        guard userRole == "admin" else { return }
                        for offset in indexSet {
                            let record = records[offset]
                            LoginStorage.delete(record)
                        }
                        reload()
                    }
                }
            }
        }
        .navigationTitle("Giriş Geçmişi")
        .onAppear {
            reload()
        }
    }

    func reload() {
        let all = LoginStorage.load()
        let groupedDict = Dictionary(grouping: all) { record in
            DateFormatter.localizedString(from: record.loginTime, dateStyle: .short, timeStyle: .none)
        }
        grouped = groupedDict.sorted { $0.key > $1.key }
    }
}
