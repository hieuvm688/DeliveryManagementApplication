import Foundation
import Combine

// MARK: - ViewModel cho màn hình Login
class LoginViewModel: ObservableObject {
    // MARK: - Các biến trạng thái
    @Published var email = ""
    @Published var password = ""
    @Published var isLoggingIn = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var loginSuccess = false // Biến trạng thái để theo dõi đăng nhập thành công
    @Published var isCreateAccountEnable: Bool = false
    
    // MARK: - Các biến private
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Khởi tạo
    init() {
        // Thực hiện các khởi tạo cần thiết, ví dụ: thiết lập giá trị ban đầu
    }
    
    // MARK: - Hàm xử lý đăng nhập
    func login() {
        isLoggingIn = true
        // Simulate a login delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in // Thêm [weak self] để tránh retain cycle
            guard let self = self else { return } // Kiểm tra self có còn tồn tại không
            self.isLoggingIn = false
            // Xác thực thông tin đăng nhập (ví dụ: gọi API)
            if self.email != "" && self.password != "" {
                self.alertMessage = "Login successful!"
                self.showAlert = true
                self.loginSuccess = true // Cập nhật trạng thái đăng nhập thành công
            } else {
                self.alertMessage = "Invalid credentials. Please try again."
                self.showAlert = true
            }
        }
        print("Login button tapped with email: \(email), password: \(password)")
    }
    
    // MARK: - Hàm xử lý quên mật khẩu
    func forgotPassword() {
        // TODO: Xử lý quên mật khẩu
        print("Forgot Password Tapped")
        //  Thêm logic chuyển màn hình hoặc hiển thị thông báo tại đây
    }
    
    // MARK: - Hàm xử lý đăng ký
    func signUp() {
        // TODO: Chuyển đến màn hình đăng ký
        
    }
    
    // MARK: - Hàm huỷ
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}
