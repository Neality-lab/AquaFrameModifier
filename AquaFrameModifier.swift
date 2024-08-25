//
//  AquaFrameModifier.swift
//  Aqua Button
//
//  Created by Yohey Kuwa on 2024/08/22.
//

import SwiftUI

struct AquaFrameModifier: ViewModifier {
    var colorMaterial: Bool = true
    var aquaColor: Color
    var aquaOpacity: CGFloat
    var cornerRadius: CGFloat
    var colorShadow: Bool
    var highlight: Bool = true
    
    func body(content: Content) -> some View {
        // Content
        content
            .mask(
                RoundedRectangle(cornerRadius: cornerRadius)
            )
            .overlay(
                GeometryReader { geo in
                    let edgePadding = geo.size.height/30
                    
                    ZStack {
                        if colorMaterial{
                            // Base shape with optional color shadow
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .foregroundStyle(aquaColor) // Main button color
                                ///.blendMode(.softLight)
                                .shadow(radius: edgePadding / 2) // Subtle shadow for depth
                                .shadow(
                                    color: colorShadow ? aquaColor.opacity(0.35) : .clear, // Visible only if colorShadow is true
                                    radius: colorShadow ? geo.size.height / 20 : 0,
                                    y: colorShadow ? geo.size.height / 10 : 0
                                )
                        }
                        
                        content
                            .mask(
                                RoundedRectangle(cornerRadius: cornerRadius)
                                    .padding(edgePadding * 4)
                                    .blur(radius: edgePadding * 2)
                            )
                            .opacity(1 - aquaOpacity)
                            ///.blendMode(.overlay)
                        
                        ZStack {
                            let cornerR = cornerRadius - edgePadding
                            // Light gradient overlay on the shape
                            RoundedRectangle(cornerRadius: cornerR)
                                .foregroundStyle(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.white.opacity(0), .white.opacity(0.1), .white.opacity(0.3), .white.opacity(1)]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .blur(radius: edgePadding / 2) // Soften the gradient edges
                                .blendMode(.overlay)
                            
                            ZStack {
                                // Reflection effect on the shape
                                RoundedRectangle(cornerRadius: cornerR)
                                    .foregroundStyle(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.white.opacity(0.9), .white.opacity(0.2), .white.opacity(0)]),
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .mask(
                                        Ellipse()
                                            .scaleEffect(x: 1.5)
                                            .offset(y: -geo.size.height / 2 + edgePadding * 5) // Adjust the position of the reflection
                                    )
                                
                                // Highlight effect applied only if the highlight option is true
                                if highlight {
                                    RoundedRectangle(cornerRadius: cornerR)
                                        .foregroundStyle(.white.opacity(0.8))
                                        .mask(
                                            ZStack {
                                                RoundedRectangle(cornerRadius: cornerR) // Full-sized shape for the base of the highlight
                                                
                                                RoundedRectangle(cornerRadius: cornerR)
                                                    .offset(y: edgePadding * 1.2) // Slightly offset shape to create a cut-out effect
                                                    .blendMode(.destinationOut) // Removes the overlapping area, creating a highlight
                                            }
                                            .compositingGroup() // Creates a shape from the non-overlapping areas of the two shapes.
                                            .mask(
                                                // Applies the same mask as the reflection
                                                Ellipse()
                                                    .offset(y: -geo.size.height / 2 + edgePadding * 5) // Adjust the position of the reflection
                                            )
                                        )
                                }
                            }
                            .blur(radius: edgePadding / 4)
                            ///.padding(edgePadding)
                        }
                        .padding(edgePadding) // Additional padding for inner ZStack
                    }
                }
            )
    }
}

extension View {
    func aquaFrameModifier(aquaColor: Color, aquaOpacity: CGFloat, cornerRadius: CGFloat, colorShadow: Bool = true) -> some View {
        self.modifier(AquaFrameModifier(aquaColor: aquaColor, aquaOpacity: aquaOpacity, cornerRadius: cornerRadius, colorShadow: colorShadow))
    }
}

