import SwiftUI


struct MainView: View {
    @AppStorage("loggedInUser") var loggedInUser: String = ""
    @AppStorage("userRole") var userRole: String = ""
    var body: some View {
        NavigationView {
            List {
                if userRole == "user" {
                    Section("Sporcu Modülü") {
                        NavigationLink("Profilim", destination: UserProfileView())
                        NavigationLink("QR Kodumu Göster", destination: QRCodeView(userID: loggedInUser))
                        NavigationLink("Antrenman Modunu Aç", destination: WorkoutTimerView())
                        NavigationLink("Antrenman Geçmişim", destination: WorkoutHistoryView(userID: loggedInUser))
                        NavigationLink("Sağlık Verilerim", destination: HealthDataView(userID: loggedInUser))
                        NavigationLink("Yoğunluk Paneli", destination: UserOccupancyView())
                    }
                }

                if userRole == "admin" {
                    Section("Yönetici Paneli") {
                        NavigationLink("Profilim", destination: UserProfileView())
                        NavigationLink("QR Kodumu Göster", destination: QRCodeView(userID: loggedInUser))
                        NavigationLink("Sağlık Verilerim", destination: HealthDataView(userID: loggedInUser))
                        NavigationLink("Yoğunluk Analizi", destination: AdminPanelView())
                        NavigationLink("Kullanıcı Bilgileri", destination: UserDetailView())
                        NavigationLink("Program Ata", destination: AssignWorkoutView(userID: "user123"))
                    }
                }
            }
            .navigationTitle("S+App")
        }
    }
}
