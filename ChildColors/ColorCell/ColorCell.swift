//
//  ColorCell.swift
//  ChildColors
//
//  Created by Vladyslav Sosiuk on 02.03.2021.
//

import SwiftUI

struct ColorCell: View {
    
    var color: Color
    var shouldRoundCorners = false
    var selected = false
    
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .foregroundColor(color)
                .cornerRadius(cornerRadius(forHeight: geometry.size.height))
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius(forHeight: geometry.size.height))
                        .stroke(Color.gray, lineWidth: selected ? 4 : 0)
                )
        }
    }
    
    func cornerRadius(forHeight height: CGFloat) -> CGFloat {
        shouldRoundCorners ? height / 2 : 0
    }
}

struct ColorCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ColorCell(color: .green)
            ColorCell(color: .green,
                      shouldRoundCorners: true,
                      selected: true)
        }
        .previewLayout(.fixed(width: 50, height: 50))
    }
}
