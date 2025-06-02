
import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    var userID: String
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var dataString: String = UUID().uuidString

    var body: some View {
        if let qrImage = generateQRCode(from: userID) {
            Image(uiImage: qrImage)
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
        } else {
            Text("QR kod oluşturulamadı.")
        }
        Text("Kullanıcı ID: \(userID)")
            .font(.caption)
    }

    func generateQRCode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        if let output = filter.outputImage {
            if let cgimg = context.createCGImage(output, from: output.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return nil
    }
}
