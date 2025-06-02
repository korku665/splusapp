
import SwiftUI

struct LoginView: View {
    @AppStorage("loggedInUser") var loggedInUser : String = ""
    @AppStorage("userRole") var userRole: String = ""

    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var selectedRole: String = "user"

   
    let credentials: [String: (password: String, role: String)] = [
        "user123": ("1234", "user"),
        "admin123": ("admin", "admin")
    ]

    var body: some View {
        VStack(spacing: 20) {
            Text("S+App Giriş")
                .font(.largeTitle)

            Picker("Giriş Türü", selection: $selectedRole) {
                Text("Kullanıcı").tag("user")
                Text("Admin").tag("admin")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            TextField("Kullanıcı Adı", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding(.horizontal)

            SecureField("Şifre", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            Button("Giriş Yap") {
                login()
            }
            .disabled(username.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty)
            .padding(.top)
        }
        .padding()
    }

    func login() {
        let uname = username.trimmingCharacters(in: .whitespaces).lowercased()
        let pword = password.trimmingCharacters(in: .whitespaces)

        if let userInfo = credentials[uname], userInfo.role == selectedRole {
            if userInfo.password == pword {
                loggedInUser = uname
                UserDefaults.standard.set(uname, forKey: "loggedInUserID")
                UserDefaults.standard.set(pword, forKey: "loggedInUserPassword")
                UserDefaults.standard.set(userInfo.role, forKey: "currentUserRole")
                userRole = userInfo.role
                errorMessage = ""
                let record = LoginRecord(userID: uname, loginTime: Date(), ipAddress: "192.168.1.1")
                LoginHistoryStorage.save(record, for: username)
            } else {
                errorMessage = "Şifre yanlış!"
            }
        } else {
            errorMessage = "Bu tür için kullanıcı bulunamadı!"
        }
    }
}
