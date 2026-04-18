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
        controller.add(context.coordinator, name: "onReady")
        controller.add(context.coordinator, name: "onError")
        controller.add(context.coordinator, name: "onStateChange")
        
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
        
        let html = """
        <!DOCTYPE html>
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
            <style>
                * { margin: 0; padding: 0; background: #000; box-sizing: border-box; }
                body { width: 100vw; height: 100vh; overflow: hidden; }
                #player { width: 100%; height: 100%; }
            </style>
        </head>
        <body>
            <div id="player"></div>
            <script src="https://www.youtube.com/iframe_api"></script>
            <script>
                var player;
                function onYouTubeIframeAPIReady() {
                    player = new YT.Player('player', {
                        videoId: '\(videoID)',
                        playerVars: {
                            'playsinline': 1,
                            'autoplay': 0,
                            'controls': 1,
                            'rel': 0,
                            'modestbranding': 1,
                            'origin': '\(origin)'
                        },
                        events: {
                            'onReady': function(e) {
                                window.webkit.messageHandlers.onReady.postMessage('ready');
                            },
                            'onError': function(e) {
                                window.webkit.messageHandlers.onError.postMessage(e.data);
                            },
                            'onStateChange': function(e) {
                                window.webkit.messageHandlers.onStateChange.postMessage(e.data);
                            }
                        }
                    });
                }
            </script>
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: URL(string: origin))
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        var parent: YouTubePlayerView
        
        init(_ parent: YouTubePlayerView) { self.parent = parent }
        
        func userContentController(_ userContentController: WKUserContentController,
                                   didReceive message: WKScriptMessage) {
            switch message.name {
            case "onReady":
                parent.isLoading = false
            case "onError":
                parent.isLoading = false
                parent.hasError = true
            case "onStateChange":
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
