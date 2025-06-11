import SwiftUI


// MARK: - Màn hình Login
struct LoginView: View {
    // MARK: - Khai báo ViewModel
    @StateObject var viewModel = LoginViewModel()
        @State private var isActive: Bool = false
    var body: some View {
            NavigationStack {
                ZStack { // ZStack để đặt gradient làm nền
                    linearGradientBackground // Đặt gradient làm nền
                        .edgesIgnoringSafeArea(.all)

                    ScrollView {
                        VStack {
                            headerSection
                            Spacer().frame(height: 32)
                            emailInputField
                            passwordInputField
                            forgotPasswordButton
                            Spacer().frame(height: 16)
                            signInButton
                            signUpPrompt
                            NavigationLink(destination: HomeView(), isActive: $viewModel.loginSuccess ){
                                EmptyView()
                            }
                        }
                        .padding(.horizontal, 20) // Thêm padding ngang cho toàn bộ nội dung
                        .padding(.top, 16)
                    }
                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text("Thông báo"),
                        message: Text(viewModel.alertMessage),
                        dismissButton: .default(Text("OK")) {
                            if viewModel.loginSuccess {
                                print("Đăng nhập thành công, chuyển hướng...")
                                
                            }
                        }
                    )
                }
            }
        }

        // MARK: - Subviews (Các phần View được tách ra)

        private var linearGradientBackground: some View {
            LinearGradient(gradient: Gradient(colors: [Color(red: 1/255, green: 1/255, blue: 28/255), Color(red: 200/255, green: 171/255, blue: 3/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }

        private var headerSection: some View {
            VStack {
                Text("Hello")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                    .foregroundColor(.white)

                Text("Sign In !")
                    .font(.title2)
                    .foregroundColor(.white)
            }
        }

        private var emailInputField: some View {
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .multilineTextAlignment(.center)
                .background(Color.white.opacity(0.2))
                .cornerRadius(8)
                .foregroundColor(.white)
                .overlay(
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(Color(red: 255/255, green: 223/255, blue: 0/255))
                            .padding(.leading, 8)
                        Spacer()
                    }, alignment: .leading
                )
                .accessibilityLabel(Text("Email Address"))
        }

        private var passwordInputField: some View {
            SecureField("Password", text: $viewModel.password)
                .padding()
                .multilineTextAlignment(.center)
                .background(Color.white.opacity(0.2))
                .cornerRadius(8)
                .foregroundColor(.white)
                .overlay(
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.white) // Màu vàng
                            .padding(.leading, 8)
                        Spacer()
                    }, alignment: .leading
                )
                .accessibilityLabel(Text("Password"))
        }

        private var forgotPasswordButton: some View {
            HStack {
                Spacer()
                Button("Forgot password ?") {
                    viewModel.forgotPassword()
                }
                .foregroundColor(.white)
                .accessibilityLabel(Text("Forgot Password"))
            }
            .padding(.trailing)
        }

        private var signInButton: some View {
            Button(action: {
                viewModel.login()
            }) {
                HStack {
                    if viewModel.isLoggingIn {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("SIGN IN")
                            .fontWeight(.bold)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(red: 255/255, green: 223/255, blue: 0/255)) // Màu vàng
                .cornerRadius(8)
                .foregroundColor(.black) // Màu chữ đen
                .accessibilityLabel(Text("Sign In"))
            }
            .disabled(viewModel.isLoggingIn)
        }

        private var signUpPrompt: some View {
            HStack {
                Text("Do you have an account?")
                    .foregroundColor(.white)
                    .accessibilityLabel(Text("Do you have an account?"))

                NavigationLink {
                    CreateAccountView()
                } label: {
                    Text("Create an account")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .accessibilityLabel(Text("Create an account"))
                }
            }
            .padding(.top, 20) // Thêm khoảng cách với nút SIGN IN
        }
}

// MARK: - Xem trước
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
