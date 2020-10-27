//
//  FeriadoData.swift
//  Feriados Brasileiros
//
//  Created by Wanderson Hipolito on 21/10/20.
//

import Foundation


struct HolidayResponse: Decodable {
    var response: Holidays
}

struct Holidays: Decodable {
    var holidays: [HolidayDetails]
}

struct HolidayDetails: Decodable {
    var name: String
    var description: String
    var date: DataInfo
}

struct DataInfo: Decodable {
    var iso: String
}
