//
//  WeatherView.swift
//  Weather
//
//  Created by Sergey Savinkov on 21.03.2024.
//

import UIKit

class WeatherView: UIScrollView {
    
    private var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 48)
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
        label.font = UIFont.boldSystemFont(ofSize: 42)
        label.textColor = .black
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.text = " "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var windLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .center
        label.text = " "
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = " "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var pressureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = " "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var humidityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = " "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var maxMinLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = " "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var dailyTableView = DailyTableView()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSelfScrollView()
        setupViews()
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupViews
    
    private func setupViews() {
        
        addSubview(backgroundView)
        backgroundView.addSubview(cityLabel)
        backgroundView.addSubview(tempLabel)
        backgroundView.addSubview(descriptionLabel)
        backgroundView.addSubview(maxMinLabel)
        backgroundView.addSubview(windLabel)
        backgroundView.addSubview(pressureLabel)
        backgroundView.addSubview(humidityLabel)
        backgroundView.addSubview(dailyTableView)
    }
    
    func configureSelfScrollView(){
        self.bounces = false
        self.contentInsetAdjustmentBehavior = .never
        self.showsVerticalScrollIndicator = false
        backgroundColor = .clear
    }
    
    //MARK: - SetParameters
    
    func setParameters(weatherModel: CurrentWeatherViewModel) {
        
        DispatchQueue.main.async {
            
            self.backgroundColor = self.backgroundView.backgroundColor
            self.cityLabel.text = weatherModel.locality
            self.tempLabel.text = weatherModel.temp
            self.descriptionLabel.text = weatherModel.weatherDescription.capitalizingFirstLetter()
            self.maxMinLabel.text = weatherModel.maxMinTemp
            self.windLabel.text = weatherModel.windLabel
            self.pressureLabel.text = weatherModel.pressure
            self.humidityLabel.text = weatherModel.humidity
            self.dailyTableView.frame = CGRect(x: 10,
                                               y: self.humidityLabel.frame.maxY + 30,
                                               width: self.frame.width - 20,
                                               height: DailyTableView.cellHeight * 8)
            self.dailyTableView.setWeather(cells: weatherModel.dailyWeather)
        }
    }
    
    //MARK: - SetContraints
    
    private func setContraints() {
        
        backgroundView.contentHuggingPriority(for: .vertical)
        
        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.heightAnchor.constraint(equalTo: heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: widthAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.topAnchor),
            cityLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            cityLabel.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 10),
            cityLabel.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -10),
            
            tempLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            tempLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            
            maxMinLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            maxMinLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            
            windLabel.topAnchor.constraint(equalTo: maxMinLabel.bottomAnchor, constant: 10),
            windLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            
            pressureLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: 10),
            pressureLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            
            humidityLabel.topAnchor.constraint(equalTo: pressureLabel.bottomAnchor, constant: 10),
            humidityLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
        ])
    }
}
