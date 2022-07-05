
//
//  ContentView.swift
//  jsonModuleServiceSwiftUI
//
//  Created by Admin on 23/06/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var users : [Datum] = [Datum]()
    @State var headers: [String] = ["Upcoming","Past"]
    
    var body: some View {
        NavigationView {
            VStack {
                List{
                    ForEach(headers,id: \.self){ header in
                        Section(header: Text(header).fontWeight(.bold)){
                            ForEach(users){ user in
                                NavigationLink(destination: Text(user.firstName)) {
                                    Text(user.firstName)
                                }
                            }
                        }
                    }
                }
            }
        }.onAppear {
            Webservice().fetch(url: URL(string: "https://reqres.in/api/users?per_page=20")!) { data in
                return try! JSONDecoder().decode(Users.self, from: data)
            } completion: { result in
                switch result {
                case .success(let user):
                    if let user = user {
                        DispatchQueue.main.sync {
                            print("Results: \(result)")
                            self.users = user.data
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    @available(macOS 11.0, *)
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//
//extension Font {
//    static var EuclidCircularTitle: Font {
//        Font.custom("EuclidCircularB-Bold", size: 14, relativeTo: .title)
//    }
//    static var EuclidCircularHeading: Font {
//        Font.custom("EuclidCircularB-Bold", size: 18, relativeTo: .largeTitle)
//    }
//}
