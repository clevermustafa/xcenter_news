# xcenter_news

Xcenter news is an app which shows news by category from (Newsapi.org)
Flutter Version: latest

### Xcenter News follows clean architecture.

Design is made responsive by using Mediaquery and Layout builder. It has only one page DashboardPage and one InitializationPage.

When app opens InitializationPage gets called which gets apiKey of newsapi.org from firestore database and saves that key to local storage in shared preference so that we dont need to call firebase everytime.

After Key is fetched from firestore Initialization page pushes app to DashboardPage where news are shown

### Notification is shown when notification icon in the DashboardScreen is pressed

Firebase Cloud Messaging(FCM) has been setup and have used flutter local Notification to receive push notification in foreground state. 

User has been subscribed to (notTest) topic when app is opened 

When user presses on the Notification icon on the DashboardPage fcm post api is invoked which sends notification to firebase and inturn firebase sends notification to the app and flutter local notification plugin shows notification in foreground.
