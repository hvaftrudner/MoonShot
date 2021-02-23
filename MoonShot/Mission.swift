//
//  Mission.swift
//  MoonShot
//
//  Created by Kristoffer Eriksson on 2021-02-22.
//

import Foundation



struct Mission: Codable, Identifiable{
    
    struct crewRole: Codable{
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [crewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    var formattedNames: String {
        var crewNames: String = ""
        
        for names in crew {
            crewNames.append("\(names.name) ")
        }
        return crewNames
    }
}
