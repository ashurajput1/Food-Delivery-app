//
//  emptyState.swift
//  kitProject
//
//  Created by Ashutosh Rajput on 20/08/24.
//

import SwiftUI

struct emptyStateView: View {
    var body: some View {
        ZStack {
            VStack {
                Image(uiImage: UIImage(named: "empty-order")!)
                    .resizable()
                    .frame(width: 200,height: 120)
                    .padding()
                Text("Your Bucket is Empty \n order something")
                    .font(.title3)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
            }
            .offset(y:-70)
        }
    }
}

#Preview {
    emptyStateView()
}
