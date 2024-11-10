import SwiftUI

struct SplashScreenView: View {
    // State to control navigation to the main content
    @State private var isActive = false
    @State private var opacity: Double = 0.0
    
    var body: some View {
        if isActive {
            // When the timer ends, navigate to the main content
            MainContentView()
        } else {
            ZStack {
                // Set a background color
//                Color.white.edgesIgnoringSafeArea(.all)  // Set a background color (change as needed)
                
                VStack {
                    Spacer()
                    
                    // First image centered in the middle of the screen
                    Image("splashTop")  // Replace with your actual image name in the assets folder
                        .resizable()
                        .scaledToFit()
//                        .frame(maxWidth: 300, maxHeight: 300)  // Adjust the size as necessary
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.5)) {
                                opacity = 1.0  // Fade-in animation
                            }
                        }
                    
                    Spacer()
                    
                    // Second image at the bottom, filling the width and ignoring safe area
                    Image("splashBottom")  // Replace with your actual image name in the assets folder
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)  // Ensure the image fills the width
                        .ignoresSafeArea(edges: .bottom)  // Make sure the image touches the bottom edge of the screen
                }
            }
            .onAppear {
                // Start a timer to transition to the main content after 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

struct MainContentView: View {
    var body: some View {
        // Main content goes here after splash screen
        Text("Welcome to the Main Content")
            .font(.largeTitle)
            .padding()
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
