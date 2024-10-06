import SwiftUI

struct CountryDetailWithTabsView: View {
    var country: Countries
    @State private var selectedTab: String? = "نبذة"  // Default selected tab
    @State var categories: [String] = ["نبذة", "الأكل", "كلمات", "أماكن", "انتبه تسويها", "عاداتهم"]

    var body: some View {
        VStack {
            // Header Image and Country Title (similar to CountryListView design)
            ZStack(alignment: .bottomTrailing) {
                Image(country.counrtryImageName)
                    .resizable()
                    .scaledToFill()  // Ensures the image fills the entire frame
                    .frame(height: 180)  // Consistent image height similar to CountryListView
                    .clipped()  // Avoid image overflow
                    .cornerRadius(20)  // Rounded corners
                    .shadow(radius: 10)

                // Country Name Text over Image
                Text(country.counrtryName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                    .padding(.trailing, 10)
                    .shadow(color: .black, radius: 10)
            }
            .padding()

            // Tab Buttons with Reduced Spacing and Softer Colors
            VStack {
                ZStack {
//                    Rectangle()
//                        .fill(Color.gray.opacity(0.2))
//                        .frame(width: UIScreen.main.bounds.width, height: 60)  // More compact background height
//                        .shadow(radius: 2)

                    ScrollView(.horizontal) {
                        HStack(spacing: 5) {  // Reduced spacing between the buttons
                            ForEach(categories, id: \.self) { category in
                                TabButton(title: category, isSelected: selectedTab == category) {
                                    selectedTab = category
                                }
                                .frame(height: 60)  // Consistent button height
                                                                .padding(.horizontal, 3)  // Padding inside the button to keep text centered
                                                                .layoutPriority(1)  // E
                            }
                        }
                        .padding(.horizontal, 20)  // Padding to avoid touching the phone sides
                    }
                }
            }

            // Content View Based on Selected Tab
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if selectedTab == "نبذة" {
                        SectionTitle(title: "About \(country.counrtryName)")
                        Text("Here is some information about \(country.counrtryName)...")
                    } else if selectedTab == "الأكل" {
                        SectionTitle(title: "Food in \(country.counrtryName)")
                        Text("Famous food details go here...")
                    } else if selectedTab == "كلمات" {
                        SectionTitle(title: "Common Words in \(country.counrtryName)")
                        Text("Here are some common phrases...")
                    } else if selectedTab == "أماكن" {
                        SectionTitle(title: "Must-Visit Spots in \(country.counrtryName)")
                        Text("Here are the must-visit spots...")
                    } else if selectedTab == "انتبه تسويها" {
                        SectionTitle(title: "Things to Avoid in \(country.counrtryName)")
                        Text("Here are things you should avoid...")
                    } else if selectedTab == "عاداتهم" {
                        SectionTitle(title: "Cultural Habits in \(country.counrtryName)")
                        Text("Here are some of the local customs and habits...")
                    }
                }
                .padding()
                .background(Color(UIColor.systemGroupedBackground))
            }
        }
        .navigationTitle(country.counrtryName)
    }
}

// Custom button component with softer colors and reduced spacing
struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Text(title)
            .font(.body)
            .padding(.vertical, 10)
            .padding(.horizontal, 25)
            .background(
                ZStack {
                    if isSelected {
                        LinearGradient(gradient: Gradient(colors: [Color.brown.opacity(0.3), Color.white.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .clipShape(Capsule())
                            .shadow(color: Color.brown.opacity(0.3), radius: 5, x: 0, y: 3)
                    } else {
                        Capsule()
                            .fill(Color.gray.opacity(0.1))
                    }
                }
            )
            .foregroundColor(isSelected ? .white : .gray)
            .overlay(
                Capsule()
                    .stroke(isSelected ? Color.brown.opacity(0.5) : Color.gray, lineWidth: 1)
            )
            .scaleEffect(isSelected ? 1.05 : 1.0)
            .animation(.easeInOut(duration: 0.2))
            .onTapGesture {
                action()  // Call the action when tapped
            }
    }
}

// Section title component
struct SectionTitle: View {
    var title: String

    var body: some View {
        HStack {
            Image(systemName: "info.circle")
                .foregroundColor(.blue)
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
        }
        .padding(.vertical, 10)
    }
}
