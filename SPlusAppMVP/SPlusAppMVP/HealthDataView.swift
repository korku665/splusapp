import SwiftUI

struct HealthDataView: View {
    var userID: String
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var muscleMass: String = ""
    @State private var result: String = ""
    @State private var age: String = ""
    @State private var history: [HealthData] = []

    var body: some View {
        Form {
            Section(header: Text("Vücut Ölçüleri")) {
                TextField("Boy (cm)", text: $height)
                    .keyboardType(.decimalPad)
                TextField("Kilo (kg)", text: $weight)
                    .keyboardType(.decimalPad)
                TextField("Kas Kütlesi (kg)", text: $muscleMass)
                    .keyboardType(.decimalPad)
                TextField("Yaş", text: $age)
            }

            Button("Kaydet") {
                let data = HealthData(
                    height: Float(height) ?? 0,
                    weight: Float(weight) ?? 0,
                    muscleMass: Float(muscleMass) ?? 0,
                    age: Int(age) ?? 0
                )
                HealthStorage.save(data, for: userID)
                result = "BMI: \(String(format: "%.1f", data.bmi))"
                history = HealthStorage.load(for: userID)
                clearInputs()
            }

            if !result.isEmpty {
                Text(result).font(.headline)
            }

            if !history.isEmpty {
                Section(header: Text("Geçmiş Kayıtlar")) {
                    ForEach(groupedByDate2(history), id: \.key) { date, records in
                        Section(header: Text(date)) {
                            ForEach(records) { record in
                                VStack(alignment: .leading) {
                                    Text("Tarih: \(record.date.formatted(.dateTime))")
                                    Text("Boy: \(record.height) cm, Kilo: \(record.weight) kg")
                                    Text("Kas: \(record.muscleMass) kg, Yaş: \(record.age)")
                                    Text("BMI: \(String(format: "%.1f", record.bmi))")

                                    Button(role: .destructive) {
                                        HealthStorage.delete(record, for: userID)
                                        history = HealthStorage.load(for: userID)
                                    } label: {
                                        Label("Kaydı Sil", systemImage: "trash")
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Sağlık Verileri")
        .onAppear {
            let allData = HealthStorage.load(for: userID)
            if let latest = allData.last {
                height = "\(latest.height)"
                weight = "\(latest.weight)"
                muscleMass = "\(latest.muscleMass)"
                age = "\(latest.age)"
            }
            history = allData
        }
    }

    private func clearInputs() {
        height = ""
        weight = ""
        muscleMass = ""
        age = ""
    }
}

func groupedByDate2<T: Identifiable>(_ list: [T]) -> [(key: String, value: [T])] where T: Codable {
    let grouped = Dictionary(grouping: list) { item in
        let date = (item as? HealthData)?.date ?? (item as? WorkoutRecord)?.date ?? Date()
        return DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
    }
    return grouped.sorted { $0.key > $1.key }
}
