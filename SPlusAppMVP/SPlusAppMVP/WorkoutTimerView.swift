import SwiftUI

struct WorkoutTimerView: View {
    @AppStorage("loggedInUserID") private var userID: String = ""
    @State private var startTime: Date?
    @State private var duration: TimeInterval = 0
    @State private var timerRunning = false
    @State private var timer: Timer?
    @State private var programRecords: [WorkoutTask] = []

    var body: some View {
        VStack(spacing: 20) {
            let minutes = Int(duration) / 60
            let seconds = Int(duration) % 60
            Text(String(format: "Geçen Süre: %02d:%02d", minutes, seconds))
                .font(.title)
                .padding()

            if !programRecords.isEmpty {
                VStack(alignment: .leading) {
                    Text("Antrenman Programı")
                        .font(.headline)
                    ForEach(programRecords.indices, id: \.self) { index in
                        let task = programRecords[index]
                        VStack(alignment: .leading) {
                            Text("\(task.name): \(task.completedSets)/\(task.sets) set tamamlandı")
                                .font(.subheadline)
                            Stepper("Set Tamamla", value: Binding(
                                get: { programRecords[index].completedSets },
                                set: {
                                    programRecords[index].completedSets = min($0, programRecords[index].sets)
                                    if programRecords.allSatisfy({ $0.completedSets >= $0.sets }) {
                                        timer?.invalidate()
                                        timerRunning = false
                                        WorkoutProgramStorage.save([], for: userID)
                                        saveWorkout()
                                    }
                                }
                            ), in: 0...programRecords[index].sets)
                        }
                        .padding(.bottom, 5)
                    }
                }
                .padding()
                Button("Antrenman Programını Temizle", role: .destructive) {
                    programRecords = []
                    WorkoutProgramStorage.save([], for: userID)
                }
            }

            HStack(spacing: 20) {
                Button("Başlat") {
                    duration = 0
                    startTime = Date()
                    timerRunning = true
                    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                        DispatchQueue.main.async {
                            if let start = startTime {
                                duration = Date().timeIntervalSince(start)
                            }
                        }
                    }
                }
                .disabled(timerRunning)

                Button("Bitir") {
                    timer?.invalidate()
                    timerRunning = false
                    WorkoutProgramStorage.save([], for: userID)
                    saveWorkout()
                }
                .disabled(!timerRunning)
            }
            .font(.headline)
            .padding()
        }
        .onAppear {
            if programRecords.isEmpty {
                programRecords = WorkoutProgramStorage.load(for: userID)
            }
        }
    }

    func saveWorkout() {
        let endTime = Date()
        let finalDuration = Int((endTime.timeIntervalSince(startTime ?? endTime)).rounded())
        guard finalDuration > 0 && !programRecords.isEmpty else { return }
        let record = WorkoutRecord(date: endTime, duration: finalDuration, programSummary: programRecords)
        var history = WorkoutStorage.load(for: userID)
        history.append(record)
        WorkoutStorage.save(records: history, for: userID)
        duration = 0
    }
}
