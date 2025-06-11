//
//  NextReceiveMaterialUI.swift
//  DeliveryManagementApplication
//
//  Created by Vũ Minh Hiếu on 11/6/25.
//


//
// NextReceiveMaterialUI.swift
// DeliveryManagementApplication
//
// Created by Vũ Minh Hiếu on 25/5/25.
//
import SwiftUI

struct NextReceiveMaterialUI: View {
    let materialCode: String // Example: Pass the scanned material code to the next view
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("Chi tiết vật liệu đã quét")
                .font(.largeTitle)
                .padding()

            Text("Mã vật liệu: \(materialCode)")
                .font(.title2)
                .padding()

            Text("Đây là giao diện tiếp theo sau khi quét QR thành công.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()

            Button("Quay lại màn hình Nhận vật liệu") {
                dismiss() // Dismiss this view
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .navigationTitle("Xử lý vật liệu")
        .navigationBarTitleDisplayMode(.inline)
    }
}