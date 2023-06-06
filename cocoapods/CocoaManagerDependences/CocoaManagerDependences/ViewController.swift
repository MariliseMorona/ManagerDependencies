//
//  ViewController.swift
//  CocoaManagerDependences
//
//  Created by Marilise Morona on 06/06/23.
//

import UIKit
import Charts

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
        
        print("viewDidLoad")
        addAnchorConstraints()
        createChart()
    }

    private func addAnchorConstraints(){
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        chartView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chartView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        chartView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    private func createChart() {
        let yValues = [
            ChartDataEntry(x: 0.0, y: Double.random(in: 1...10)),
            ChartDataEntry(x: 1.0, y: Double.random(in: 1...10)),
            ChartDataEntry(x: 2.0, y: Double.random(in: 1...10)),
            ChartDataEntry(x: 3.0, y: Double.random(in: 1...10)),
            ChartDataEntry(x: 4.0, y: Double.random(in: 1...10)),
            ChartDataEntry(x: 5.0, y: Double.random(in: 1...10)),
            
        ]
        
        let set1 = LineChartDataSet(entries: yValues, label: "")
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        self.chartView.data = data
    }
    
}

