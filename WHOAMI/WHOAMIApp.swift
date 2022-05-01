//
//  WHOAMIApp.swift
//  WHOAMI
//
//  Created by hurdasol on 2022/05/01.
//

import SwiftUI

@main
struct WHOAMIApp: App {
    var body: some Scene {
        WindowGroup {
            TabView{
                Me(person: ocean)
                    .tabItem{
                        Image(systemName: "person.circle")
                        Text("Me")}
                Contacts(person: juny)
                    .tabItem{
                        Image(systemName: "person.3")
                        Text("Contacts")}
            }
            
        }
    }
}
