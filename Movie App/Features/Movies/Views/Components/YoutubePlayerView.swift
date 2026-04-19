//
//  YoutubePlayerView.swift
//  Movie App
//
//  Created by Leetha.dm on 18/04/26.
//

import SwiftUI
import WebKit

struct YouTubePlayerView: UIViewRepresentable {
    let videoID: String
    @Binding var isLoading: Bool
    @Binding var hasError: Bool
    
    private let origin = "https://localhost"
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        config.websiteDataStore = WKWebsiteDataStore.default()
        
        let controller = config.userContentController
        controller.add(context.coordinator, name: YouTubePlayerEvent.onReady.rawValue)
        controller.add(context.coordinator, name: YouTubePlayerEvent.onError.rawValue)
        controller.add(context.coordinator, name: YouTubePlayerEvent.onStateChange.rawValue)
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.navigationDelegate = context.coordinator
        webView.backgroundColor = .black
        webView.isOpaque = false
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        guard !videoID.isEmpty else { return }
        
        let html = YouTubePlayerHTML.generate(videoID: videoID, origin: origin)
        webView.loadHTMLString(html, baseURL: URL(string: origin))
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        var parent: YouTubePlayerView
        
        init(_ parent: YouTubePlayerView) { self.parent = parent }
        
        func userContentController(_ userContentController: WKUserContentController,
                                   didReceive message: WKScriptMessage) {
            switch message.name {
            case YouTubePlayerEvent.onReady.rawValue:
                parent.isLoading = false
            case YouTubePlayerEvent.onError.rawValue:
                parent.isLoading = false
                parent.hasError = true
            case YouTubePlayerEvent.onStateChange.rawValue:
                if let state = message.body as? Int, state == 1 {
                    parent.isLoading = false
                }
            default:
                break
            }
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
            parent.hasError = true
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!,
                     withError error: Error) {
            parent.isLoading = false
            if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                parent.hasError = true
            }
        }
    }
}
