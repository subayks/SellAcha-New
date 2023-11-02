//
//  HomeView.swift
//  SellAcha
//
//  Created by Subaykala on 11/10/23.
//

import UIKit
import Charts

class HomeView: UIViewController, ChartViewDelegate {

    @IBOutlet weak var processingCountLabel: UILabel!
    @IBOutlet weak var completedCountLabel: UILabel!
    @IBOutlet weak var pendingCountLabel: UILabel!
    @IBOutlet weak var color3Button: UIButton!
    @IBOutlet weak var color2Button: UIButton!
    @IBOutlet weak var color1Button: UIButton!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var dashScrollView: UIScrollView!
    @IBOutlet weak var tableViewMonth: UITableView!
    @IBOutlet weak var earning1View: LineChartView!
    @IBOutlet weak var itemSearchBar: UISearchBar!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var earning2View: LineChartView!
    
    let viewwModel = HomeViewModel()
    var entries = [ChartDataEntry]()
    let homeViewModel = HomeViewModel()

    var dataEntries: [ChartDataEntry] = []
    var dataEntries2: [ChartDataEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.viewwModel.getStaticData()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewwModel.errorClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                if error != "" {
                    let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        self.viewwModel.alertClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        self.viewwModel.showLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.showSpinner(onView: self.view)
            }
        }
        
