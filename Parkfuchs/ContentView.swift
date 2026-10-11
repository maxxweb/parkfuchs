//
//  ContentView.swift
//  Parkfuchs
//  © Parkfuchs
//  Design Malik Aziz
//  Created by Sven Raskin | maxxweb on 05.04.23.
//

import SwiftUI
import WebKit

struct ContentView: View {
    let parkfuchsURL = URL(string: "https://parkfuchs.app")!

    @State private var isInternetConnected = true
    @State private var isTeamViewPresented = false
    @State private var isLocationViewPresented = false

    var body: some View {
        Group {
            if IPhoneDuo.isCurrent {
                duoRoot
            } else {
                standardRoot
            }
        }
        .onAppear {
            checkInternetConnection()
        }
        .sheet(isPresented: $isTeamViewPresented) {
            TeamView()
                .duoSheetPresentation()
        }
        .sheet(isPresented: $isLocationViewPresented) {
            LocationCityView()
                .duoSheetPresentation()
        }
    }

    /// Classic iPhone: floating gear over the web view.
    private var standardRoot: some View {
        Group {
            if isInternetConnected {
                ZStack(alignment: .topTrailing) {
                    WebView(url: parkfuchsURL)
                        .ignoresSafeArea(edges: .bottom)
                        .background(Color.accentColor.edgesIgnoringSafeArea(.top))
                        .preferredColorScheme(.light)

                    Button {
                        isTeamViewPresented = true
                    } label: {
                        Image("zahnrad")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 33)
                            .padding(.horizontal, 2)
                            .padding(.vertical, 7)
                    }
                    .padding()
                    .accessibilityLabel("Einstellungen")
                }
            } else {
                offlineView
            }
        }
    }

    /// iPhone Duo: settings live in the system toolbar (vertical bar).
    private var duoRoot: some View {
        NavigationStack {
            Group {
                if isInternetConnected {
                    WebView(url: parkfuchsURL)
                        .ignoresSafeArea(edges: .bottom)
                        .background(Color.accentColor.ignoresSafeArea(.container, edges: .top))
                        .preferredColorScheme(.light)
                } else {
                    offlineView
                }
            }
            .toolbar {
                if #available(iOS 27.1, *) {
                    ToolbarItem(placement: .topBarTrailing) {
                        settingsToolbarButton
                    }
                    .axisBehavior(.verticalPreferred)
                } else {
                    ToolbarItem(placement: .topBarTrailing) {
                        settingsToolbarButton
                    }
                }
            }
        }
    }

    private var settingsToolbarButton: some View {
        Button {
            isTeamViewPresented = true
        } label: {
            Label {
                Text("Einstellungen")
            } icon: {
                Image("zahnrad")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 22)
            }
        }
        .accessibilityLabel("Einstellungen")
    }

    private var offlineView: some View {
        GeometryReader { proxy in
            let side = min(proxy.size.width, proxy.size.height) * 0.72
            VStack(spacing: 16) {
                Spacer(minLength: 0)
                Image("offlineImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: side, height: side)
                Text("Der Fuchs schläft gerade")
                    .font(.title)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                Button("Try again") {
                    checkInternetConnection()
                }
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }

    func checkInternetConnection() {
        let url = URL(string: "https://parkfuchs.app")!
        let task = URLSession.shared.dataTask(with: url) { _, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    isInternetConnected = false
                    print("Error checking internet connection: \(error.localizedDescription)")
                } else if let httpResponse = response as? HTTPURLResponse {
                    isInternetConnected = httpResponse.statusCode == 200
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
        webView.scrollView.bounces = true
        webView.scrollView.backgroundColor = UIColor(red: 208/255, green: 217/255, blue: 192/255, alpha: 1.0)
        webView.scrollView.isScrollEnabled = true
        webView.scrollView.alwaysBounceVertical = true
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.decelerationRate = .normal

        webView.load(URLRequest(url: url))
        webView.scrollView.contentInsetAdjustmentBehavior = .never
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
                if let url = navigationAction.request.url {
                    UIApplication.shared.open(url)
                    decisionHandler(.cancel)
                    return
                }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
