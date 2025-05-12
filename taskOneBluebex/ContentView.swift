import SwiftUI

struct ContentView: View {
    @State private var showMenu = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .zIndex(0)
            
            if showMenu {
                Color(.systemBackground)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showMenu.toggle()
                    }
                    .zIndex(1)
            }

            SideMenuView()
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
        HStack {
            Button(action: {
                withAnimation {
                    showMenu.toggle()
                }
            }) {
                Image(systemName: "line.horizontal.3")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            
            Spacer()

            Text("Inbox")
                .font(.title2.bold())
                .foregroundColor(.primary)

            Spacer()

            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 34, height: 34)
                .foregroundStyle(.primary)
        }
        .padding()
        .background(.ultraThinMaterial)
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

struct SideMenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
                    .padding(.top)

                VStack(alignment: .leading) {
                    Text("Aadish Jain")
                        .font(.headline)
                        .padding(.top)
                        .foregroundColor(.primary)

                    Text("aadish.bluebex@gmail.com")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical)

            Divider()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    MenuItem(icon: "mail.stack", label: "All inbox", isSelected: true)
                    Divider()
                    MenuItem(icon: "tray.full", label: "Primary")
                    MenuItem(icon: "person.2", label: "Social")
                    MenuItem(icon: "tag", label: "Promotions")
                    MenuItem(icon: "i.circle", label: "Updates")
                    Divider()
                    MenuItem(icon: "star", label: "Starred")
                    MenuItem(icon: "stopwatch", label: "Snoozed")
                    MenuItem(icon: "scope", label: "Important")
                    MenuItem(icon: "paperplane", label: "Sent")
                    MenuItem(icon: "pencil.line", label: "Draft")
                    MenuItem(icon: "exclamationmark.octagon", label: "Spam")
                    MenuItem(icon: "trash", label: "Trash")
                    Divider()
                    MenuItem(icon: "gear", label: "Setting")
                    MenuItem(icon: "exclamationmark.triangle", label: "Send feedback")
                }
            }

            Spacer()
        }
        .padding(.top, 60)
        .padding(.horizontal)
        .background(Color(.systemBackground))
    }
}

struct MenuItem: View {
    var icon: String
    var label: String
    var isSelected: Bool = false

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.headline)
                .foregroundColor(isSelected ? .blue : .primary)

            Text(label)
                .font(.headline)
                .foregroundColor(isSelected ? .blue : .primary)

            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(alignment: .trailing) {
            if isSelected {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color.accentColor.opacity(0.15))
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    ContentView()
}
