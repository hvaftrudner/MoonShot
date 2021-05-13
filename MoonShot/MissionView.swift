//
//  MissionView.swift
//  MoonShot
//
//  Created by Kristoffer Eriksson on 2021-02-22.
//

import SwiftUI

struct MissionView: View {
    
    struct crewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [crewMember]
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView(.vertical){
                VStack(alignment: .center){
                    GeometryReader { imageGeo in
                        Image(self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geo.size.width * 0.7)
                            .padding(50)
                            
                            //geo challenge 1
                            
                            .scaleEffect(imageGeo.frame(in: .global).minY > (geo.frame(in: .global).midY) / 9 ? (imageGeo.frame(in: .global).midY / 200) + 0.15 : 0.8)
                            .onTapGesture {
                                print(imageGeo.frame(in: .global).midY / 200)
                            }
                            
                    }
                    
                    Text("Launched on: \(self.mission.formattedLaunchDate)")
                        .font(.headline)
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role){ crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack{
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule()
                                    .stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading){
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    
                                    Text(crewMember.role)
                                        .foregroundColor(Color.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            .accessibility(label: Text("crewmember \(crewMember.astronaut.name)"))
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]){
        self.mission = mission
        
        var matches = [crewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name}) {
                matches.append(crewMember(role: member.role, astronaut: match))
            } else {
                fatalError("missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
