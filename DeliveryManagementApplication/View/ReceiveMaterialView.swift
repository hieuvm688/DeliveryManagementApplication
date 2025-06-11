//
// ReceiveMaterialView.swift
// DeliveryManagementApplication
//
// Created by Vũ Minh Hiếu on 25/5/25.
//
import SwiftUI

struct ReceiveMaterialView: View {
    @StateObject var viewModel = ReceiveMaterialViewModel()
    @Environment(\.dismiss) var dismiss // For dismissing the sheet if needed

    var body: some View {
        VStack {
            // Original TextField and Submit Button
            TextField("Enter Material Code", text: $viewModel.materialCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.horizontal, .top])

            Button("Submit") {
                viewModel.receiveMaterial()
            }
            .padding(.bottom)

            // MARK: - QR Code Scanning Section

            Button(action: {
                viewModel.showScanner = true
            }) {
                HStack {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan QR Code")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(10)
            }
            .padding(.horizontal)

            // Display scanned QR code content if available
            if let scannedContent = viewModel.scannedQRCodeContent {
                Text("Scanned QR: \(scannedContent)")
                    .font(.headline)
                    .padding(.top)
                    .foregroundColor(.blue)

                // "Read QR code" button to trigger navigation
                if viewModel.showReadQRCodeButton {
                    Button("Read QR code") {
                        viewModel.readQRCodeAndNavigate()
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor) // Use accentColor or another distinct color
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 5)
                }
            }

            // List of received materials
            List(viewModel.receivedMaterials, id: \.self) { material in
                Text(material)
            }
            .padding(.top) // Add padding to separate from QR section
        }
        .navigationTitle("Receive Material")
        // Use .sheet for QR scanner
        .sheet(isPresented: $viewModel.showScanner) {
            QRScannerView { scannedCode in
                // This closure is called when a QR code is successfully scanned
                viewModel.handleScannedQRCode(code: scannedCode)
            }
        }
        // Navigation for "Read QR code" button (iOS 16+)
        // If targeting < iOS 16, use NavigationLink (see alternative below)
        .navigationDestination(isPresented: $viewModel.navigateToNextUI) {
            // Pass any data you need to the next view
            NextReceiveMaterialUI(materialCode: viewModel.materialCode)
        }
    }
}

// MARK: - Alternative for Navigation (iOS 14/15)

/*
// If you need to support iOS 14/15, you would structure navigation like this:
struct ReceiveMaterialView_iOS14_15: View {
    @StateObject var viewModel = ReceiveMaterialViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView { // Ensure you have a NavigationView higher up if this is not the root
            VStack {
                // ... (existing TextField, Submit Button, Scan QR Code Button) ...

                if let scannedContent = viewModel.scannedQRCodeContent {
                    Text("Scanned QR: \(scannedContent)")
                        .font(.headline)
                        .padding(.top)
                        .foregroundColor(.blue)

                    if viewModel.showReadQRCodeButton {
                        NavigationLink(
                            destination: NextReceiveMaterialUI(materialCode: viewModel.materialCode),
                            isActive: $viewModel.navigateToNextUI // Binds activation to the state
                        ) {
                            Button("Read QR code") {
                                // The isActive binding will handle navigation, no direct action needed here.
                                // But we call it to ensure the state updates and triggers the link.
                                viewModel.readQRCodeAndNavigate()
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .padding(.top, 5)
                        }
                        .isDetailLink(false) // Prevents pushing to a new stack on iPad
                    }
                }

                // ... (rest of your List) ...
            }
            .navigationTitle("Receive Material")
            .sheet(isPresented: $viewModel.showScanner) {
                QRScannerView { scannedCode in
                    viewModel.handleScannedQRCode(code: scannedCode)
                }
            }
        }
    }
}
*/
