# AquaFrameModifier

## Description

The `AquaFrameModifier` adds a stylish Aqua-themed frame effect to your SwiftUI views. This modifier is ideal for creating a glossy, 3D-like border around your content, mimicking the iconic Aqua design style.

## Features

- **aquaColor:** Defines the primary color of the frame.
- **aquaOpacity:** Adjusts the transparency of the Aqua frame, giving control over the intensity of the effect.
- **cornerRadius:** Specifies the roundness of the frame's corners.
- **colorShadow:** Toggles the addition of a subtle color shadow to enhance depth. By default, this is set to `true`.

## Usage

```swift
import SwiftUI

struct ContentView: View {
    @State private var aquaColor = Color.blue
    @State private var aquaOpacity: CGFloat = 0.35
    @State private var cornerRadius: CGFloat = 12.0
    @State private var colorShadow: Bool = true

    var body: some View {
        VStack {
            Image(systemName: "star.fill")
                .aquaFrameModifier(
                    aquaColor: aquaColor,
                    aquaOpacity: aquaOpacity,
                    cornerRadius: cornerRadius,
                    colorShadow: colorShadow
                )
            
            Text("Aqua Styled Text")
                .padding()
                .aquaFrameModifier(
                    aquaColor: aquaColor,
                    aquaOpacity: 0.6,
                    cornerRadius: cornerRadius,
                    colorShadow: colorShadow
                )
        }
        .padding()
    }
}
```

This code demonstrates how to apply the AquaFrameModifier to an Image and Text, allowing you to customize the Aqua-style frame to suit your design needs.
