//
//  ViewController.swift
//  CarthageManagerDependences
//
//  Created by Marilise Morona on 06/06/23.
//

import UIKit
import Charts
import Alamofire

class ViewController: UIViewController {

    private lazy var chartView: LineChartView = {
      let chart = LineChartView()
        chart.backgroundColor = .systemBlue
        chart.rightAxis.enabled = false
        chart.leftAxis.labelPosition = .outsideChart
        chart.xAxis.labelPosition = .bottom
        chart.animate(xAxisDuration: 2.5)
        return chart
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(chartView)
        addAnchorConstraints()
        createChart()
        print("viewDidLoad")
        
    }

    private func addAnchorConstraints(){
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        chartView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chartView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        chartView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    private func createChart() {
        
        guard let url = Bundle.main.url(forResource: "chartDataEntry", withExtension: "json") else { return }
            AF.request(url).response { response in
                guard let data = response.data else { return }
                do {
                    let model = try JSONDecoder().decode([DataEntryModel].self, from: data)
                    
                    let yValues = model.map { ChartDataEntry(x: $0.x, y: $0.y) }
                    let set1 = LineChartDataSet(entries: yValues, label: "")
                    set1.mode = .cubicBezier
                    set1.drawCirclesEnabled = false
                    
                    let data = LineChartData(dataSet: set1)
                    data.setDrawValues(false )
                    self.chartView.data = data
                } catch let error {
                    print(error.localizedDescription)
                }
            }
    }
    
}
