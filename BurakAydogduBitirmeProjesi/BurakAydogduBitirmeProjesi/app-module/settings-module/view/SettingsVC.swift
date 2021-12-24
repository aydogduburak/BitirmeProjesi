//
//  SettingsVC.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import UIKit

class SettingsVC: UIViewController {

    var user: Users?
    @IBOutlet weak var tableViewSettings: UITableView!
    
    let tColor = UIColor(named: "tColor")
    let bgColor = UIColor(named: "bgColor")
    let blueColor = UIColor(named: "blueColor")
    //let yellowColor = UIColor(named: "yellowColor")
    
    var settingsList = [SettingsList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableViewSettings.dataSource = self
        tableViewSettings.delegate = self
        
        self.navigationItem.title = "Settings"
        let apperance = UINavigationBarAppearance()
        apperance.titleTextAttributes = [.foregroundColor : blueColor!, NSAttributedString.Key.font : UIFont(name: "SourceSans3-BlackItalic", size: 30)!]
        view.backgroundColor = bgColor
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.standardAppearance = apperance
        navigationController?.navigationBar.compactAppearance = apperance
        
        let s1 = SettingsList(cellIcon: "person", cellTitle: "Your Account", cellExplanation: "See information about your account, or learn about your account deactivation options.")
        let s2 = SettingsList(cellIcon: "lock", cellTitle: "Security and account access", cellExplanation: "Manage your account's security and keep track of your account's usage including apps that you have connected to your account.")
        let s3 = SettingsList(cellIcon: "shield.lefthalf.filled", cellTitle: "Privacy and safety", cellExplanation: "Manage what information you see and share")
        let s4 = SettingsList(cellIcon: "bell", cellTitle: "Notifications", cellExplanation: "Select the kinds of notifications you get about your activities, interests, and recommendations.")
        let s5 = SettingsList(cellIcon: "pencil.tip.crop.circle", cellTitle: "Accessibility, display, and languages", cellExplanation: "Manage how Food&Drink content is displayed to you.")
        settingsList.append(s1)
        settingsList.append(s2)
        settingsList.append(s3)
        settingsList.append(s4)
        settingsList.append(s5)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAccount" {
            let user = sender as? Users
            let toVC = segue.destination as! AccountVC
            toVC.user = user
        }
    }
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settings = settingsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsTableViewCell
        cell.setData(settings: settings)
        cell.backgroundColor = bgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            performSegue(withIdentifier: "toAccount", sender: user)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
