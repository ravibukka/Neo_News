//
//  AsteriodsModel.swift
//  NeoStats
//
//  Created by Ravi on 12/02/23.
//

import Foundation
import Alamofire
import SwiftyJSON

class AsteriodsModel {
    
    var numberOfAsteriods = [Int]()
    init(fromJSON json: JSON!, fromDate startDate: Date, toDate endDate: Date) {
        if json.isEmpty {
            return
        }
        
        let dayDurationInSeconds: TimeInterval = 60*60*24
        for date in stride(from: startDate, to: endDate, by: dayDurationInSeconds) {
            Formatter.shared.dateformatter.dateFormat = "yyyy-MM-dd"
            let Date =   Formatter.shared.dateformatter.string(from:date)
            let drafts = json[Date].arrayValue.count
            numberOfAsteriods.append(drafts)
        }
    }
}

class NearEarthObjects {
    
    var neo_reference_id:String?
    var name:String?
    var is_potentially_hazardous_asteroid:String?
    var closeApproachData: [CloseApproachDataModel]!
    var orbitalData: OrbitalDataModel?
    
    init(fromJSON json: JSON!) {
        if json.isEmpty {
            return
        }
        neo_reference_id = json["neo_reference_id"].stringValue
        name = json["name"].stringValue
        is_potentially_hazardous_asteroid = json["is_potentially_hazardous_asteroid"].stringValue
        orbitalData = OrbitalDataModel(fromJSON: json["orbital_data"])
        
        closeApproachData = [CloseApproachDataModel]()
        let closeApproachArray = json["close_approach_data"].arrayValue
        for item in closeApproachArray{
            let arrayValue = CloseApproachDataModel(fromJSON: item)
            closeApproachData.append(arrayValue)
        }
    }
}

class OrbitalDataModel {
    
    var orbit_id: String?
    var first_observation_date: String?
    var last_observation_date: String?
    init(fromJSON json: JSON!) {
        if json.isEmpty {
            return
        }
        
        orbit_id = json["orbit_id"].stringValue
        first_observation_date = json["first_observation_date"].stringValue
        last_observation_date = json["last_observation_date"].stringValue
    }
}

class CloseApproachDataModel {
    
    var orbiting_body: String?
    var relativeVelocity:RelativeVelocityModel?
    init(fromJSON json: JSON!) {
        if json.isEmpty {
            return
        }
        orbiting_body = json["orbiting_body"].stringValue
        relativeVelocity = RelativeVelocityModel(fromJSON: json["relative_velocity"])
    }
}

class RelativeVelocityModel {
    
    var kilometersPerSecond: String!
    var kilometersPerHour: String!
    
    init(fromJSON json: JSON!) {
        if json.isEmpty {
            return
        }
        kilometersPerSecond = json["kilometers_per_second"].stringValue
        kilometersPerHour = json["kilometers_per_hour"].stringValue
        
    }
}
