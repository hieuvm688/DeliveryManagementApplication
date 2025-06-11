//
//  HistoryView.swift
//  DeliveryManagementApplication
//
//  Created by Vũ Minh Hiếu on 25/5/25.
//

import SwiftUI
// HistoryView.swift
struct HistoryView: View {
    @StateObject var viewModel = HistoryViewModel()

    var body: some View {
        List(viewModel.history, id: \ .self) { entry in
            Text(entry)
        }
        .navigationTitle("History")
    }
}
