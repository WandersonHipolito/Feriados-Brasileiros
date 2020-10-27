//
//  HolidayNetworkManager.swift
//  Feriados Brasileiros
//
//  Created by Wanderson Hipolito on 21/10/20.
//

import Foundation

enum HolidayError: Error {
    case authorizedLevelRequired //error 603
    case invalidQueryParameters // error 602
    case incorrecAPIcode // error 601
    case offlineForMaintenance //error 600
}


struct HolidayNetworkManager {
    //https://calendarific.com/api/v2/holidays?&api_key=7806e6ecb1455ccf0e78be2d184e61d480743ef7&country=BR&year=2019
    
    let resourceURL: URL
    let API_KEY = "7806e6ecb1455ccf0e78be2d184e61d480743ef7"
    
    init(codCountry: String ) {
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resourceString = "https://calendarific.com/api/v2/holidays?&api_key=\(API_KEY)&country=\(codCountry)&year=\(currentYear)"
        guard let resourceURL = URL(string: resourceString) else {
            fatalError("Error in resource URL in init function")
            
        }
        
        self.resourceURL = resourceURL
    }
    
    
    // API request function
    func getHolidays(completion : @escaping(Result<[ HolidayDetails], HolidayError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { (data, _, _) in
            
            guard let jsonData = data else {
                completion(.failure(.authorizedLevelRequired))
                completion(.failure(.authorizedLevelRequired))
                completion(.failure(.incorrecAPIcode))
                completion(.failure(.offlineForMaintenance))

                return
                
            }
            
            do{
                
                let jsonDecoder = JSONDecoder()
                let holidaysResponse = try jsonDecoder.decode(HolidayResponse.self, from: jsonData)
                let holidaysDetails = holidaysResponse.response.holidays
                completion(.success(holidaysDetails))
                //print(holidaysDetails)
            }catch{
                print(error.localizedDescription)
            }
            
        }
        dataTask.resume()
        
    }
    
    
}
