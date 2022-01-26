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
                
                Text("Tech, video games, failed cooking attempts, vlogs and more!")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
