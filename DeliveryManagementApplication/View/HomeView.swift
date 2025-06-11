//
//  HomeView.swift
//  DeliveryManagementApplication
//
//  Created by Vũ Minh Hiếu on 25/5/25.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Receive Material", destination: ReceiveMaterialView())
                NavigationLink("Store Layout", destination: StoreLayoutView())
                NavigationLink("Put Away", destination: PutAwayView())
                NavigationLink("Pick Up", destination: PickUpView())
                NavigationLink("Dispatch", destination: DispatchView())
                NavigationLink("History", destination: HistoryView())
                NavigationLink("Report", destination: ReportView())
            }
            .navigationTitle("WH Store")
        }
    }
}
