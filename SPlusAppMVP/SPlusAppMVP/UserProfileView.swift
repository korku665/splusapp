//
//  UserProfileView.swift
//  SPlusAppMVP
//
//  Created by Ahmet Erkin Sakızcı on 27.05.2025.
//

import SwiftUI

struct UserProfileView: View {
    @AppStorage("loggedInUser") var loggedInUser: String = ""
    @AppStorage("userRole") var userRole: String = ""

    var passwordHint: String {
        switch loggedInUser {
        case "user123": return "1234"
        case "admin123": return "admin"
        default: return "-"
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("👤 Profilim")
                .font(.largeTitle)

            //Text("Kullanıcı Adı: \(loggedInUser)")
            //Text("Şifre: \(passwordHint)")
                //.foregroundColor(.gray)

            if userRole == "user" {
                Text("Kullanıcı Adı: user123")
                Text("Şifre: 1234")
                    .foregroundColor(.gray)
            } else if userRole == "admin" {
                Text("Kullanıcı Adı: admin123")
                Text("Şifre: admin")
                    .foregroundColor(.gray)
            }

            Text("Rol: \(userRole.capitalized)")
                .padding(.bottom)

            Button("Çıkış Yap") {
                loggedInUser = ""
                userRole = ""
            }
            .foregroundColor(.red)
        }
        .padding()
        .navigationTitle("Profil")
    }
}
