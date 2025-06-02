
import SwiftUI

struct OccupancyView: View {
    @State private var records: [OccupancyRecord] = []
    var isAdmin: Bool

    var body: some View {
        VStack {
            if records.isEmpty {
                Text("Henüz veri yok.")
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(records) { record in
                        HStack {
                            Text(record.date.formatted(.dateTime.day().month().hour().minute()))
                            Spacer()
                            Text("İçeride: \(record.count) kişi")
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: isAdmin ? delete : nil)
                }
            }
        }
        .navigationTitle("Yoğunluk Analizi")
        .onAppear {
            records = OccupancyStorage.load()
            NotificationCenter.default.addObserver(forName: NSNotification.Name("OccupancyCleared"), object: nil, queue: .main) { _ in
                records = OccupancyStorage.load()
            }
        }
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
            OccupancyStorage.delete(records[index])
        }
        records = OccupancyStorage.load()
    }
}
