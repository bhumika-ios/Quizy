//
//  CustomCorner.swift
//  Quizy
//
//  Created by Bhumika Patel on 10/06/23.
//

import SwiftUI

struct CustomCorner: Shape {
    var corner: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}


