import SwiftUI

struct TutorialView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .trailing, spacing: 16) {
                
                Text("راهنمای استفاده از اپ")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.trailing)
                
                Text("این اپ به شما کمک می‌کند که ...")
                    .font(.body)
                    .multilineTextAlignment(.trailing)
                
                Text("ویژگی‌های اصلی اپ:")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.trailing)
                
                VStack(alignment: .trailing, spacing: 8) {
                    Text("• انتخاب آواتار برای شخصی‌سازی تجربه کاربری")
                    Text("• حالت شب برای کاهش خستگی چشم")
                    Text("• ثبت و مشاهده نمرات آزمون‌ها")
                    Text("• تنظیمات آسان و کاربردی")
                    Text("• نمایش آمار عملکرد")
                    
                }
                .font(.body)
                .multilineTextAlignment(.trailing)
                
                Text("نحوه استفاده:")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.trailing)
                
                VStack(alignment: .trailing, spacing: 6) {
                    Text("1. ابتدا در صفحه انتخاب آواتار، یک آواتار دلخواه انتخاب کنید.")
                    Text("2. در صفحه اصلی، می‌توانید اطلاعات و امکانات مختلف را مشاهده کنید.")
                    Text("3. در تنظیمات می‌توانید حالت شب را فعال یا غیر فعال کنید و به انتخاب آواتار برگردید.")
                   
                }
                .font(.body)
                .multilineTextAlignment(.trailing)
            }
            .padding()
        }
        .environment(\.layoutDirection, .leftToRight) 
    }
}

