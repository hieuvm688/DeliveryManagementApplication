//
//  DispatchView.swift
//  DeliveryManagementApplication
//
//  Created by Vũ Minh Hiếu on 25/5/25.
//

import SwiftUI

// DispatchView.swift
struct DispatchView: View {
    @StateObject var viewModel = DispatchViewModel()

    var body: some View {
        VStack {
            TextField("Destination", text: $viewModel.destination)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Dispatch") {
                viewModel.dispatch()
            }
        }
        .navigationTitle("Dispatch")
    }
}
