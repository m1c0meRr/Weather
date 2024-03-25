//
//  MainViewCell.swift
//  Weather
//
//  Created by Sergey Savinkov on 14.03.2024.
//

import Foundation
import UIKit

class DailyTableViewCell: UITableViewCell {
    
    static let reuseId = "DailyTableViewCell"
    
    private var dayLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var maxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    private var minLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =  UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .right
        label.textColor = .gray
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    //MARK: - SetupViews
    
    private func setupViews(){
        backgroundColor = .clear
        
        contentView.addSubview(dayLabel)
        contentView.addSubview(minLabel)
        contentView.addSubview(maxLabel)
    }
    
    //MARK: - ConfigureCell
    
    func configureCell(data: CurrentWeatherViewModel.Daily){
        dayLabel.text = String(data.dt)
        minLabel.text = data.minTemp
        maxLabel.text = data.maxTemp
    }
    
    //MARK: - SetConstraints
    
    private func setConstraints(){
        
        NSLayoutConstraint.activate([
            dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            dayLabel.widthAnchor.constraint(equalToConstant: 120),
            dayLabel.heightAnchor.constraint(equalToConstant: 18),
            
            maxLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            maxLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            maxLabel.widthAnchor.constraint(equalToConstant: 45),
            
            minLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            minLabel.trailingAnchor.constraint(equalTo: maxLabel.leadingAnchor, constant: -8),
            minLabel.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
