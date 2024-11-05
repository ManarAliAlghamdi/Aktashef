import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    private let name: String

    init(_ name: String) {
        self.name = name
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
        webView.isOpaque = false // Transparent background for GIF
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = false

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}

struct FunSplashScreen: View {
    @State private var moveGif1 = false
    @State private var moveGif2 = false
    @State private var moveGif3 = false
    @State private var moveGif4 = false
    
    var body: some View {
        ZStack {
            // Background color
            Color.brown.opacity(0.4)
                .ignoresSafeArea()

            // Make logo3 larger without affecting quality
            ZStack {
                
                GifImage("logo3")
                    .frame(width: 200, height: 200) // Increase GIF size
            }
            .offset(x: moveGif1 ? -206 : 150, y: moveGif1 ? -200 : 200)
            .animation(Animation.easeInOut(duration: 3).repeatForever(autoreverses: true), value: moveGif1)

            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.3)) // Background for passport
                    .frame(width: 170, height: 170)
                
                GifImage("passport")
                    .frame(width: 120, height: 120)
            }
            .offset(x: moveGif2 ? 200 : -200, y: moveGif2 ? 150 : -150)
            .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true), value: moveGif2)

            ZStack {
                
                GifImage("logo3")
                    .frame(width: 200, height: 200) // Increase GIF size
            }
            .offset(x: moveGif3 ? 100 : -100, y: moveGif3 ? 250 : -250)
            .animation(Animation.easeInOut(duration: 3.5).repeatForever(autoreverses: true), value: moveGif3)

            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.3)) // Background for another passport GIF
                    .frame(width: 180, height: 180)
                
                GifImage("passport")
                    .frame(width: 140, height: 140)
            }
            .offset(x: moveGif4 ? -250 : 250, y: moveGif4 ? -100 : 100)
            .animation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true), value: moveGif4)
            
            // Center welcome text
            Text("يا اهلاً وسهلاً")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .shadow(radius: 10)
                .scaleEffect(moveGif1 ? 1.1 : 0.9)

        }
        .onAppear {
            moveGif1 = true
            moveGif2 = true
            moveGif3 = true
            moveGif4 = true
        }
    }
}

struct FunSplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        FunSplashScreen()
    }
}
