//
// ReceiveMaterialViewModel.swift
// DeliveryManagementApplication
//
// Created by Vũ Minh Hiếu on 25/5/25.
//
import Combine
import Foundation
import SwiftUI // Import SwiftUI for @Environment and related properties if needed elsewhere, though not strictly for Combine

class ReceiveMaterialViewModel: ObservableObject {
    @Published var materialCode = "" // This will now be used for manual input or pre-filled by QR
    @Published var receivedMaterials: [String] = [] // For the list of received materials

    // MARK: QR Scanning Related Properties
    @Published var showScanner: Bool = false // Controls presentation of the QR scanner sheet
    @Published var scannedQRCodeContent: String? // Stores the content of the scanned QR code
    @Published var showReadQRCodeButton: Bool = false // Controls visibility of the "Read QR code" button
    @Published var navigateToNextUI: Bool = false // Triggers navigation to the next UI

    // MARK: - Core Logic

    func receiveMaterial() {
        if !materialCode.isEmpty {
            receivedMaterials.append(materialCode)
            materialCode = ""
            // Optionally, clear scanned content after "submitting" a material
            scannedQRCodeContent = nil
            showReadQRCodeButton = false
        }
    }

    // Call this when QR code is successfully scanned
    func handleScannedQRCode(code: String) {
        self.scannedQRCodeContent = code
        self.showReadQRCodeButton = true
        self.showScanner = false // Dismiss the scanner automatically
    }

    // Call this when "Read QR code" button is pressed
    func readQRCodeAndNavigate() {
        if let scannedCode = scannedQRCodeContent {
            self.materialCode = scannedCode // Pre-fill the materialCode field with the scanned content
            self.navigateToNextUI = true // Trigger navigation
            // Optionally, clear the scanned content here if you want it fresh for the next scan
            // self.scannedQRCodeContent = nil
            // self.showReadQRCodeButton = false
        }
    }
}
