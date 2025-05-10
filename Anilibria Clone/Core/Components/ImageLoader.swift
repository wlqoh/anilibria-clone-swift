//
//  ImageLoader.swift
//  AnilibriaClone
//
//  Created by Мурад on 16/4/25.
//

import SwiftUI
import Kingfisher

struct ImageLoader: View {
    let imageUrl: String
    var body: some View {
        KFImage(URL(string: imageUrl))
            .placeholder {
                SkeletonView(.rect)
            }
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    ImageLoader(imageUrl: Constants.imageUrl + "/storage/releases/posters/9768/ttlf6K0fw71kymYVthyRfg1AZ6JCTBBF.jpg")
}
