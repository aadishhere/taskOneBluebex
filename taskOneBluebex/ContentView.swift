//
//  ContentView.swift
//  taskOneBluebex
//
//  Created by Aadish Jain on 12/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showMenu = false
    @State private var selectedScreen: String? = "Home"
    @State private var selectedTab: Tab = .home

    var body: some View {
        ZStack(alignment: .topLeading) {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }

            VStack {
                Spacer()
                BottomTabBarView(selectedTab: $selectedTab)
            }
            .ignoresSafeArea(.all)
            .zIndex(0)

            if showMenu {
                Color(.systemBackground)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showMenu.toggle()
                    }
                    .zIndex(1)
            }

            SideMenuView(selectedScreen: $selectedScreen)
                .frame(width: 280)
                .offset(x: showMenu ? 0 : -300)
                .animation(.default, value: showMenu)
                .shadow(radius: showMenu ? 0.25 : 0)
                .zIndex(2)

            VStack {
                TopBarView(showMenu: $showMenu)
                Spacer()
            }
            .zIndex(3)
        }
    }
}

struct TopBarView: View {
    @Binding var showMenu: Bool

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea(edges: .top)

            HStack(spacing: 16) {
                Button(action: {
                    withAnimation {
                        showMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.3.horizontal")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(.systemBackground))
                        .padding(10)
                        .background(Color(.systemBackground).opacity(0.15))
                        .clipShape(Circle())
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("BlueBex")
                        .font(.headline)
                        .foregroundColor(Color(.systemBackground))
                    Text("Stay Connected 🫱🏻‍🫲🏼")
                        .font(.caption)
                        .foregroundColor(Color(.systemBackground)).opacity(0.9)
                }
                Spacer()
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .foregroundColor(.blue).opacity(0.8)
                    .background(Circle().fill(Color(.systemBackground)))
            }
            .padding()
        }
        .frame(height: 70)
        .background(.ultraThinMaterial)
    }
}

struct SideMenuView: View {
    @Binding var selectedScreen: String?

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color(.systemBackground))
                    .padding(10)
                    .background(Circle().fill(LinearGradient(colors: [.blue, Color(.systemBackground)], startPoint: .topLeading, endPoint: .bottomTrailing)))
                VStack(alignment: .leading) {
                    Text("Aadish Jain")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text("BB000012")
                        .font(.caption)
                        .foregroundColor(.primary)
                    Text("aadish.bluebex@gmail.com")
                        .font(.caption)
                        .foregroundColor(.primary)
                }
            }
            .padding(.top, 100)
            .padding(.bottom, 1)
            .padding(.horizontal)

            Divider()

            VStack(alignment: .leading, spacing: 0) {
                MenuButton(icon: "list.bullet.rectangle", label: "All Tasks", isSelected: selectedScreen == "allTasks") { selectedScreen = "allTasks" }
                MenuButton(icon: "calendar", label: "Today", isSelected: selectedScreen == "todayTask") { selectedScreen = "todayTask" }
                MenuButton(icon: "clock.arrow.circlepath", label: "Upcoming", isSelected: selectedScreen == "upcomingTask") { selectedScreen = "upcomingTask" }
                MenuButton(icon: "checkmark.circle", label: "Completed", isSelected: selectedScreen == "completedTask") { selectedScreen = "completedTask" }
                MenuButton(icon: "star", label: "Important", isSelected: selectedScreen == "importantTask") { selectedScreen = "importantTask" }
                Divider()
                MenuButton(icon: "gear", label: "Settings", isSelected: selectedScreen == "settingView") { selectedScreen = "settingView" }
                MenuButton(icon: "arrowshape.backward", label: "Logout", isSelected: selectedScreen == "loginView") { selectedScreen = "loginView" }
            }
            .padding(.top, 10)
            .padding(.horizontal)

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
    }
}

struct MenuButton: View {
    var icon: String
    var label: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.headline)
                    .foregroundColor(isSelected ? .white : .blue)
                Text(label)
                    .font(.headline)
                    .foregroundColor(isSelected ? .white : .primary)
                Spacer()
            }
            .padding()
            .background(
                isSelected ? AnyView(LinearGradient(colors: [.blue, Color(.systemBackground)], startPoint: .leading, endPoint: .trailing)) : AnyView(Color.clear)
            )
            .cornerRadius(50)
        }
        .padding(.vertical, 4)
    }
}

struct HomeView: View {
    var body: some View {
        VStack {
            Image(systemName: "envelope.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .foregroundStyle(.primary)
            Text("Your Inbox is Empty")
                .font(.title3)
                .padding(.top)
                .foregroundColor(.primary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
    }
}

enum Tab: String, CaseIterable {
    case home, tasks, calendar, profile
}

struct BottomTabBarView: View {
    @Binding var selectedTab: Tab
    @Namespace private var animation

    var body: some View {
        GeometryReader { geo in
            let tabCount = Tab.allCases.count
            let tabWidth = geo.size.width / CGFloat(tabCount)
            let index = Tab.allCases.firstIndex(of: selectedTab) ?? 0
            let xOffset = tabWidth * CGFloat(index) + tabWidth / 2

            ZStack(alignment: .topLeading) {
                BottomTabBarShape(cutoutX: xOffset)
                    .fill(.blue.opacity(0.7))
                                    .frame(height: 100)
                                    .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: -5)
                                    .animation(.easeInOut(duration: 0.3), value: selectedTab)
                
                Circle()
                    .fill(.blue)
                    .frame(width: 10, height: 10)
                    .offset(x: xOffset - 5, y: -5)
                    .animation(.easeInOut(duration: 0.7), value: selectedTab)

                HStack(spacing: 0) {
                    TabBarButton(icon: "house", label: .home, selectedTab: $selectedTab)
                    TabBarButton(icon: "checklist", label: .tasks, selectedTab: $selectedTab)
                    TabBarButton(icon: "calendar", label: .calendar, selectedTab: $selectedTab)
                    TabBarButton(icon: "person.crop.circle", label: .profile, selectedTab: $selectedTab)
                }
                .padding(.horizontal, 4)
                .padding(.bottom, 1)
                .frame(height: 90)
            }
        }
        .frame(height: 90)
    }
}

struct TabBarButton: View {
    var icon: String
    var label: Tab
    @Binding var selectedTab: Tab

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedTab = label
            }
        }) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Color(.systemBackground))

               
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct BottomTabBarShape: Shape {
    var cutoutX: CGFloat
    var cutoutWidth: CGFloat = 40
    var cutoutDepth: CGFloat = 15

    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height

        var path = Path()

        //BottomBar
        path.addRoundedRect(in: CGRect(x: 0, y: 0, width: width, height: height), cornerSize: CGSize(width: 0, height: 0))

        let funnelPath = Path { p in
            let startX = cutoutX - cutoutWidth / 1
            let endX = cutoutX + cutoutWidth / 1
            _ = cutoutX
            let controlY = cutoutDepth

            p.move(to: CGPoint(x: startX, y: 0))

            //Centre Push waala to icon
            p.addQuadCurve(to: CGPoint(x: cutoutX, y: controlY),
                           control: CGPoint(x: startX + 10, y: controlY / 5))

            //icon se push to curve
            p.addQuadCurve(to: CGPoint(x: endX, y: 0),
                           control: CGPoint(x: endX - 10, y: controlY / 5))

            p.closeSubpath()
        }

        return path.subtracting(funnelPath)
    }
}


#Preview {
    ContentView()
}
