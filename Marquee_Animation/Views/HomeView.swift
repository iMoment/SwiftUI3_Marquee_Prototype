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
                
                Marquee(text: "Tech, video games, failed cooking attempts, vlogs and more!", font: .systemFont(ofSize: 16, weight: .regular))
            }
            .padding()
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
    var text: String
    var font: UIFont
    
    @State var storedTextSize: CGSize = .zero
    @State var offset: CGFloat = 0
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            Text(text)
                .font(Font(font))
                .offset(x: offset)
        }
        // Disabling Manual Scrolling
        .disabled(true)
        .onAppear {
            storedTextSize = textSize()
        }
    }
    // MARK: Fetch Text Size for Offset Animation
    func textSize() -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        
        return size
    }
}
