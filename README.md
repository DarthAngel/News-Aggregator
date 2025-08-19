The application connects to the NewsApi API, and allows to display a list of news that can be filtered by topic.
Clicking on any category launches a new news request to the server, with only news of that category.
 Clicking on the news, you can see more detail and from that view open an embedded browser to read the news in the original web.
The news can be saved by clicking on the favorite icon, these are saved using SwiftData.
The saved news can be viewed in the favorites view.
A search can also be performed in the view of the same name, this launches a new API request with the entered text.


 Technologies used:

-	SwiftUI to provide reactive properties to the code and a clean user interface.

-	Swift Concurrency with async/await

-	URLSession for connecting to the API

-	JSONDecoder  + codable type for decoding JSON responses from the server.

-	SwiftData  for storing favorites articles. 



You can use the API Key that is configured for testing, but if you plan to use it continuously, please register at NewsAPI.org, get a new API Key and replace the Key that appears in the Config.plist file in the root of the project.

