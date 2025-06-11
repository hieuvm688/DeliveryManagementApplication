//
//  ReportView.swift
//  DeliveryManagementApplication
//
//  Created by Vũ Minh Hiếu on 25/5/25.
//

import SwiftUI
// ReportView.swift
struct ReportView: View {
    @StateObject var viewModel = ReportViewModel()

    var body: some View {
        Text("Reports will be displayed here")
            .navigationTitle("Report")
    }
}
