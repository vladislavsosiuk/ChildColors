//
//  PlayCanvas.swift
//  ChildColors
//
//  Created by Vladyslav Sosiuk on 02.03.2021.
//

import SwiftUI

struct PlayCanvas: View {
    
    @State private var selectedColor = Constants.colors.first!
    @State private var colorsState: [[Color]] = Array(repeating: Array(repeating: Color.white, count: Constants.numberOfCells), count: Constants.numberOfCells)
    @State private var cachedGridSize: CGSize?
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 50) {
                Spacer()
                Grid(numberOfItems: Constants.numberOfCells) { (row, column) in
                    ColorCell(color: colorsState[row][column])
                }
                .padding(gridSpacing)
                .frame(height: gridSize(forGeometry: geometry).height)
                .background(Color.gray)
                .border(Color.gray, width: 2)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { gesture in
                            updateCell(forLocation: gesture.location)
                        }
                )
                ColorPicker(colors: Constants.colors, selectedColor: $selectedColor)
                Spacer()
            }
            .padding(Constants.padding)
            .onAppear {
                cachedGridSize = gridSize(forGeometry: geometry)
            }
        }
    }
    
    private func gridSize(forGeometry geometry: GeometryProxy) -> CGSize {
        let side = geometry.size.width - Constants.padding * 2
        return CGSize(width: side, height: side)
    }
    
    private func updateCell(forLocation location: CGPoint) {
        guard let cachedGridSize = cachedGridSize else { return }
        let oneCellHeight = cachedGridSize.height / CGFloat(Constants.numberOfCells)
        let row = Int(location.y / CGFloat(oneCellHeight))
        let oneCellWidth = cachedGridSize.width / CGFloat(Constants.numberOfCells)
        let column = Int(location.x / CGFloat(oneCellWidth))
        
        guard row < colorsState.count, column < colorsState[row].count else { return }
        colorsState[row][column] = selectedColor
    }
}

// MARK: - Constants

private extension PlayCanvas {
    
    enum Constants {
        static let colors: [Color] = [
            .green,
            .blue,
            .red,
            .yellow,
            .orange,
            .pink,
            .purple,
            .white
        ]
        static let numberOfCells = 5
        static let padding: CGFloat = 20
    }
}

struct PlayCanvas_Previews: PreviewProvider {
    static var previews: some View {
        PlayCanvas()
    }
}
