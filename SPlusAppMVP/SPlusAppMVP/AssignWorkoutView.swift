
import SwiftUI

struct AssignWorkoutView: View {
    @State private var program: [WorkoutTask] = []
    @State private var taskName = ""
    @State private var taskSets = ""

    var userID: String

    var body: some View {
        Form {
            Section("Yeni Egzersiz Ekle") {
                TextField("Egzersiz Adı", text: $taskName)
                TextField("Set Sayısı", text: $taskSets)
                    .keyboardType(.numberPad)

                Button("Ekle") {
                    let sets = Int(taskSets) ?? 1
                    program.append(WorkoutTask(name: taskName, sets: sets, completedSets: 0))
                    taskName = ""
                    taskSets = ""
                }
            }

            Section("Program Önizleme") {
                if program.isEmpty {
                    Text("Henüz egzersiz eklenmedi.")
                        .foregroundColor(.gray)
                } else {
                    ForEach(program) { task in
                        Text("\(task.name) - \(task.sets) set")
                    }
                    .onDelete(perform: deleteTask)
                }

                Button("Programı Kullanıcıya Ata") {
                    WorkoutProgramStorage.save(program, for: userID)
                }
            }
        }
        .navigationTitle("Program Ata")
        .onAppear {
            program = WorkoutProgramStorage.load(for: userID)
        }
        
    }
    
    func deleteTask(at offsets: IndexSet) {
        program.remove(atOffsets: offsets)
        WorkoutProgramStorage.save(program, for: userID)
    }
}
