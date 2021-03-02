//
//  PlayCanvas.swift
//  ChildColors
//
//  Created by Vladyslav Sosiuk on 02.03.2021.
//

import SwiftUI

struct PlayCanvas: View {
    
    static var colors: [Color] = [
        .green,
        .blue,
        .red,
        .yellow,
        .orange,
        .pink,
        .purple,
        .white
    ]
    static var numberOfItems = 15
    
    @State private var selectedColor = Self.colors.first!
    @State private var colorsState: [[Color]] = Array(repeating: Array(repeating: Color.white, count: numberOfItems), count: numberOfItems)
    @State private var cachedGridSize: CGSize?
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 50) {
                Spacer()
                Grid(numberOfItems: Self.numberOfItems) { (row, column) in
                    ColorCell(color: colorsState[row][column])
                }
                .frame(height: gridSize(forGeometry: geometry).height)
                .background(Color.gray)
                .padding(2)
                .border(Color.gray, width: 2)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { gesture in
                            guard let cachedGridSize = cachedGridSize else { return }
                            let point = gesture.location
                            let oneCellHeight = cachedGridSize.height / CGFloat(Self.numberOfItems)
                            let row = Int(point.y / CGFloat(oneCellHeight))
                            let oneCellWidth = cachedGridSize.width / CGFloat(Self.numberOfItems)
                            let column = Int(point.x / CGFloat(oneCellWidth))
                            
                            guard row < colorsState.count, column < colorsState[row].count else { return }
                            colorsState[row][column] = selectedColor
                        }
                )
                ColorPicker(colors: Self.colors, selectedColor: $selectedColor)
                Spacer()
            }
            .padding(20)
            .onAppear {
                cachedGridSize = gridSize(forGeometry: geometry)
            }
        }
    }
    
    func gridSize(forGeometry geometry: GeometryProxy) -> CGSize {
        let side = geometry.size.width - 20 * 2
        return CGSize(width: side, height: side)
    }
}

struct PlayCanvas_Previews: PreviewProvider {
    static var previews: some View {
        PlayCanvas()
    }
}
