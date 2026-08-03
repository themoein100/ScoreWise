import SwiftUI


struct MainContentView: View {
    var selectedAvatar: Avatar
    
    
    @ObservedObject var scoreVM: ScoreViewModel

    @State private var name = ""
    @State private var age = ""
    @State private var isStudent: Bool = true
    @State private var showResult = false
    @State private var invalidAge = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image("logo")
                               .resizable()
                               .scaledToFit()
                               .frame(width: 350, height: 200)
                               .background(Color.white)  
                               .ignoresSafeArea()
                    Text("خوش آمدید \(selectedAvatar.emoji)")
                        .font(.title)
                        .padding()

                    VStack(alignment: .leading, spacing: 16) {
                        Text("اطلاعات شخصی را وارد کنید")
                            .font(.title2)
                            .bold()

                        Toggle("آیا دانش‌آموز هستید؟", isOn: $isStudent)
                            .tint(.yellow)

                        TextField("نام را وارد کنید", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: name) { _, newValue in
                                name = newValue.filter { $0.isLetter || $0.isWhitespace }
                            }

                        TextField("سن را وارد کنید", text: $age)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: age) { _, newValue in
                                age = newValue.filter { "0123456789".contains($0) }
                                invalidAge = false
                            }

                        HStack(spacing: 10) {
                            Button("نمایش اطلاعات") {
                                if !name.isEmpty && !age.isEmpty {
                                    if Int(age) != nil {
                                        showResult = true
                                        invalidAge = false
                                    } else {
                                        showResult = false
                                        invalidAge = true
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background((!name.isEmpty && Int(age) != nil) ? Color.yellow : Color.gray)
                            .foregroundColor(.black)
                            .cornerRadius(100)

                            NavigationLink(destination:
                                ScoreInputView(selectedAvatar: selectedAvatar, name: $name, age: $age, isStudent: $isStudent, scoreVM: scoreVM)
                            ) {
                                Text("ادامه")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background((!name.isEmpty && Int(age) != nil) ? Color.green : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(100)
                            }
                            .disabled(name.isEmpty || Int(age) == nil)
                        }

                        Button("ریست اطلاعات") {
                            isStudent = true
                            name = ""
                            age = ""
                            showResult = false
                            invalidAge = false
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(100)

                        if showResult {
                            Text("سلام \(name)!")
                            Text("سنت \(age) ساله‌ست.")
                            Text(isStudent ? "دانش‌آموزی! 🎓" : "نیستی!")
                        }
                    }
                    .padding()
                }
            }
        }
    }
}


    
