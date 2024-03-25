//
//  SearchViewController.swift
//  Weather
//
//  Created by Sergey Savinkov on 25.03.2024.
//

import UIKit

class SearchWeatherViewController: UIViewController {
    
    private let weatherView = SearchWeatherView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setDelegates()
    }
    
    private func setupViews() {
        view.addSubview(weatherView)
        weatherView.frame = self.view.frame
    }
    
    private func setDelegates() {
        weatherView.searchButtonDelegate = self
    }
}

//MARK: - SearchProtocol

extension SearchWeatherViewController: SearchProtocol {
    func searchButtonTapped() {
        self.presentSearchAlertConroller(withTitle: "Пожалуйста, введите название города в формате 'Moscow'",
                                         message: nil,
                                         style: .alert) { city in
            NetworkManager.shared.fetchCurrentWeather(forRequestType: .cityName(city: city))
        }
    }
}
