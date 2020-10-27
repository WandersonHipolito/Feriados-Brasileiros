//
//  FeriadosTableViewController.swift
//  Feriados Brasileiros
//
//  Created by Wanderson Hipolito on 21/10/20.
//

import UIKit

class HolidayTableViewController: UITableViewController {

    var listHolidays = [HolidayDetails](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listHolidays.count) feriados encontrados"
                
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.getHolidaysInformation()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listHolidays.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let holiday = listHolidays[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FerriadoCell", for: indexPath)
        cell.textLabel?.text = holiday.name
        cell.detailTextLabel?.text = holiday.date.iso
        return cell
        
    }
    
    
    //MARK: - table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "gotoDetails", sender: nil)
    }

    
    
    
    
    //MARK: - segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gotoDetails"{
            
            if let controllerVC = segue.destination as? HolidayDetailsViewController{
                
                controllerVC.descriptionHoliday = listHolidays[(tableView.indexPathForSelectedRow?.row)!]
                
            }
        }
    }
    
    func getHolidaysInformation() {
        
        let holidayNetworkManager = HolidayNetworkManager(codCountry: "BR")
        holidayNetworkManager.getHolidays { [weak self] result in
            switch result{
            
            case .failure(let error):
                print(error.localizedDescription)
                
            case .success(let holidays):
                self?.listHolidays = holidays
                
            }
        }
        
    }

}
