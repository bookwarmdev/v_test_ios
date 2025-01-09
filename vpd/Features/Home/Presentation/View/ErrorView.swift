//
//  ErrorView.swift
//  vpd
//
//  Created by Faruk Amoo on 08/01/2025.
//

import SwiftUI

struct ErrorView: View {
    
    let error: String
    let onTap: () -> Void
    var body: some View {
        VStack {
            Spacer()
            Text(error)
                .foregroundColor(Color.red)
            Button (action: onTap) {
                Text("Try again")
                    .frame(maxWidth: UIScreen.main.bounds.width/2.2)
                    .frame(height: 40)
                    .background(RoundedRectangle(cornerRadius: 5)
                        .stroke(  .gray.opacity(0.7), lineWidth: 1
                               )
                    )
            }
            Spacer()
        }
    }
}

#Preview {
    ErrorView(error: "error", onTap: {
        
    })
}
