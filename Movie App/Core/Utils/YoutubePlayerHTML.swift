//
//  YoutubePlayerHTML.swift
//  Movie App
//
//  Created by Leetha.dm on 19/04/26.
//

import Foundation

enum YouTubePlayerHTML {
    static func generate(videoID: String, origin: String) -> String {
                """
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
    }
}
