//
//  ContentView.swift
//  Socotrap
//
//  Created by Colas Naudi on 27/02/2024
//

import SwiftUI
import ARKit

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Bienvenue dans l'application AR")
                    .font(.largeTitle)
                    .padding()
                
                Text("Ceci est un texte explicatif de l'application AR.")
                    .font(.body)
                    .padding()
                
                Spacer()
                
                NavigationLink(destination: Scan()) {
                    Text("Suivant")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                Spacer()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Pour que la navigationView prenne l'écran entier
    }
}

 
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
