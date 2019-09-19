//
//  ViewController.swift
//  Nano Challenge 2
//
//  Created by Steven Gunawan on 18/09/19.
//  Copyright © 2019 Steven Gunawan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    var passedDataString = "123"
    @IBOutlet weak var homeTable: UITableView!
    @IBOutlet weak var totalKalori: UILabel!
    var grandTotal : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homeTable.reloadData()
        totalCalories()
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
    
//    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
//        // Use data from the view controller which initiated the unwind segue
//    }
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

