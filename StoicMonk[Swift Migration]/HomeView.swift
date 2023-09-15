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
    
    var body: some View {
        VStack{
            
            Text(quote ?? "Not Found")
            Text(author ?? "Not Found")
        }
        .onAppear{
            Task {
                await apiCall()
            }
        }
        
    }
    
    func apiCall() async{
        if let url = URL(string: "https://stoic-quotes.com/api/quote") {
            let request = URLRequest(url: url)
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                    
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
