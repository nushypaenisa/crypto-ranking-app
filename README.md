# crypto-ranking-app
Crypto Ranking iOS App
Overview
Crypto Ranking is an iOS application that fetches and displays the top 100 crypto currencies using the CoinRanking API. It includes features such as pagination, filtering, favoriting coins, and a detailed coin view with performance charts.
Features
* Fetch and display the top 100 cryptocurrencies with pagination (20 per page).
* Filter the list by highest price and best 24-hour performance.
* Swipe left to favorite/unfavorite a coin.
* View detailed information about a selected coin, including price, statistics, and performance graphs.
* Separate screen to manage favorite coins.
Technologies Used
* Swift for iOS development
* UIKit for table views and navigation
* SwiftUI for smaller views like coin details
* Charts framework for displaying performance data
* URLSession for API calls
Instructions for Building and Running the Application
1. Clone the repository from GitHub. git clone https://github.com/nushypaenisa/crypto-ranking-app.git
2. cd Crypto Ranking app
3. Open the project in Xcode. open CryptoRankingApp.xcodeproj
4. Install dependencies if needed (e.g., Charts library via Swift Package Manager).
5. Replace YOUR_API_KEY in APIManager.swift with a valid API key from CoinRanking.
6. Build and run the app using an iOS simulator or physical device.
Assumptions and Decisions
* The API key is required and must be provided manually.
* The pagination is implemented with a limit of 20 coins per page to optimize performance.
* Coin favoriting is stored locally using UserDefaults (not persisted in a database).
* SwiftUI is used selectively for views that benefit from declarative UI.
Challenges Encountered and Solutions
1. Pagination Handling
* Challenge: Ensuring smooth pagination without reloading the entire dataset.
* Solution: Used an incremental page counter and appended new data instead of replacing the list.
2. Mixing UIKit and SwiftUI
* Challenge: UIKit handles the list views, while SwiftUI is used for details.
* Solution: Used UIHostingController to integrate SwiftUI views into UIKit navigation.
3. Data Persistence for Favorites
* Challenge: Storing user favorites without a backend.
* Solution: Used UserDefaults to locally save and retrieve favorited coins.
4. Displaying Performance Charts
* Challenge: Fetching and displaying coin performance data in an intuitive manner.
* Solution: Used the Charts framework to plot price changes over time with mock data.
Future Enhancements
* Implement Core Data for persistent storage of favorite coins.
* Improve the UI with animations and better navigation flow.
* Enhance error handling and loading indicators.
Author
Martha Nashipae Nisa
License
This project is open-source under the MIT License.
