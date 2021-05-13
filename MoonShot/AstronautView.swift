//
//  AstronautView.swift
//  MoonShot
//
//  Created by Kristoffer Eriksson on 2021-02-22.
//

import SwiftUI

struct AstronautView: View {
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let astronaut: Astronaut
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView(.vertical){
                VStack{
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    AstronautMissionView(missions: missions, astronaut: astronaut)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                }
                .accessibility(label: Text("name: \(astronaut.name)"))
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    //Here there should be an init that checks all missions for the astronaut and appends them to
    //an array
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