        self.viewwModel.hideLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.removeSpinner()
            }
        }
        
        self.viewwModel.updateView = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.setChart(dataPoints: self.viewwModel.month, values: self.viewwModel.unitsSold)
                self.setChart2(dataPoints2: self.viewwModel.month2, values2: self.viewwModel.unitsSold2)
                self.setupPieChartData()
                self.pendingCountLabel.text = self.viewwModel.orderStaticsData?.totalPending ?? ""
                self.completedCountLabel.text = self.viewwModel.orderStaticsData?.totalCompleted ?? ""
                self.processingCountLabel.text = self.viewwModel.orderStaticsData?.totalProcessing ?? ""
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    
    func setupView() {
        
        earning1View.layer.cornerRadius = 20
        pieChartView.layer.cornerRadius = 20
        earning2View.layer.cornerRadius = 20
        self.tableViewMonth.isHidden = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileView.isUserInteractionEnabled = true
        profileView.addGestureRecognizer(tapGestureRecognizer)
        
    //Set Delegate
        pieChartView.delegate = self
        self.earning1View.delegate = self
        self.earning2View.delegate = self
        
        self.color1Button.layer.cornerRadius = self.color1Button.frame.height/2
        self.color2Button.layer.cornerRadius = self.color2Button.frame.height/2
        self.color3Button.layer.cornerRadius = self.color3Button.frame.height/2
    }
    
    @IBAction func actionMonth(_ sender: Any) {
        self.tableViewMonth.isHidden = false
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ProfileView") as! ProfileView
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func setupPieChartData() {
        let primaryColor = NSUIColor(cgColor: UIColor(named: "PrimaryColor")!.cgColor)
        
        let pieChartDataSet = PieChartDataSet(entries: [
            PieChartDataEntry(value: Double(self.viewwModel.orderStaticsData?.totalPending ?? "") ?? 0.0, label: ""),
            PieChartDataEntry(value:  Double(self.viewwModel.orderStaticsData?.totalCompleted ?? "") ?? 0.0, label: ""),
            PieChartDataEntry(value:  Double(self.viewwModel.orderStaticsData?.totalProcessing ?? "") ?? 0.0, label: ""),
        ])
        
        pieChartDataSet.colors = [
            primaryColor,
            UIColor.green,
            UIColor.yellow,
        ]
        
        let set = pieChartDataSet
        let data = PieChartData(dataSet: set)
        pieChartView.data = data
        pieChartView.holeRadiusPercent = 0.8
        pieChartView.transparentCircleRadiusPercent = 0.8
        
        let centerText = "\( Double(self.viewwModel.orderStaticsData?.totalOrders ?? "") ?? 0.0) \n Total Orders" // Replace with your desired label
        let centerTextAttributed = NSMutableAttributedString(string: centerText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        centerTextAttributed.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: centerText.count))
        pieChartView.centerAttributedText = centerTextAttributed
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        pieChartView.data?.setDrawValues(false)
        pieChartView.data?.setValueTextColor(.clear)
    }
    
    
    func setChart(dataPoints: [String], values: [Double]) {

        for i in 0 ..< dataPoints.count {
            dataEntries.append(ChartDataEntry(x: Double(i), y: Double(values[i])))
        }

        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "")
        lineChartDataSet.axisDependency = .left
        lineChartDataSet.setColor(UIColor(rgb: 0x0191B5))
        lineChartDataSet.setCircleColor(UIColor(rgb: 0x0191B5)) // our circle will be dark red
        lineChartDataSet.lineWidth = 2.5
        lineChartDataSet.circleRadius = 6 // the radius of the node circle
        lineChartDataSet.fillAlpha = 1
        lineChartDataSet.fillColor = UIColor.white
        lineChartDataSet.highlightColor = UIColor.white
        lineChartDataSet.drawCircleHoleEnabled = true
        lineChartDataSet.circleHoleRadius = 2.3
       

        var dataSets = [LineChartDataSet]()
        dataSets.append(lineChartDataSet)


        let lineChartData = LineChartData(dataSets: dataSets)
        earning1View.data = lineChartData
        earning1View.rightAxis.enabled = false
        earning1View.xAxis.drawGridLinesEnabled = false
        earning1View.xAxis.labelPosition = .bottom
        earning1View.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        earning1View.legend.enabled = true
    }
    
    
    func setChart2(dataPoints2: [String], values2: [Double]) {

        for i in 0 ..< dataPoints2.count {
            dataEntries2.append(ChartDataEntry(x: Double(i), y: Double(values2[i])))
        }

        let lineChartDataSet = LineChartDataSet(entries: dataEntries2, label: "")
        lineChartDataSet.axisDependency = .left
        lineChartDataSet.setColor(UIColor(rgb: 0x0191B5))
        lineChartDataSet.setCircleColor(UIColor(rgb: 0x0191B5)) // our circle will be dark red
        lineChartDataSet.lineWidth = 2.5
        lineChartDataSet.circleRadius = 6 // the radius of the node circle
        lineChartDataSet.fillAlpha = 1
        lineChartDataSet.fillColor = UIColor.white
        lineChartDataSet.highlightColor = UIColor.white
        lineChartDataSet.drawCircleHoleEnabled = true
        lineChartDataSet.circleHoleRadius = 2.3
       

        var dataSets = [LineChartDataSet]()
        dataSets.append(lineChartDataSet)


        let lineChartData2 = LineChartData(dataSets: dataSets)
        earning2View.data = lineChartData2
        earning2View.rightAxis.enabled = false
        earning2View.xAxis.drawGridLinesEnabled = false
        earning2View.xAxis.labelPosition = .bottom
        earning2View.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints2)
        earning2View.legend.enabled = true
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
      var colors: [UIColor] = []
      for _ in 0..<numbersOfColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
      }
      return colors
    }
    
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewwModel.monthDropDown.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMonth.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
        cell.textLabel?.text = viewwModel.monthDropDown[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableViewMonth.isHidden = true
        self.monthButton.setTitle(viewwModel.monthDropDown[indexPath.row], for: .normal)
        self.monthButton.setImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
    }
}

extension UIColor {

    convenience init(rgb: UInt) {
        self.init(rgb: rgb, alpha: 1.0)
    }

    convenience init(rgb: UInt, alpha: CGFloat) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}

extension UIView {

    /// Round UIView selected corners
    ///
    /// - Parameters:
    ///   - corners: selected corners to round
    ///   - radius: round amount
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
