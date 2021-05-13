//
//  ContentView.swift
//  MoonShot
//
//  Created by Kristoffer Eriksson on 2021-02-18.
//

import SwiftUI


struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var toggleInfo: Bool = true
    
    var body: some View {
        NavigationView{
            List(missions, id: \.id){ mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        //.aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    
                    VStack(alignment: .leading){
                        Text(mission.displayName)
                            .font(.headline)
                        Text(toggleInfo ? mission.formattedLaunchDate : mission.formattedNames)
                            .font(.caption)
                        
                    }
                }
                .accessibility(label: Text("mission \(mission.displayName)"))
            }
            .navigationBarTitle("MoonShot")
            .navigationBarItems(trailing:
                Button(toggleInfo ? "name" : "date", action: {
                    self.toggleInfo.toggle()
                })
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
