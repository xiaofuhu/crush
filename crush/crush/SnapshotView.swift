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
    @ObservableObject var state: AppState
    
    var body: some View {
        ZStack {
            MapView(manager: state.manager)
                .edgesIgnoringSafeArea(.vertical)
            
            VStack {
                Spacer()
                Button(action: state.capture { state.screen = 2 }) {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Take Snapshot")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .shadow(radius: 5.0);
                }
            }
        }
    }
}

struct SnapshotView_Previews: PreviewProvider {
    static var previews: some View {
        SnapshotView()
    }
}
