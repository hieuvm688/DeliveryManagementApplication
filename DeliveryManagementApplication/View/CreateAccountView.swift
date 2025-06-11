//
//  CreateAccountView.swift
//  DeliveryManagementApplication
//
//  Created by Vũ Minh Hiếu on 19/5/25.
//
import SwiftUI

struct CreateAccountView: View {
    // MARK: - Các biến trạng thái
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isSigningUp = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Nội dung màn hình
    var body: some View {
        VStack {
            NavigationStack{
                // Tiêu đề "Create Account"
                Text("Create Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 32)
                    .foregroundColor(.primary) // Màu sắc có thể tùy chỉnh
                
                // Trường nhập Full Name
                TextField("Full Name", text: $fullName)
                    .padding()
                    .multilineTextAlignment(.center)
                    .background(Color.white) // Màu nền trắng
                    .cornerRadius(8)
                    .shadow(radius: 2) // Thêm bóng đổ
                    .overlay( // Biểu tượng người dùng bên trái
                        HStack {
                            Image(systemName: "person")
                                .foregroundColor(.gray) // Màu xám cho biểu tượng
                                .padding(.leading, 8)
                            Spacer()
                        }, alignment: .leading
                    )
                
                // Trường nhập Email
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .multilineTextAlignment(.center)
                    .background(Color.white) // Màu nền trắng
                    .cornerRadius(8)
                    .shadow(radius: 2) // Thêm bóng đổ
                    .overlay( // Biểu tượng email bên trái
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.gray) // Màu xám cho biểu tượng
                                .padding(.leading, 8)
                            Spacer()
                        }, alignment: .leading
                    )
                
                // Trường nhập Password
                SecureField("Password", text: $password)
                    .padding()
                    .multilineTextAlignment(.center)
                    .background(Color.white) // Màu nền trắng
                    .cornerRadius(8)
                    .shadow(radius: 2) // Thêm bóng đổ
                    .overlay( // Biểu tượng khóa bên trái
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.gray) // Màu xám cho biểu tượng
                                .padding(.leading, 8)
                            Spacer()
                        }, alignment: .leading
                    )
                
                // Trường nhập Confirm Password
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .multilineTextAlignment(.center)
                    .background(Color.white) // Màu nền trắng
                    .cornerRadius(8)
                    .shadow(radius: 2) // Thêm bóng đổ
                    .overlay( // Biểu tượng khóa bên trái
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.gray) // Màu xám cho biểu tượng
                                .padding(.leading, 8)
                            Spacer()
                        }, alignment: .leading
                    )
                
                // Khoảng trắng
                Spacer().frame(height: 32)
                
                // Nút "SIGN UP"
                Button(action: {
                    // TODO: Xử lý đăng ký tài khoản
                    isSigningUp = true
                    // Simulate a signup delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isSigningUp = false
                        if password == confirmPassword && !fullName.isEmpty && !email.isEmpty{
                            alertMessage = "Sign up successful!"
                            showAlert = true
                        } else {
                            alertMessage = "Invalid information. Please check your fields."
                            showAlert = true
                        }
                    }
                    print("Sign up button tapped with fullName: \(fullName), email: \(email), password: \(password), confirmPassword: \(confirmPassword)")
                }) {
                    HStack {
                        if isSigningUp {
                            ProgressView() // Hiển thị loading indicator
                                .tint(.white)
                        } else {
                            Text("SIGN UP") // Hiển thị chữ SIGN UP
                                .fontWeight(.bold)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange) // Màu cam cho nút SIGN UP
                    .cornerRadius(8)
                    .foregroundColor(.white) // Màu chữ trắng
                }
                .disabled(isSigningUp) // Vô hiệu hóa nút khi đang đăng ký
                
                // Nhãn "Already have an account? Sign in"
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.gray) // Màu xám
                    NavigationLink{
                        LoginView()
                    } label: {
                        Text("Login")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .accessibilityLabel("Login")
                    }
                }
                .padding(.top, 16)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1)) // Màu nền xám nhạt
        .alert(isPresented: $showAlert) { // Alert hiển thị thông báo
            Alert(
                title: Text("Message"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    if alertMessage == "Sign up successful!" {
                        // TODO: Navigate to the main app screen
                    }
                }
            )
        }
        .navigationBarBackButtonHidden(true) // Ẩn nút back mặc định của navigation bar
        .toolbar { // Thêm nút back tùy chỉnh
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    // TODO: Xử lý khi nút back được nhấn (ví dụ: pop view)
                    dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.blue) // Màu xanh cho nút back
                }
            }
        }
    }
}

struct ContentPreview : PreviewProvider {
    static var previews: some View {
        VStack {
            CreateAccountView()
        }
    }
}
