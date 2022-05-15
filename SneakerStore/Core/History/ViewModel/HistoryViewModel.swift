//
//  HistoryViewModel.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 08.05.2022.
//

import Foundation


class HistoryViewModel : ObservableObject {
    @Published var orders = [Order]()
    
    let orderService = OrderService()
    
    init () {
        fetchOrders()
    }
    
    func fetchOrders () {
        orderService.fetchHistory { orders in
            self.orders = orders
            
            for index in 0..<orders.count {
                self.orderService.fetchSneakers(longitude: String(orders[index].longitude), totalPrice: String(orders[index].totalPrice)) { sneakers in
                    self.orders[index].sneakers = sneakers
                }
            }
        }
    }
}
