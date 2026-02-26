# splusapp
🇹🇷 Bu uygulama sürümü bir testtir, bu nedenle programı kullanırsanız bazı sorunlarla karşılaşabilirsiniz.

🇬🇧 This app version a test because of that, if you use the program, may be see some problems.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
🇹🇷
SPlusAppMVP 🏋️‍♂️

Spor Salonu Yönetimi ve Kullanıcı Takip Uygulaması (SwiftUI)

📱 Hakkında

* SPlusApp, spor salonu kullanıcılarının giriş/çıkış işlemlerini, sağlık verilerini, antrenman geçmişlerini ve salonun yoğunluk analizini yönetebildikleri lokal (çevrimdışı) bir mobil uygulamadır. SwiftUI ile geliştirilmiştir. Uygulama iki rolü destekler: kullanıcı (sporcu) ve admin (yönetici).

👤 Kullanıcı Modülü

* Giriş ekranı ile kullanıcı adı & şifre kontrolü

* Profil ekranında aşağıdaki işlevler:
- Sağlık verileri girişi (boy, kilo, yaş, kas oranı)
- BMI hesaplama ve geçmiş ölçümlerin listelenmesi
- Antrenman modunu başlatma → süre takibi ve atanmış programı görme
- Program içerisindeki hareketleri işaretleme
- Antrenman geçmişi görüntüleme (detaylı)
- Salon yoğunluğu grafiği (salt okunur)

👨‍💼 Admin Modülü

* Kullanıcıya özel antrenman programı atayabilme

* Kullanıcı bilgilerini detaylı sekmeli arayüzde görüntüleme:
- Sağlık verileri
- Antrenman geçmişi
- Atanmış antrenman programı

* Giriş geçmişi (IP, tarih/saat)
- Giriş geçmişi ve yoğunluk verilerini temizleyebilme
- Bar chart ile saatlik yoğunluk analiz raporu görselleştirme

🗂 Kullanılan Teknolojiler

* SwiftUI (iOS 16+)
* Charts Framework (Apple)
* UserDefaults (Lokal veri saklama)
* MVVM benzeri yapı
* NavigationView, TabView, DisclosureGroup, List
* AppStorage (Oturum kontrolü)

🧪 Uygulamanın Başlatılması

* Xcode 14 veya üzeri ile projeyi açın.
* iOS simülatörde veya gerçek cihazda çalıştırın.

* Giriş bilgilerinden birini kullanın:
- user123 - 1234 (kullanıcı için)
- admin123 - admin (Admin için)

📌 Notlar

* Uygulama tamamen çevrimdışıdır, internet bağlantısına ihtiyaç duymaz.
* QR kod, çoklu kullanıcı, bulut verisi ve bildirim gibi özellikler ileri sürümlerde eklenebilir.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
🇬🇧
SPlusAppMVP 🏋️‍♂️

Gym Management and User Tracking App (SwiftUI)

📱 About

* SPlusApp is an offline mobile application that allows gym users to manage their check-ins/check-outs, health data, workout history, and gym occupancy analytics. Built using SwiftUI. It supports two roles: user (athlete) and admin (manager).

👤 User Module

* Login screen with username & password verification

* Profile screen functions:
- Health data input (height, weight, age, muscle mass)
- BMI calculation and listing of past records
- Start workout mode → track time and view assigned program
- Check off completed exercises during workout
- View workout history (detailed)
- View gym occupancy graph (read-only)

👨‍💼 Admin Module

* Assign workout programs to users

* View user details with tabbed interface:
- Health data
- Workout history
- Assigned program
- Login history (IP, date/time)
- Clear login and occupancy data
- Visualize hourly occupancy analysis with bar chart

🗂 Technologies Used

* SwiftUI (iOS 16+)
* Charts Framework (Apple)
* UserDefaults (Local data storage)
* MVVM-like architecture
* NavigationView, TabView, DisclosureGroup, List
* AppStorage (session control)

🧪 Getting Started

* Open the project in Xcode 14 or later.
* Run it on a simulator or physical device.

* Use one of the following credentials:
- user123 - 1234 (for user)
- admin123 - admin (for admin)

📌 Notes

* The app is fully offline and requires no internet connection.
* Features like QR code, multi-user support, cloud sync, and push notifications can be added in future versions.
