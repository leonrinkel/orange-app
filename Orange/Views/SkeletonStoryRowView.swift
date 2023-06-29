//
//  SkeletonStoryRowView.swift
//  Orange
//
//  Created by Leon Rinkel on 29.06.23.
//

import SwiftUI
import SkeletonUI

struct SkeletonStoryRowView: View {
    var body: some View {
        EmptyView()
            .skeleton(with: true)
            .multiline(lines: 4, scales: [0: 0.75, 1: 0.5, 3: 0.65])
            .padding([.top, .bottom])
    }
}

struct SkeletonStoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        SkeletonStoryRowView()
            .frame(height: 150)
    }
}
