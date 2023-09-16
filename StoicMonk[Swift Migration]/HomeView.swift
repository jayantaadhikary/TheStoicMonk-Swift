//
//  HomeView.swift
//  StoicMonk[Swift Migration]
//
//  Created by Jayanta Adhikary on 15/09/23.
//

import SwiftUI

struct HomeView: View {
    
    @State var author: String?
    @State var quote: String?
    @State var showMenu: Bool = false
    
    var body: some View {
        NavigationView{
            
            ZStack {
                VStack{
                    Text("Stoic Quotes")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.043137254901960784, green: 0.29411764705882354, blue: 0.11372549019607843))
                    
                    
                    VStack {
                        Text(quote ?? "Not Found")
                            .font(.system(size: 18))
                            .padding(.horizontal, 25)
                            .padding(.top, 15)
                        HStack {
                            Spacer()
                            Text("- \(author ?? "Not Found")")
                                .font(.system(size: 15))
                                .padding(15)
                        }
                        
                    }
                    .foregroundColor(Color.white)
                    .background(Color(UIColor(red: 16/255, green: 109/255, blue: 96/255, alpha: 1.0)))
                    .cornerRadius(10)
                    .padding(30)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Button {
                        Task {
                            await apiCall()
                        }
                    } label: {
                        Text("Refresh")
                            .font(.system(size: 16))
                            .padding(.horizontal, 50)
                            .padding(.vertical, 25)
                            .cornerRadius(12)
                            .frame(height: 24)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red: 0.043137254901960784, green: 0.29411764705882354, blue: 0.11372549019607843))
                    
                    
                    
                }
                
                
                GeometryReader { geometry in
                    SideMenuView()
                        .offset(x: showMenu ? 0 : -geometry.size.width) // Slide in from the left
                        .animation(.easeInOut(duration: 0.3)) // Add easeInOut animation with a duration
                }
            }
            .background(
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
            )
            .onAppear{
                Task {
                    await apiCall()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                        self.showMenu.toggle()
                    } label: {
                        Image(systemName: "text.justify.left")
                            .font(.subheadline)
                            .foregroundColor(Color(red: 0.043137254901960784, green: 0.29411764705882354, blue: 0.11372549019607843))
                    }
                    
                    
                    
                }
                
                
            }
            
        }
        
        
    }
    
    
    
    func apiCall() async{
        if let url = URL(string: "https://stoic-quotes.com/api/quote") {
            let request = URLRequest(url: url)
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                
                let decoder = JSONDecoder()
                
                do {
                    let quote = try decoder.decode(Quote.self, from: data)
                    
                    self.quote =  quote.text ?? "Not Found"
                    self.author = quote.author ?? "Not Found"
                    
                    //                    print(quote.author ?? "Not Found")
                    //                    print(quote.text ?? "Not Found")
                    
                } catch {
                    print(error)
                }
                
            } catch {
                print(error)
            }
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
