//
//  Day.swift
//  JIIT Connect
//
//  Created by Sanchit Garg on 29/11/16.
//  Copyright © 2016 Sanchit Garg. All rights reserved.
//

import Alamofire

class Schedule: NSObject {
    var monday: [Class]?
    var tuesday: [Class]?
    var wednesday: [Class]?
    var thursday: [Class]?
    var friday: [Class]?
    var saturday: [Class]?
    
    required init?(json: [String: AnyObject]) {
        guard let mondayArray = json[Days.Monday.rawValue] as? [[String: AnyObject]],
        let tuesdayArray = json[Days.Tuesday.rawValue] as? [[String: AnyObject]],
        let wednesdayArray = json[Days.Wednesday.rawValue] as? [[String: AnyObject]],
        let thursdayArray = json[Days.Thursday.rawValue] as? [[String: AnyObject]],
        let fridayArray = json[Days.Friday.rawValue] as? [[String: AnyObject]],
        let saturdayArray = json[Days.Saturday.rawValue] as? [[String: AnyObject]]
        else{
            print("problem in response")
            return nil
        }
        
        var classArray: [Class] = []
        
        for (index,jsonObject) in mondayArray.enumerated() {
            if (index != 0) {
                guard let object = Class(json: jsonObject) else{
                    print("problem in monday classes")
                    return nil
                }
                classArray.append(object)
            }
        }
        self.monday = classArray
        
        classArray.removeAll()
        for (index,jsonObject) in tuesdayArray.enumerated() {
            if (index != 0) {
                guard let object = Class(json: jsonObject) else{
                    print("problem in tuesday classes")
                    return nil
                }
                classArray.append(object)
            }
        }
        self.tuesday = classArray
        
        classArray.removeAll()
        for (index,jsonObject) in wednesdayArray.enumerated() {
            if (index != 0) {
                guard let object = Class(json: jsonObject) else{
                    print("problem in wednesday classes")
                    return nil
                }
                classArray.append(object)
            }
        }
        self.wednesday = classArray
        
        classArray.removeAll()
        for (index,jsonObject) in thursdayArray.enumerated() {
            if (index != 0) {
                guard let object = Class(json: jsonObject) else{
                    print("problem in thursday classes")
                    return nil
                }
                classArray.append(object)
            }
        }
        self.thursday = classArray
        
        classArray.removeAll()
        for (index,jsonObject) in fridayArray.enumerated() {
            if (index != 0) {
                guard let object = Class(json: jsonObject) else{
                    print("problem in friday classes")
                    return nil
                }
                classArray.append(object)
            }
        }
        self.friday = classArray
        
        classArray.removeAll()
        for (index,jsonObject) in saturdayArray.enumerated() {
            if (index != 0) {
                guard let object = Class(json: jsonObject) else{
                    print("problem in saturday classes")
                    return nil
                }
                classArray.append(object)
            }
        }
        self.saturday = classArray
        
    }
}
