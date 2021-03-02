//
//  ColorPicker.swift
//  ChildColors
//
//  Created by Vladyslav Sosiuk on 02.03.2021.
//

import SwiftUI

struct ColorPicker: View {
    
    var colors: [Color]
    
    @Binding var selectedColor: Color
    
    var body: some View {
        HStack {
            Spacer()
            ForEach(colors, id: \.self) { color in
                Button(action: {
                    selectedColor = color
                }, label: {
                    ColorCell(color: color,
                              shouldRoundCorners: true,
                              selected: color == selectedColor)
                        .frame(idealWidth: Constants.dimension, maxWidth: Constants.dimension)
                        .shadow(radius: Constants.shadowRadius)
                })
            }
            Spacer()
        }
        .frame(height: Constants.dimension)
    }
}

// MARK: - Constants

private extension ColorPicker {
    enum Constants {
        static let dimension: CGFloat = 30
        static let shadowRadius: CGFloat = 10
    }
}

struct ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        ColorPicker(colors: [.blue, .yellow],
                    selectedColor: .constant(.green))
    }
}
