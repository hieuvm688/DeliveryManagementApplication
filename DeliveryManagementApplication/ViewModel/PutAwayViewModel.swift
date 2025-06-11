//
//  PutAwayViewModel.swift
//  DeliveryManagementApplication
//
//  Created by Vũ Minh Hiếu on 25/5/25.
//
import Combine

class PutAwayViewModel: ObservableObject {
    @Published var palletCode = ""
    @Published var location = ""

    func putAway() {
        // Save data logic
    }
}
