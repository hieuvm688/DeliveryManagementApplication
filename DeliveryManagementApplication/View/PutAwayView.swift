//
//  PutAwayView.swift
//  DeliveryManagementApplication
//
//  Created by Vũ Minh Hiếu on 25/5/25.
//
import SwiftUI

// PutAwayView.swift
struct PutAwayView: View {
    @StateObject var viewModel = PutAwayViewModel()

    var body: some View {
        VStack {
            TextField("Pallet Code", text: $viewModel.palletCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Location", text: $viewModel.location)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Put Away") {
                viewModel.putAway()
            }
        }
        .navigationTitle("Put Away")
    }
}
struct Content_ViewPreviews: PreviewProvider {
    static var previews: some View {
        PutAwayView()
    }
}
