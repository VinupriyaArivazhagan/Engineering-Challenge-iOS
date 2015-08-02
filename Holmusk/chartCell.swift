//
//  chartCell.swift
//  Holmusk
//
//  Created by Vinupriya on 7/31/15.
//  Copyright (c) 2015 Vinupriya. All rights reserved.
//

import UIKit
import Charts
import Realm

class chartCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var barChart: BarChartView! // view to show data
    
    var objContent = RLMArray(objectClassName: contents.className())
    var objNutrients : nutrients!
    var index : UInt!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func initialize() // initializing cell
    {
        barChart.noDataText = "No any available nutrients"
        barChart.noDataTextDescription = "No any available nutrients"
        
        var names = [String]()
        var values = [Double]()
        if objContent.count == 0
        {
            objContent .removeAllObjects()
            objContent = objNutrients.content
        }
        
        for i in 0...objContent.count-1 {
            let con = objContent.objectAtIndex(i) as! contents
            if con.name != "calories"
            {
             names.append(con.name)
             values.append(con.value)
            }
        }
        setChart(names, values: values)
        
        lblName.text = objNutrients.name
    }
    
    func setChart(dataPoints: [String], values: [Double]) // to show data from realm data storage in bar chart
    {
        barChart.noDataText = "No any available nutrients"
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Unit Grams")
        let chartData = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
        barChart.data = chartData
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
