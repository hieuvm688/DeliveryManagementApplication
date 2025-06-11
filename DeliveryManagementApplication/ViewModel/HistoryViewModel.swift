//
//  HistoryViewModel.swift
//  DeliveryManagementApplication
//
//  Created by Vũ Minh Hiếu on 25/5/25.
//
import Combine
class HistoryViewModel: ObservableObject {
    @Published var history: [String] = ["Received: Box A", "Dispatched: Box B"]
}
