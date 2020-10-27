//
//  DetalhesFeriadoViewController.swift
//  Feriados Brasileiros
//
//  Created by Wanderson Hipolito on 21/10/20.
//

import UIKit



class HolidayDetailsViewController: UIViewController {

    var descriptionHoliday : HolidayDetails?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = descriptionHoliday?.name
        self.detailLabel.text = descriptionHoliday?.description
        self.dateLabel.text = descriptionHoliday?.date.iso
        
    }
    

}
