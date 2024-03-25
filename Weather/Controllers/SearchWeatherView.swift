//
//  SearchViewController.swift
//  Weather
//
//  Created by Sergey Savinkov on 25.03.2024.
//

import UIKit

protocol SearchProtocol: AnyObject {
    func searchButtonTapped()
}

class SearchWeatherView: UIView {
    
    private var backgroundView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 46)
        label.textColor = .black
        
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.text = " "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.textColor = .black
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.text = " "
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Для ПОИСКА"
        label.translatesAutoresizingMaskIntoConstraints = false
      
        return label
    }()
    
    private var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "нажмите на иконку "
        label.translatesAutoresizingMaskIntoConstraints = false
       
        return label
    }()
    
    private var minMaxLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "сверху экрана"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var weatherImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var dailyTableView = DailyTableView()
    
    weak var searchButtonDelegate: SearchProtocol?
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        networkManager()
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupViews
    
    private func setupViews() {
        backgroundColor = .white
        
        addSubview(backgroundView)
        addSubview(searchButton)
        
        backgroundView.addSubview(weatherImageView)
        addSubview(cityLabel)
        addSubview(tempLabel)
        addSubview(descriptionLabel)
        addSubview(minMaxLabel)
        addSubview(feelsLikeLabel)
    }
    
    private func networkManager() {
        NetworkManager.shared.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.setParameters(weatherModel: currentWeather)
        }
    }
    
    @objc private func searchButtonTapped() {
        searchButtonDelegate?.searchButtonTapped()
    }
    
    //MARK: - SetParameters
    
    func setParameters(weatherModel: CurrentWeather) {
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.8,
                           delay: 0.0,
                           options: [.allowUserInteraction], animations:
                            { () -> Void in
                self.backgroundView.alpha = 1 })
            
            self.setBackgroundColor(icon: weatherModel.icon)
            self.backgroundColor = self.backgroundView.backgroundColor
            self.descriptionLabel.text = weatherModel.weatherDescription.capitalizingFirstLetter()
            self.minMaxLabel.text = "Мин.:\(weatherModel.tempMin)º, мaкс.:\(weatherModel.tempMax)º"
            self.weatherImageView.image = UIImage(named: weatherModel.icon)
            self.cityLabel.text = weatherModel.cityName
            self.tempLabel.text = "\(weatherModel.temperatureString)°C"
            self.feelsLikeLabel.text = "Ощущается как \(weatherModel.feelsLikeTemperatureString)"
        }
    }
    
    private func setBackgroundColor(icon: String){
        switch icon {
        case "01d":
            backgroundView.backgroundColor = .specialDay
        case "02d", "03d", "04d", "unknown":
            backgroundView.backgroundColor = .specialCloudyDay
        case "09d","09n", "10d","10n", "13d", "13n":
            backgroundView.backgroundColor = .specialRainyDay
        case "50d":
            backgroundView.backgroundColor = .specialWind
        case "01n", "02n", "03n", "04n":
            backgroundView.backgroundColor = .specialNight
        case "11d", "11n":
            backgroundView.backgroundColor = .specialThunderstorm
        case "50n":
            backgroundView.backgroundColor = .specialWindNight
        default:
            backgroundView.backgroundColor = .specialDay
        }
    }
    
    //MARK: - SetContraints
    
    private func setContraints() {
        
        backgroundView.contentHuggingPriority(for: .vertical)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            searchButton.widthAnchor.constraint(equalToConstant: 70),
            searchButton.heightAnchor.constraint(equalToConstant: 70),
                   
            weatherImageView.bottomAnchor.constraint(equalTo: cityLabel.topAnchor, constant: 20),
            weatherImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 150),
            weatherImageView.heightAnchor.constraint(equalToConstant: 150),
        
            cityLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            cityLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            cityLabel.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 10),
            cityLabel.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -10),
        
            tempLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
            tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            tempLabel.widthAnchor.constraint(equalToConstant: 200),

            descriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 5),
            descriptionLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 30),
       
            feelsLikeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            feelsLikeLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            feelsLikeLabel.heightAnchor.constraint(equalToConstant: 30),
            
            minMaxLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: 10),
            minMaxLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            minMaxLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
