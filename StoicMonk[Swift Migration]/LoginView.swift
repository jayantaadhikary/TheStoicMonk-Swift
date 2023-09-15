//
//  LoginView.swift
//  StoicMonk[Swift Migration]
//
//  Created by Jayanta Adhikary on 15/09/23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("TheStoicMonk")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack{
                    Spacer()
                    NavigationLink(destination: HomeView()) {
                                            Text("Welcome")
                                                .padding(.horizontal, 64)
                                                .cornerRadius(20)
                                                .frame(height: 18)
                                                .foregroundColor(.white) // Set text color
                                        }
                                        .buttonStyle(.borderedProminent)
                                        .tint(Color(UIColor(red: 16/255, green: 109/255, blue: 96/255, alpha: 1.0)))
        
                    
                    
                    
                }
                
            }
        }
        
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
