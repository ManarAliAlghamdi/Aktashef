import SwiftUI

struct CountryDetailWithTabsView: View {
    var country: Countries  // Selected country
    
    @State private var categories: [Category] = []  // List of categories
    @State private var categoryContent: [CategoryContent] = []  // Content for the selected country
    @State private var selectedTab: Int = 0  // Track the selected tab

    // Filter content based on the selected tab and country
    var filteredContent: [CategoryContent] {
        return categoryContent.filter { $0.counrtryId == country.counrtryId && $0.catagoryId == categories[selectedTab].catagoryId }
    }
    
    var body: some View {
        VStack {
            // Header with country image and name
            ZStack(alignment: .bottomLeading) {
                Image(country.counrtryImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .clipped()
                    .cornerRadius(20)
                    .shadow(radius: 10)
//
//                // Country Name Text over Image
//                Text("\(country.counrtryName)")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .padding(.bottom, 10)
//                    .padding(.leading, 10)
//                    .multilineTextAlignment(.leading)
//                    .shadow(color: .black, radius: 10)
            }
            .padding()

            // Custom Tab Bar using ScrollView for dynamic button sizes
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(0..<categories.count, id: \.self) { index in
                        Button(action: {
                            selectedTab = index
                        }) {
                            Text(categories[index].catagoryName)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)  // Ensure the button expands with the text
                                .background(selectedTab == index ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(selectedTab == index ? .white : .black)
                                .cornerRadius(25)
                        }
                        .animation(.easeInOut(duration: 0.2))  // Smooth transition on tab switch
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 50)  // Ensure the height is sufficient for the tab bar

            // Content View Based on Selected Tab
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Add Section Header with Title and Icon
                    if selectedTab < categories.count {
                        SectionHeaderView(
                            title: getCategoryTitle(for: categories[selectedTab].catagoryId),
                            iconName: getIconName(for: categories[selectedTab].catagoryId)
                        )
                    }

                    // Display the filtered content based on the selected tab
                    if let content = filteredContent.first?.content {
                        Text(content)
                            .styleContentText()
                            .multilineTextAlignment(.leading)  // Right-align the text for Arabic
                    } else {
                        Text("لا يوجد محتوى متاح لهذه الفئة.")  // If no content is available
                            .styleContentText()
                            .multilineTextAlignment(.trailing)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitle(country.counrtryName)
        .environment(\.layoutDirection, .rightToLeft)  // Enforce RTL layout for the entire view
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
                selectedTab = 0  // Start with the first tab selected
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

    // Helper function to get category title based on id
    func getCategoryTitle(for categoryId: Int) -> String {
        return categories.first { $0.catagoryId == categoryId }?.catagoryName ?? "Unknown"
    }

    // Helper function to get icons for each category
    func getIconName(for categoryId: Int) -> String {
        switch categoryId {
        case 1: return "globe.europe.africa"
        case 2: return "person.2.fill"
        case 3: return "fork.knife"
        case 4: return "text.bubble"
        case 5: return "map.fill"
        case 6: return "exclamationmark.triangle"
        default: return "questionmark.circle"
        }
    }
}

struct SectionHeaderView: View {
    var title: String
    var iconName: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: iconName)
                .foregroundColor(.gray)
                .font(.title2)
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.trailing)  // Right-align the header text
        }
        .padding(.vertical, 8)
        Divider()
    }
}

// Extension to style content text with uniform styling
extension Text {
    func styleContentText() -> some View {
        self
            .font(.body)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.leading)  // Align content text to the right for Arabic
    }
}
