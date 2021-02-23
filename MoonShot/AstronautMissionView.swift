//
//  AstronautMissionView.swift
//  MoonShot
//
//  Created by Kristoffer Eriksson on 2021-02-23.
//

import SwiftUI

struct AstronautMissionView: View {
    
    let missions: [Mission]
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                Text("was on ->")
                    .font(.caption2)
                    .padding(.leading)
                
                ForEach(self.missions){ mission in
                    VStack{
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                        
                        Text(mission.displayName)
                            .font(.caption)
                    }
                }
            }
        }
    }
    
    init(missions: [Mission], astronaut: Astronaut){
        self.astronaut = astronaut
        
        var matches = [Mission]()
        
        
        for mission in missions {
            if let _ = mission.crew.first(where: { $0.name == astronaut.id}) {
                matches.append(mission)
            }
        }
        
        self.missions = matches
    }
}

struct AstronautMissionView_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautMissionView(missions: missions, astronaut: astronauts[0])
    }
}
