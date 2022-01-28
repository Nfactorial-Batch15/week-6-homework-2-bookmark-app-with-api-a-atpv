//
//  ContentView.swift
//  listWithLinks
//
//  Created by Алдияр Айтпаев on 27.01.2022.
//

import SwiftUI

struct ContentView: View {
    @State var models: [LinkModel] = []
    var body: some View {
        VStack {
            List(models, id: \.name) { model in
                Text("\(model.name) ")
                    .onTapGesture {
                        UIApplication.shared.open(URL(string: model.link)!)
                        print (model.name)
                    }
            }.listStyle(.inset)
        }.onAppear {
            testingRequest {models in
                self.models = models
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
