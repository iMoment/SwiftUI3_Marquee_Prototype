//
//  HomeView.swift
//  Marquee_Animation
//
//  Created by Stanley Pan on 2022/01/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading, spacing: 22) {
                
                GeometryReader { proxy in
                    let size = proxy.size
                    
                    // MARK: Sample Image
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .cornerRadius(15)
                }
                .frame(height: 220)
                .padding(.horizontal)
                
                Marquee(text: "Tech, video games, failed cooking attempts, vlogs and more!", font: .systemFont(ofSize: 16, weight: .regular))
            }
            .padding(.vertical)
            .navigationTitle("Marquee Prototype")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

// MARK: Marquee Text View
struct Marquee: View {
    @State var text: String
    var font: UIFont
    
    @State var storedTextSize: CGSize = .zero
    @State var offset: CGFloat = 0
    
    // MARK: Animation Speed
    var animationSpeed: Double = 0.01
    var delayTime: Double = 0.5 // Set 0 for continuous
    
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            Text(text)
                .font(Font(font))
                .offset(x: offset)
                .padding(.horizontal, 15)
        }
        // Opacity Effect
        .overlay(content: {
            HStack {
                let color: Color = scheme == .dark ? Color.black : Color.white
                
                LinearGradient(colors:
                                [color,
                                 color.opacity(0.7),
                                 color.opacity(0.5),
                                 color.opacity(0.3)],
                               startPoint: .leading,
                               endPoint: .trailing).frame(width: 20)
                
                Spacer()
                
                LinearGradient(colors:
                                [color,
                                 color.opacity(0.7),
                                 color.opacity(0.5),
                                 color.opacity(0.3)].reversed(),
                               startPoint: .leading,
                               endPoint: .trailing).frame(width: 20)
            }
        })
        // Disabling Manual Scrolling
        .disabled(true)
        .onAppear {
            // Base Text
            let baseText = text
            
            // MARK: Continuous Animation
            (1...15).forEach { _ in
                text.append(" ")
            }
            // Stopping Animation, before next text
            storedTextSize = textSize()
            text.append(baseText)
            
            
            // Calculating total seconds based on text width
            let timing: Double = (animationSpeed * storedTextSize.width)
            
            // Delaying First Animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                withAnimation(.linear(duration: timing)) {
                    offset = -storedTextSize.width
                }
            }
        }
        // MARK: Timer for continuous repeat
        // Optional: If delay is needed for next animation
        .onReceive(Timer.publish(every: ((animationSpeed * storedTextSize.width) + delayTime), tolerance: nil, on: .main, in: .default).autoconnect()) { _ in
            // Reset offset to 0, to look like looping
            offset = 0
            withAnimation(.linear(duration: (animationSpeed * storedTextSize.width))) {
                offset = -storedTextSize.width
            }
        }
    }
    // MARK: Fetch Text Size for Offset Animation
    func textSize() -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        
        return size
    }
}
