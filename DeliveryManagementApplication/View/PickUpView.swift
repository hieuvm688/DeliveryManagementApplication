//
//  PickUpView.swift
//  DeliveryManagementApplication
//
//  Created by Vũ Minh Hiếu on 25/5/25.
//

import SwiftUI
// PickUpView.swift
struct PickUpView: View {
    @StateObject var viewModel = PickUpViewModel()

    var body: some View {
        VStack {
            TextField("Location", text: $viewModel.location)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Pick Up") {
                viewModel.pickUp()
            }
        }
        .navigationTitle("Pick Up")
    }
}
