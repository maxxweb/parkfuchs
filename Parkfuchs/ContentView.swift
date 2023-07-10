//
//  ContentView.swift
//  Parkfuchs
//  © Parkfuchs
//  Malik Aziz
//  Created by maxxweb on 05.04.23.
//

import SwiftUI
import WebKit
import SystemConfiguration

struct ContentView: View {
    let parkfuchsURL = URL(string: "https://parkfuchs.app")!

    @State private var isInternetConnected = true
    @State private var colorScheme: ColorScheme = .light
    
    var body: some View {
        NavigationView {
            if isInternetConnected {
                ZStack(alignment: .bottomLeading) {
                    WebView(url: parkfuchsURL)
                        .ignoresSafeArea(edges: .bottom) // Ignoriert die untere Safe Area
                        .background(Color.accentColor.edgesIgnoringSafeArea(.top)) // Füllt die obere Safe Area mit accentColor
                        .preferredColorScheme(.light) // black tint on status bar
                }

            } else {
                VStack {
                    Image("offlineImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    Text("Der Fuchs schläft gerade")
                        .font(.title)
                        .foregroundColor(.red)
                    Button("Try again") {
                        checkInternetConnection()
                    }
                }

            }
        }
        .onAppear {
            checkInternetConnection()
        }
    }

    func checkInternetConnection() {
        let url = URL(string: "https://parkfuchs.app")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    isInternetConnected = false
                    print("Error checking internet connection: \(error.localizedDescription)")
                } else if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        isInternetConnected = true
                    } else {
                        isInternetConnected = false
                    }
                }
            }
        }
        task.resume()
    }
}

struct WebView: UIViewRepresentable {
    static var current: WKWebView?
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        // Anpassung für flüssigeres Scrollen
        webView.scrollView.bounces = true
        //webView.scrollView.backgroundColor = UIColor.green
        webView.scrollView.backgroundColor = UIColor(red: 208/255, green: 217/255, blue: 192/255, alpha: 1.0)
        webView.scrollView.isScrollEnabled = true
        webView.scrollView.alwaysBounceVertical = true
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.decelerationRate = .normal

        webView.load(URLRequest(url: url))
        webView.scrollView.contentInsetAdjustmentBehavior = .never // Deaktivieren des automatischen Inhaltsversatzes unten
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if uiView.url != url {
            uiView.load(URLRequest(url: url))
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            WebView.current = webView
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.targetFrame == nil {
                //externe links
                if let url = navigationAction.request.url {
                                   UIApplication.shared.open(url)
                                   decisionHandler(.cancel)
                                   return
                               }
                //
                webView.load(navigationAction.request)
            }
            decisionHandler(.allow)
        }
    }

    static func load(url: URL) {
            if let webView = WebView.current {
                webView.load(URLRequest(url: url))
            }
        }
}

func hasBottomSafeAreaInset() -> Bool {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
        return false
    }
    
    let bottomSafeAreaInset = windowScene.windows.first?.safeAreaInsets.bottom ?? 0
    return bottomSafeAreaInset > 0
}

//prüfen ob es ein Gerät ohne FaceID ist
func shouldApplyBottomPadding() -> Bool {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
        return false
    }
    
    let bottomSafeAreaInset = windowScene.windows.first?.safeAreaInsets.bottom ?? 0
    return bottomSafeAreaInset == 0
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
