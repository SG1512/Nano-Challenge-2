//
//  ViewController.swift
//  Nano Challenge 2
//
//  Created by Steven Gunawan on 18/09/19.
//  Copyright © 2019 Steven Gunawan. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    
    let healthStore = HKHealthStore()
    let sampleData = [String]()
    var targetDist : Double = 0.0
    var jumlahDist : Double = 0.0
    @IBOutlet weak var circularProgress: CircularProgressView!
    
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var deskripsiJarak: UILabel!
    @IBOutlet weak var labelPersen: UILabel!
    @IBOutlet weak var targetDistance: UILabel!
    @IBOutlet weak var jumlahDistance: UILabel!
    @IBOutlet weak var homeTable: UITableView!
    @IBOutlet weak var totalKalori: UILabel!
    var grandTotal : Int = 0
    var percentage : Float = 0.5
    
    let shapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        targetKalori()
        checkAvailability()
        getHealthData()
        
        self.navigationController?.navigationBar.isHidden  = true
        
        circularProgress.trackColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        circularProgress.progressColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        circularProgress.setProgressWithAnimation(duration: 1.0, value: percentage)
        buttonAdd.layer.shadowColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        buttonAdd.layer.shadowRadius = 2
        buttonAdd.layer.shadowOpacity = 0.7
        buttonAdd.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        
    }
    
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        homeTable.reloadData()
        totalCalories()
        targetKalori()
        calculatePercentage()
        
    }
    
    
    
    
    
    @IBAction func buttonDiTekan(_ sender: Any) {
        performSegue(withIdentifier: "goToFoodPage", sender: self)
    }
    
    func totalCalories()  {
        grandTotal = 0
        for index in tableUser{
            grandTotal += index.userKaloriMakanan
        }
        print(grandTotal)
        totalKalori.text = "\(grandTotal)"
    }
    
    func checkAvailability(){
        if HKHealthStore.isHealthDataAvailable(){
            let allTypes = Set([HKObjectType.workoutType(),
                                HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                                HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                                HKObjectType.quantityType(forIdentifier: .heartRate)!,
                                HKObjectType.quantityType(forIdentifier: .stepCount)!])
            
            healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
                if !success { print ("error")
                }
            }
        }
    }
    
        func calculatePercentage(){
           
            
        let fraction = (targetDist - jumlahDist) / targetDist
            print(fraction)
      
            self.labelPersen.text = String(format: "%2f", fraction)
//            String(format:"%.2f", self.jumlahDist)
            
    }
           
    
           
    
    
    
    
    func getHealthData() {
        let calendar = NSCalendar.current
        let interval = NSDateComponents()
        let now = NSDate()
        interval.day = 1
        
        
        var components = calendar.dateComponents([.year, .month, .day], from: now as Date)
        components.hour = 0
        
        guard let anchorDate = calendar.date(from: components) else {
            fatalError("*** unable to create a valid date from the given components ***")
        }
        
        guard let sampleType = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            fatalError("*** This method should never fail ***")
        }
        
        
        let query = HKStatisticsCollectionQuery(quantityType: sampleType,
                                                quantitySamplePredicate: nil,
                                                options: .cumulativeSum,
                                                anchorDate: anchorDate,
                                                intervalComponents: interval as DateComponents)
        
        query.initialResultsHandler = {
            query, results, error in
            
            guard let statsCollection = results else {
                // Perform proper error handling here
                fatalError("*** An error occurred while calculating the statistics: \(error?.localizedDescription) ***")
            }
            
            let endDate = NSDate()
            
            guard let startDate = calendar.date(byAdding: .day, value: -7, to: endDate as Date) else {
                fatalError("*** Unable to calculate the start date ***")
            }
            
            statsCollection.enumerateStatistics(from: startDate, to: endDate as Date) { [unowned self] statistics, stop in
                
                if let quantity = statistics.sumQuantity() {
                    let date = statistics.startDate
                    let steps = quantity.doubleValue(for: HKUnit.meter())
                    print("\(date): steps = \(steps)")
                    //                    self.plotWeeklyStepCount(value, forDate: date)
                    
                    //                    let cale = calendar.component(.day, from: .distantPast)
                    //                    self.labelS.text = "\(cale)"
                    
                    DispatchQueue.main.async {
                        let step1 = steps / 1000
                        self.jumlahDist =  step1
                        self.jumlahDistance.text =  String(format:"%.2f", self.jumlahDist)
                    }
                }
            }
        }
        
        self.healthStore.execute(query)
    }
    
    
    func targetKalori(){
        switch grandTotal {
        case Int.min...10:
            targetDist = 0
            targetDistance.text = "\(targetDist)"
            deskripsiJarak.text = "Dont forget to eat!";
            break
        case 10...1200:
            targetDist = 1.6
            targetDistance.text = "\(targetDist)"
            deskripsiJarak.text = "You have to walk 1.6 km, Burn your calories!";
            break
        case 1200...2200:
            targetDist = 3.0
            targetDistance.text =  "\(targetDist)"
            deskripsiJarak.text = "You have to walk 3 km, Burn your calories!";
            break
        case 2200...3000:
            targetDist = 5.0
            targetDistance.text =  "\(targetDist)"
            deskripsiJarak.text = "You have to walk 5 km, Burn your calories!";
            break
        default:
            print("nah")
        }
    }
    
}

extension ViewController:UITableViewDelegate,  UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listEatenCell", for: indexPath) as! HomeTableViewCell
        
        let kalori = tableUser[indexPath.row].userKaloriMakanan
        
        cell.namaMakananHome.text = tableUser[indexPath.row].userNamaMakanan
        cell.jumlahKaloriHome.text = "\(kalori) kkal"
        
        return cell
    }
    
    func cellDelegate(){
        homeTable.delegate = self
        homeTable.dataSource = self
    }
    
}


