//
//  DailyTableView.swift
//  Weather
//
//  Created by Sergey Savinkov on 21.03.2024.
//

import Foundation
import UIKit

class DailyTableView: UITableView, UITableViewDataSource, UITableViewDelegate{
    
    var cells: [CurrentWeatherViewModel.Daily]?
    
    static let cellHeight: CGFloat = 45
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        delegate = self
        dataSource = self
        backgroundColor = .white
        isScrollEnabled = false
        allowsSelection = false
        
        register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.reuseId)
    }
    
    //MARK: - LayoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
    func setWeather(cells: [CurrentWeatherViewModel.Daily]){
        self.cells = cells
        reloadData()
    }
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cells = cells else { return 0 }
        
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: DailyTableViewCell.reuseId, for: indexPath) as? DailyTableViewCell else { return UITableViewCell() }
        guard let cells = cells else { return cell}
        cell.configureCell(data: cells[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DailyTableView.cellHeight
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
