import SwiftUI
import Charts


struct AdminPanelView: View {
    @State private var logins: [LoginRecord] = []
    @State private var hourlyCounts: [Int: Int] = [:]

    var body: some View {
        VStack {
            Text("Salon Yoğunluğu (Giriş Saati)")
                .font(.headline)

            if #available(iOS 16.0, *) {
                Chart(hourlyCounts.sorted(by: { $0.key < $1.key }), id: \.key) { hour, count in
                    BarMark(
                        x: .value("Saat", "\(hour):00"),
                        y: .value("Giriş", count)
                    )
                }
                .frame(height: 300)
                .padding()
            } else {
                Text("Chart özelliği iOS 16+ gerektirir.")
            }

            Button("Giriş Ekle") {
                LoginStorage.simulateAdd(for: "user123")
                reloadData()
            }
            .padding()
            
            Button("Tüm Girişleri Sil", role: .destructive) {
                LoginStorage.clearAll()
                reloadData()
            }
            .padding(.bottom)

            List {
                ForEach(logins, id: \.id) { record in
                    VStack(alignment: .leading) {
                        Text("Kullanıcı: \(record.userID)")
                        Text("Zaman: \(record.loginTime.formatted(.dateTime))")
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("Yoğunluk Paneli")
        .onAppear {
            reloadData()
            NotificationCenter.default.addObserver(forName: NSNotification.Name("LoginHistoryCleared"), object: nil, queue: .main) { _ in
                reloadData()
            }
        }
    }

    func reloadData() {
        logins = LoginStorage.load()
        print("Yüklenen giriş sayısı: \(logins.count)")
        print(logins.map { $0.loginTime })
        hourlyCounts = [:]
        for login in logins {
            let hour = Calendar.current.component(.hour, from: login.loginTime)
            hourlyCounts[hour, default: 0] += 1
        }
    }
}

struct UserOccupancyView: View {
    @State private var logins: [LoginRecord] = []
    @State private var hourlyCounts: [Int: Int] = [:]

    var body: some View {
        VStack {
            Text("Salon Yoğunluğu (Giriş Saati)")
                .font(.headline)

            if #available(iOS 16.0, *) {
                Chart(hourlyCounts.sorted(by: { $0.key < $1.key }), id: \.key) { hour, count in
                    BarMark(
                        x: .value("Saat", "\(hour):00"),
                        y: .value("Giriş", count)
                    )
                }
                .frame(height: 300)
                .padding()
            } else {
                Text("Chart özelliği iOS 16+ gerektirir.")
            }
        }
        .navigationTitle("Yoğunluk Paneli")
        .onAppear {
            reloadData()
        }
    }

    func reloadData() {
        logins = LoginStorage.load()
        hourlyCounts = [:]
        for login in logins {
            let hour = Calendar.current.component(.hour, from: login.loginTime)
            hourlyCounts[hour, default: 0] += 1
        }
    }
}
