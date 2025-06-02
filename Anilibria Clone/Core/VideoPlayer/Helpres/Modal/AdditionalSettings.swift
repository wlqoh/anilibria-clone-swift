//
//  AdditionalSettings.swift
//  AnilibriaClone
//
//  Created by Мурад on 8/5/25.
//

import SwiftUI

struct AdditionalSettings: View {
    @ObservedObject var vm: VideoPlayerViewModel
    @Binding var orientation: UIInterfaceOrientationMask
    @Binding var showSettings: Bool
    let hls: HLS
    var body: some View {
        ModalView(content: content()) {
            withAnimation {
                showSettings = false
            }
        }
    }
    
    @ViewBuilder
    func content() -> some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Player orientation")
                    .padding(.horizontal)
                    .font(.caption)
                    .fontWeight(.bold)
                
                ForEach(PlayerOrientation.allCases, id: \.self) { orientation in
                    Button {
                        self.orientation = orientation.mask
                        modifyOrientation(orientation.mask)
                    } label: {
                        HStack {
                            Text(orientation.rawValue)
                            
                            Spacer()
                            
                            if  self.orientation == orientation.mask {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    .padding(.horizontal)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    
                    if orientation != PlayerOrientation.allCases.last {
                        Divider()
                            .background(.white)
                    }
                }
            }
            .padding(.vertical, 10)
            .foregroundStyle(.white)
            .background(Color(.systemGray2))
            .clipShape(RoundedRectangle(cornerRadius: 4))
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Quality")
                    .padding(.horizontal)
                    .font(.caption)
                    .fontWeight(.bold)
                
                ForEach(VideoQuality.allCases, id: \.self) { quality in
                    if quality.isAvailable(in: hls) {
                        Button {
                            if self.vm.selectedQuality != quality {
                                self.vm.selectedQuality = quality
                                vm.changeQuality(hls: hls)
                            }
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showSettings = false
                            }
                        } label: {
                            HStack {
                                Text(quality.rawValue)
                                
                                Spacer()
                                
                                if self.vm.selectedQuality == quality {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                        .padding(.horizontal)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        
                        if quality != VideoQuality.allCases.last {
                            Divider()
                                .background(.white)
                        }
                    }
                }
            }
            .padding(.vertical, 10)
            .foregroundStyle(.white)
            .background(Color(.systemGray2))
            .clipShape(RoundedRectangle(cornerRadius: 4))
        }
    }
}

#Preview {
    AdditionalSettings(vm: VideoPlayerViewModel(), orientation: .constant(.portrait), showSettings: .constant(true), hls: HLS(fhd: nil, hd: "", sd: ""))
}
