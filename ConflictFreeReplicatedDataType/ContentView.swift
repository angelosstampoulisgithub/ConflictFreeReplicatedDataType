//
//  ContentView.swift
//  ConflictFreeReplicatedDataType
//
//  Created by Angelos Staboulis on 17/10/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CounterViewModel(localId: UUID().uuidString)

    var body: some View {
        VStack(spacing: 20) {
            Text("CRDT G-Counter")
                .font(.largeTitle)
            
            Text("Value: \(viewModel.value)")
                .font(.title)
            
            Button("Increment") {
                viewModel.increment()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Text("Syncs every 5 seconds with fake remote")
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
