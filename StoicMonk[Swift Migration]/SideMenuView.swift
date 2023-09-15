//
//  SideMenuView.swift
//  StoicMonk[Swift Migration]
//
//  Created by Jayanta Adhikary on 15/09/23.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true)) {
                Text("Quotes")
                    .font(.subheadline)
                    .padding(.vertical, 10)
                    .foregroundColor(Color.black)
            }
            
            
            NavigationLink(destination: Text("Item 2")) {
                Text("Meditate")
                    .font(.subheadline)
                    .padding(.vertical, 10)
                    .foregroundColor(Color.black)
            }
            
            NavigationLink(destination: Text("Item 3")) {
                Text("Todo")
                    .font(.subheadline)
                    .padding(.vertical, 10)
                    .foregroundColor(Color.black)
            }
            
            NavigationLink(destination: Text("Item 4")) {
                Text("Recomendations")
                    .font(.subheadline)
                    .padding(.vertical, 10)
                    .foregroundColor(Color.black)
            }
            
            
            Spacer()
        }
        .padding(.horizontal, 72)
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.9568627450980393, green: 0.984313725490196, blue: 0.9803921568627451)/*@END_MENU_TOKEN@*/)
        .edgesIgnoringSafeArea(.bottom)
        
        
        
        
        
        
        
        
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
