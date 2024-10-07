import SwiftUI

struct CountryDetailWithTabsView: View {
    var country: Countries

    @State private var selectedTab: Category?  // Default selected tab
    @State private var categories: [Category] = []
    @State private var categoryContent: [CategoryContent] = []

    var filteredContent: [CategoryContent] {
        return categoryContent.filter { $0.counrtryId == country.counrtryId && $0.catagoryId == selectedTab?.catagoryId }
    }

    var body: some View {
        VStack {
            // Header Image and Country Title
            ZStack(alignment: .bottomLeading) {
                Image(country.counrtryImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .clipped()
                    .cornerRadius(20)
                    .shadow(radius: 10)

                // Country Name Text over Image
                Text("\(country.counrtryName)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                    .padding(.leading, 10)
                    .multilineTextAlignment(.leading)
                    .shadow(color: .black, radius: 10)
            }
            .padding()

            // Tab Buttons aligned to the right (RTL)
            VStack {
                ZStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(categories) { category in
                                TabButton(title: category.catagoryName, isSelected: selectedTab?.catagoryId == category.catagoryId) {
                                    selectedTab = category
                                }
                                .frame(height: 50)
                                .padding(.horizontal, 3)
                                .layoutPriority(1)
                            }
                        }
                            .padding(.horizontal, 15)
                        .frame(maxWidth: .infinity, alignment: .trailing)  // Align tabs to the right
                        .environment(\.layoutDirection, .leftToRight)  // Enforce RTL layout
                    }
                }
            }

            // Content View Based on Selected Tab
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if let selectedTab = selectedTab {
                        if let content = filteredContent.first?.content {
                            SectionTitle(title: selectedTab.catagoryName)
                                .multilineTextAlignment(.leading)
                            Text(content)
                                .multilineTextAlignment(.leading)
                        } else {
                            Text("No content available for this category.")
                                .padding()
                                .font(.body)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
                .padding()
                .background(Color(UIColor.systemGroupedBackground))
            }
        }
        .environment(\.layoutDirection, .rightToLeft)  // Enforce RTL layout
        .onAppear {
            loadCategories()
            loadCategoryContent()
        }
    }

    // Load Categories from catagory.json
    func loadCategories() {
        if let url = Bundle.main.url(forResource: "catagory", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let loadedCategories = try? decoder.decode([Category].self, from: data) {
                categories = loadedCategories
                selectedTab = categories.first // Select the first category by default
            } else {
                print("Failed to decode categories.")
            }
        } else {
            print("Failed to load catagory.json")
        }
    }

    // Load Category Content from catagoryContent.json
    func loadCategoryContent() {
        if let url = Bundle.main.url(forResource: "catagoryContent", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let loadedCategoryContent = try? decoder.decode([CategoryContent].self, from: data) {
                categoryContent = loadedCategoryContent
            } else {
                print("Failed to decode category content.")
            }
        } else {
            print("Failed to load catagoryContent.json")
        }
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
                        LinearGradient(gradient: Gradient(colors: [Color.brown.opacity(0.3), Color.white.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomLeading)
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
        .multilineTextAlignment(.leading)
        .padding(.vertical, 10)
    }
}
