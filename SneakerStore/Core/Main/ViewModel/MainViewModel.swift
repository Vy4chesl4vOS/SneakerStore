//
//  MainViewModel.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 02.05.2022.
//

import Foundation

class MainViewModel : ObservableObject {
    @Published var sneakers: Sneakers?
    @Published var searchText: String = ""
    
    var filteredSneakers : Sneakers? {
        if var sneakers = sneakers {
            let filteredResults = sneakers.results.filter({$0.image?.original != "" && !($0.image?.original?.contains("stockx"))! })
            sneakers.results = filteredResults
            return sneakers
        } else {
            return self.sneakers
        }
    }
    
    init () {
        self.fetchSneakers()
    }
    
    func fetchSneakers () {
        NetworkManager.shared.fetch {[weak self] fetchedSneakers in
            self?.sneakers = fetchedSneakers
            
        }
    }
}
