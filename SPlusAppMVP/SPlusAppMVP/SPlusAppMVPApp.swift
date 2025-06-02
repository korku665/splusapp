
import SwiftUI

@main
struct SPlusAppMVPApp: App {
    @AppStorage("loggedInUser") var loggedInUser: String = ""

    var body: some Scene {
        WindowGroup {
            if loggedInUser != ""{
                MainView()
            } else {
                LoginView()
            }
        }
    }
}
