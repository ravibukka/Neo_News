//
//  DetailsViewController.swift
//  NeoStats
//
//  Created by Ravi on 12/02/23.
//

import Foundation
import UIKit
import Charts

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var lineChart: LineChartView!
    var startDateRecieved = Date()
    var endDateRecieved = Date()
    var asteroidsObj: AsteriodsModel?
    var asteriodNumber:[Int] = []
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        activityIndicator.startAnimating()
        
        asteroidAPI { [self] (data, status, message) in
            sleep(2)
            guard status! else {
                return
            }
            self.asteroidsObj = data
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    //MARK: Asteroid Neo Api Handler method
    func asteroidAPI(completion:@escaping (AsteriodsModel?,Bool?,String)-> Void) {
        let params:[String:Any] = [
            "start_date":startDateRecieved,
            "end_date":endDateRecieved,
            "api_key":"1wdbNzQ8XQfgfGXUQ4lkUibXkptSkAViCBF2wfkC"
        ]
        NetworkManager.getRequest(params: params) {(response) in
            guard response.success ?? false else {
                completion(nil,response.success!, response.message!)
                return
            }
            let asteroidDetails = AsteriodsModel.init(fromJSON: response.responseJSON!["near_earth_objects"], fromDate: self.startDateRecieved, toDate: self.endDateRecieved)
            self.asteriodNumber = asteroidDetails.numberOfAsteriods
            self.updateChart()
            completion(asteroidDetails,response.success!, response.message!)
        }
    }
    
    func updateChart(){
        
        var dataEntries: [ChartDataEntry] = []
        let dataPoints = self.asteriodNumber
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(dataPoints[i]), y: Double(i))
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Dates")
        lineChartDataSet.colors = [NSUIColor .red]
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChart.data = lineChartData
        
    }
    
}
