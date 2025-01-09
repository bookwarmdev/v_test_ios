//
//  AppLoader.swift
//  vpd
//
//  Created by Faruk Amoo on 07/01/2025.
//

import SwiftUICore
import SwiftUI


struct AppLoader: View {
        
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
            Spacer()
        }
    }
}
