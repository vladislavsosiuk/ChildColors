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
    
    @State private var selectedColor = Self.colors.first!
    static var numberOfItems = 15
    
    @State private var colorsState: [[Color]] = Array(repeating: Array(repeating: Color.white, count: numberOfItems), count: numberOfItems)
    @State private var cellsCoordinates = [CGRect: Coordinates]()
    
    var coordinateSpaceName: String {
        String(describing: self)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 50) {
                Spacer()
                Grid(numberOfItems: Self.numberOfItems) { (row, column) in
                    ColorCell(color: colorsState[row][column],
                              parentCoordinateSpace: coordinateSpaceName,
                              onFrameChanged: { frame in
                                self.cellsCoordinates[frame] = Coordinates(row: row, column: column)
                              })
                }
                .frame(height: geometry.size.width - 20 * 2)
                .background(Color.gray)
                .padding(2)
                .border(Color.gray, width: 2)
                ColorPicker(colors: Self.colors, selectedColor: $selectedColor)
                Spacer()
            }
            .padding(20)
        }
        .coordinateSpace(name: coordinateSpaceName)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { gesture in
                    guard let frame = cellsCoordinates.keys.first(where: {
                        $0.contains(gesture.location)
                    }) else {
                        return
                    }
                    let coordinates = cellsCoordinates[frame]!
                    colorsState[coordinates.row][coordinates.column] = selectedColor
                }
        )
    }
}

struct PlayCanvas_Previews: PreviewProvider {
    static var previews: some View {
        PlayCanvas()
    }
}
