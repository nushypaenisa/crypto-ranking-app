//
//  CryptoDetailsScreen.swift
//  Crypto Ranking App
//
//  Created by Martha Nashipae on 21/02/2025.


import SwiftUI
import SwiftUI
import WebKit
import SwiftUICharts // Importing AppPear/ChartView

struct CoinDetailView: View {
    let crypto: Coin
    
    var body: some View {
        VStack(spacing: 16) {
            // Coin Header
            HStack {
                if crypto.iconURL.hasSuffix(".svg") {
                                    SVGImageView(svgURL: crypto.iconURL)
                                        .frame(width: 50, height: 50)
                                } else {
                                    AsyncImage(url: URL(string: crypto.iconURL)) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image.resizable()
                                                .frame(width: 50, height: 50)
                                        case .failure:
                                            Image(systemName: "photo")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                }
                VStack(alignment: .leading) {
                    Text(crypto.name)
                        .font(.title2)
                        .bold()
                    Text("Price: $\(crypto.price)")
                        .font(.headline)
                    Text("24h Change: \(crypto.change)%")
                        .foregroundColor(crypto.change.starts(with: "-") ? .red : .green)
                }
                Spacer()
            }
            .padding()
            
            // Line Chart
            if let sparkline = crypto.sparkline.compactMap({ Double($0 ?? "0") }), !sparkline.isEmpty {
                LineChartView(data: sparkline, title: "Price Trend", legend: "Last 24h")
                    //.frame(height: 250)
                    .frame(maxWidth: .infinity)
                    .padding()
            } else {
                Text("No chart data available")
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
    }
    // Custom View for Displaying SVGs
    struct SVGImageView: UIViewRepresentable {
        let svgURL: String
        
        func makeUIView(context: Context) -> WKWebView {
            let webView = WKWebView()
            webView.backgroundColor = .clear
            webView.isOpaque = false
            return webView
        }
        
        func updateUIView(_ webView: WKWebView, context: Context) {
            guard let url = URL(string: svgURL) else { return }
            let htmlString = """
            <html>
            <body style="margin:0; padding:0;">
            <img src="\(svgURL)" style="width:20%; height:20%;" />
            </body>
            </html>
            """
            webView.loadHTMLString(htmlString, baseURL: url.deletingLastPathComponent())
        }
    }
}

