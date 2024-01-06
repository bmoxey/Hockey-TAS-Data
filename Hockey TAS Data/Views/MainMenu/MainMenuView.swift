//
//  MainMenuView.swift
//  Hockey TAS Data
//
//  Created by Brett Moxey on 3/1/2024.
//

import SwiftUI
import SwiftData

struct TopFrameView: Shape {
    func path(in rect: CGRect) -> Path {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 53.22, y: 4.36))
        for (to, controlPoint1, controlPoint2) in [(CGPoint(x: 60.83, y: 13.06), CGPoint(x: 57.76, y: 7.77), CGPoint(x: 60.14, y: 11.68)), (CGPoint(x: 68.43, y: 22.84), CGPoint(x: 63, y: 17.4), CGPoint(x: 65.05, y: 20.96)), (CGPoint(x: 75.16, y: 23.98), CGPoint(x: 70.49, y: 23.98), CGPoint(x: 75.16, y: 23.98))] {
            bezierPath.addCurve(to: to, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        }
        bezierPath.addLine(to: CGPoint(x: 0.84, y: 23.98))
        for (to, controlPoint1, controlPoint2) in [(CGPoint(x: 7.57, y: 22.84), CGPoint(x: 0.84, y: 23.98), CGPoint(x: 5.51, y: 23.98)), (CGPoint(x: 15.17, y: 13.06), CGPoint(x: 10.95, y: 20.96), CGPoint(x: 13, y: 17.4)), (CGPoint(x: 22.78, y: 4.36), CGPoint(x: 15.86, y: 11.68), CGPoint(x: 18.24, y: 7.77)), (CGPoint(x: 36.38, y: -0), CGPoint(x: 27.58, y: 0.77), CGPoint(x: 33.55, y: 0.1)), (CGPoint(x: 38, y: 0), CGPoint(x: 37.39, y: -0.04), CGPoint(x: 38, y: 0)), (CGPoint(x: 53.22, y: 4.36), CGPoint(x: 38, y: 0), CGPoint(x: 46.7, y: -0.53))] {
            bezierPath.addCurve(to: to, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        }
        bezierPath.close()
        return Path(bezierPath.cgPath)
    }
}

struct TabItemDescription {
    var imageName: String
    var title: String
    var viewName: AnyView
}

struct MainMenuView: View {
    @Query var teams: [Teams]
    @State var selectedIndex = 0
    
    let tabItems: [TabItemDescription] = [
        .init(imageName: "calendar.badge.clock", title: "Fixture", viewName: AnyView(FixtureView())),
        .init(imageName: "list.number", title: "Ladder", viewName: AnyView(LadderView())),
        .init(imageName: "clock.badge", title: "Round", viewName: AnyView(RoundView())),
        .init(imageName: "chart.bar.xaxis", title: "Stats", viewName: AnyView(StatsView())),
        .init(imageName: "person.crop.circle.badge.questionmark", title: "Teams", viewName: AnyView(TeamsView()))
    ]
    var body: some View {

        ZStack {
            tabItems[selectedIndex].viewName
//                .background(LinearGradient(
//                    gradient: Gradient(colors: [Color("DarkColor1").opacity(0.25), Color("DarkColor2").opacity(0.25)]),
//                    startPoint: .top, endPoint: .bottom ))
            GeometryReader { proxy in
                VStack {
                    Spacer()
                    HStack(alignment: .bottom, spacing: 0){
                        ForEach(0..<5) { (index) in
                            let tab = tabItems[index]
                            VStack(spacing: 0) {
                                Spacer()
                                Rectangle()
                                    .foregroundColor( .clear )
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        ZStack {
                                            Image(systemName: tab.imageName)
                                                .font(.system(size: 24))
                                                .symbolRenderingMode(.palette)
                                                .foregroundStyle(Color("AccentColor"),Color.white)
                                                .opacity(self.selectedIndex == index ? 1.0 : 0.0)
                                            Image(systemName: tab.imageName)
                                                .symbolRenderingMode(.palette)
                                                .font(.system(size: 24))
                                                .foregroundStyle(Color("AccentColor"),Color.white)
                                                .opacity(self.selectedIndex != index ? 1.0 : 0.0)
                                        }
                                    )
                                    .background(
                                        ZStack {
                                            Text(tab.title)
                                                .font(.system(size: 10, weight: .bold))
                                                .foregroundStyle(Color.white)
                                                .opacity(self.selectedIndex == index ? 1.0 : 0.0)
                                            Text(tab.title)
                                                .font(.system(size: 10, weight: .bold))
                                                .foregroundStyle(Color.clear)
                                                .opacity(self.selectedIndex != index ? 1.0 : 0.0)
                                        }.offset(CGSize(width: 0, height: 32))
                                    )
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(height: self.selectedIndex == index ? 26 : 5)
                            }
                            .frame(width: proxy.size.width * 0.2)
                            .contentShape( Rectangle() )
                            .onTapGesture {
                                withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.7) ) { self.selectedIndex = index }
                            }
                        }
                    }
                    .background(
                        Rectangle()
                            .frame(height: 24 + 49 + 40)
                            .overlay(
                                Circle()
                                    .foregroundColor(Color("DarkColor2"))
                                    .frame(width: 40, height: 40)
                                    .offset(CGSize(width: CGFloat(self.selectedIndex - 2) * (proxy.size.width * 0.2), height: -29))
                            )
                            .foregroundColor(Color("DarkColor1"))
                            .offset(CGSize(width: 0, height: 20))
                            .mask(
                                VStack(spacing: 0) {
                                    TopFrameView()
                                        .frame(width: 75, height: 24)
                                        .offset(CGSize(width: CGFloat(self.selectedIndex - 2) * (proxy.size.width * 0.2), height: 0))
                                    Rectangle()
                                        .frame(height: 49 + 40)
                                }.offset(CGSize(width: 0, height: 20))
                            )
                            .shadow(color: Color("DarkColor1").opacity(1.0) , radius: 10, x: 0, y: 0)
                    )
                    .frame(height: 24 + 49)
                }
            }.ignoresSafeArea(edges: [.trailing, .leading])
        }
        .background(Color.white)

    }
}

#Preview {
    MainMenuView()
}
