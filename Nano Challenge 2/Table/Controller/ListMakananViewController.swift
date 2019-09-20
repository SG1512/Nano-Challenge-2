//
//  ListMakananViewController.swift
//  Nano Challenge 2
//
//  Created by Steven Gunawan on 18/09/19.
//  Copyright © 2019 Steven Gunawan. All rights reserved.
//

import UIKit
import LocalAuthentication

class ListMakananViewController: UIViewController {
    
    @IBOutlet weak var tabelListMakanan: UITableView!
    var context = LAContext()
    var state = AuthentificationState.LoggedOut
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        tabelListMakanan.reloadData()
        
        context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        state = .LoggedOut
        self.navigationItem.title = "Food List"
        self.navigationController?.navigationBar.isHidden  = false
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        AuthentificationState.LoggedOut
    }
    
    //    @IBAction func startButton(_ sender: UIButton) {
    //
    //    }
    enum AuthentificationState {
        case loggedIn, LoggedOut
    }
}

//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden  = false
//    }



//    override func prepareForSegue(segue: (UIStoryboardSegue), sender: AnyObject!)
//    {
//        if segue.identifier == "goToFoodPage" {
//            let viewControllerB = segue.destination as! ListMakananViewController
//            viewControllerB.dataPassed = labelOne.text
//        }
//    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let detail = segue.destination as! ViewController
//        detail.passedDataString = "234"
////        if let indexPath = tabelListMakanan.indexPathForSelectedRow{
////            let pickup = namaMakan[indexPath.row]
////            detailNotification.objPickUp = pickup
//        }
//    }

//
//    @IBAction func unwindToViewController(_ sender: UIStoryboardSegue) {
//        if let sourceViewController = sender.sourceViewController as? ListMakananViewController {
////            dataRecieved = sourceViewController.dataPassed
//        }






/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


extension ListMakananViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableMakanan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listMakanCell", for: indexPath) as! ListMakananTableViewCell
        
        let calori  = tableMakanan[indexPath.row].kaloriMakanan
        
        cell.namaMakanan.text = tableMakanan[indexPath.row].namaMakanan
        cell.jumlahKalori.text = "\(calori) kkal"
        return cell
    }
    
    func cellDelegate(){
        tabelListMakanan.dataSource = self
        tabelListMakanan.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let a = User(userNamaMakanan: tableMakanan[indexPath.row].namaMakanan, userKaloriMakanan: tableMakanan[indexPath.row].kaloriMakanan)
        tableUser.append(a)
        
        if state == .loggedIn
        {
            state = .LoggedOut
            
        }
        else
        {
            
            context = LAContext()
            
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
            {
                let reason = "Log in to your account"
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                    if success {
                        DispatchQueue.main.async { [unowned self] in
                            self.state = .loggedIn
                            
                            self.state = .LoggedOut
                            
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                    }
                    else
                    {
                        print(error?.localizedDescription ?? "Failed to authenticate")
                    }}
            }
            else
            {
                print(error?.localizedDescription ?? "Can't evaluate policy")
            }
            
        }
        
    }
    
    
    
}


