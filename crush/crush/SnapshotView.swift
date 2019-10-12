//
//  ContentView.swift
//  crush
//
//  Created by Fuhu Xiao on 10/11/19.
//  Copyright © 2019 Crush Inc. All rights reserved.
//

import SwiftUI
import CoreLocation

struct SnapshotView: View {
    @ObservedObject var state: AppState
    
    var body: some View {
        ZStack {
            MapView(manager: state.manager)
                .edgesIgnoringSafeArea(.vertical)
            
            VStack {
                Spacer()
                Button(action: state.capture) {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Take Snapshot")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .shadow(radius: 5.0)
                }.padding()
            }
        }
    }
}

struct SnapshotView_Previews: PreviewProvider {
    static var previews: some View {
        SnapshotView(state: AppState())
    }
}
