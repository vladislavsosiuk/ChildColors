//
//  Grid.swift
//  ChildColors
//
//  Created by Vladyslav Sosiuk on 02.03.2021.
//

import SwiftUI

struct Grid<V: View>: View {
    
    typealias Row = Int
    typealias Column = Int
    
    var numberOfItems: Int
    
    var label: ((Row, Column) -> V)
    
    var body: some View {
        VStack(spacing: 2) {
            ForEach(0..<numberOfItems) { row in
                HStack(spacing: 2) {
                    ForEach(0..<numberOfItems) { column in
                        label(row, column)
                    }
                }
            }
        }
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid(numberOfItems: 5) { (row, column) in
            ColorCell(color: .green)
        }
    }
}
