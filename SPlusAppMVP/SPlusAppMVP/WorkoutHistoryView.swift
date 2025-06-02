import SwiftUI

struct WorkoutHistoryView: View {
    var userID: String
    @State private var history: [WorkoutRecord] = []

    var body: some View {
        List {
            ForEach(history) { record in
                VStack(alignment: .leading) {
                    Text("Tarih: \(record.date.formatted(.dateTime.day().month().year().hour().minute()))")
                    Text("Süre: \(record.duration) saniye")

                    if !record.programSummary.isEmpty {
                        Text("Yapılan Antrenmanlar:")
                            .font(.subheadline)
                        ForEach(record.programSummary) { task in
                            Text("↳ \(task.name): \(task.completedSets)/\(task.sets)")
                                .font(.caption)
                        }
                    }

                    Button(role: .destructive) {
                        WorkoutStorage.delete(record, for: userID)
                        history = WorkoutStorage.load(for: userID)
                    } label: {
                        Label("Kaydı Sil", systemImage: "trash")
                    }
                }
            }
        }
        .navigationTitle("Antrenman Geçmişi")
        .onAppear {
            history = WorkoutStorage.load(for: userID)
        }
    }
}
