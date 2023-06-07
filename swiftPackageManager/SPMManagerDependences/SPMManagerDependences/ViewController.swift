//
//  ViewController.swift
//  SPMManagerDependences
//
//  Created by Marilise Morona on 07/06/23.
//

import UIKit
import Charts
import Alamofire
import TinyConstraints

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
        addConstraints()
        createChart()
        print("viewDidLoad")
        
    }

    private func addConstraints(){
        chartView.centerInSuperview()
        chartView.width(to: view)
        chartView.heightToWidth(of: view)
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

