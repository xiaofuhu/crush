//
//  ContentView.swift
//  crush
//
//  Created by Fuhu Xiao on 10/11/19.
//  Copyright © 2019 Crush Inc. All rights reserved.
//

import SwiftUI

struct SnapshotView: View {
    var body: some View {
        ZStack {
            MapView().edgesIgnoringSafeArea(.vertical)
            
            VStack {
                Spacer()
                Button(action: { print("snapshot tap") }) {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Take Snapshot")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10.0)
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
