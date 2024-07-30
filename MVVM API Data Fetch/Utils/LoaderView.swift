//
//  LoaderView.swift
//  MVVM API Data Fetch
//
//  Created by Masrafi Anam on 28/7/24.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ProgressView()
            .scaleEffect(2.0, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: .black))
    }
}
