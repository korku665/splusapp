import SwiftUI

struct UserDetailView: View {
    let userID = "user123"
    @State private var isExpanded = false

    var body: some View {
        List {
            Section(header: Text("Kullanıcı")) {
                DisclosureGroup(
                    isExpanded: $isExpanded,
                    content: {
                        TabView {
                            programTab
                                .tabItem {
                                    Label("Program", systemImage: "list.bullet")
                                }

                            healthTab
                                .tabItem {
                                    Label("Sağlık", systemImage: "heart")
                                }

                            workoutTab
                                .tabItem {
                                    Label("Antrenman", systemImage: "figure.walk")
                                }

                            loginTab
                                .tabItem {
                                    Label("Giriş", systemImage: "clock")
                                }
                        }
                        .frame(height: 450)
                    },
                    label: {
                        Text(userID).font(.headline)
                    }
                )
            }
        }
        .navigationTitle("Kullanıcı Bilgisi")
    }

    private var programTab: some View {
        VStack(alignment: .leading, spacing: 10) {
            let program = WorkoutProgramStorage.load(for: userID)
            if program.isEmpty {
                Text("Kullanıcıya atanmış bir program yok.")
                    .foregroundColor(.gray)
            } else {
                ForEach(program) { task in
                    Text("\(task.name): \(task.sets) set")
                }
            }
        }
    }

    private var healthTab: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(HealthStorage.load(for: userID)) { data in
                VStack(alignment: .leading) {
                    Text("Tarih: \(data.date.formatted(.dateTime))")
                    Text("Boy: \(data.height) cm | Kilo: \(data.weight) kg | Yaş: \(data.age)")
                    Text("BMI: \(String(format: "%.1f", data.bmi))")
                }
                Divider()
            }
        }
    }

    private var workoutTab: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(WorkoutStorage.load(for: userID)) { record in
                VStack(alignment: .leading) {
                    Text("Tarih: \(record.date.formatted(.dateTime)) - Süre: \(record.duration) sn")
                    ForEach(record.programSummary) { task in
                        Text("↳ \(task.name): \(task.completedSets)/\(task.sets)")
                            .font(.caption)
                    }
                }
                Divider()
            }
        }
    }

    private var loginTab: some View {
        let records = LoginHistoryStorage.load(for: userID)
        return List {
            ForEach(Array(records.enumerated()), id: \.element.id) { index, log in
                VStack(alignment: .leading) {
                    Text("Giriş: \(log.loginTime.formatted(.dateTime))")
                    Text("IP: \(log.ipAddress)")
                }
            }
            .onDelete { offsets in
                var updated = records
                updated.remove(atOffsets: offsets)
                LoginHistoryStorage.saveAll(updated, for: userID)
            }
        }
    }
}

func groupedByDate<T: Identifiable>(_ list: [T]) -> [(key: String, value: [T])] where T: Codable {
    let grouped = Dictionary(grouping: list) { item in
        let date = (item as? HealthData)?.date ?? (item as? WorkoutRecord)?.date ?? Date()
        return DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
    }
    return grouped.sorted { $0.key > $1.key }
}
