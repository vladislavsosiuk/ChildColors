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
                        .frame(idealWidth: 30, maxWidth: 30)
                        .shadow(radius: 10)
                })
            }
            Spacer()
        }
        .frame(height: 30)
    }
}

struct ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        ColorPicker(colors: PlayCanvas.colors,
                    selectedColor: .constant(.green))
    }
}
