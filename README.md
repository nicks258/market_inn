

# Market Inn
Flutter app that displays a list of trading instruments(stocks, crypto, etc) along with a real-time price ticker to reflect price fluctuations.


## About
Flutter mobile app where users can view real time prices,company info and search there favorite stocks.

## Framework
1. Flutter: 3.24.3
2. Dart Sdk: 3.5.3
## Setup

Install and set up the Flutter environment with version `3.24.3`. Ensure the `instruments.json` file is located in the `assets\resource` folder. You can modify the home screen loading symbols using this file. Sample required json structure `{"symbol":"BINANCE:ETHUSDT",  
"exchange": "BINANCE",  
"type": "Crypto"}`.
## Features
- The app features to show real-time price updates of instruments using websockets provided by [Finnhub.io](https://finnhub.io/docs/api/websocket-trades). Visually indicating whether prices have **increased**, **decreased**, or has **remained stable** with price difference between current and previous price.
- To enhance UX during after-market hours when Finnhub websockets fail to emit data, the app waits 10 seconds before using the [Finnhub quote API](https://finnhub.io/docs/api/quote) to fetch current and previous close prices. This service runs every 5 minutes to minimize API calls.
- The app offers a sleek user experience with both **light** and **dark** themes, catering to user preferences and enhancing overall usability.
- When a user clicks on a specific symbol, the app displays the company’s profile, including details like the logo, market capitalization, and industry, using the  [Finnhub company profile](https://finnhub.io/docs/api/company-profile2).
- The app features a powerful [search](https://finnhub.io/docs/api/symbol-search) functionality that finds the best-matching symbols based on your query. You can search using symbols, security names, ISINs, or CUSIPs.
- Implemented widget test cases to ensure UI components render correctly and behave as expected, along with unit tests to thoroughly cover business logic.

- The app can detect changes in **internet connectivity**, handle potential errors, and display the last updated prices for symbols. It **reconnects** to the websocket when the device is back online and notifies the user if the device is offline.
- In case of a websocket disconnection, the app automatically attempts to **reconnect** and fetch updated prices from tickers. The maximum reconnect limit is 5, adjustable based on business logic.
- The list of symbols is fetched from `instruments.json` in the assets folder, ensuring the app’s scalability for future updates to load the list from a **Server** or **Firestore**.
- The project code adheres to **clean code architecture**, **best practices**, and **Test Driven Development** (TDD). It includes comprehensive code comments and test cases, ensuring robustness and scalability.

## Project Architecture

This application has been developed utilizing Clean Architecture principles, using BLoc as state management solution which helps to achive clear separation of concerns.
![clean architecture image](https://lh3.googleusercontent.com/d/1AyaR-OvRRx4BCekiQNtA5i1HD-u6-bQH=w1000?authuser=0)
### Clean Code Architecture Layers
1.  **Presentation Layer**
    ##### Responsibility
    The Presentation Layer is the outermost layer, responsible for presenting information to the user and  capturing user interactions. It includes all the components related to the user interface (UI), such as widgets, screens, and presenters/controllers (State Management).

    #### Components
    - <font size="3"> **Screens:**  Represent the feature screens.</font>
    -  <font size="3"> **Widgets and UI Components:**  Represent the visual elements of the application.		</font>
    - <font size="3">  **Manager/Controllers**: Contain the presentation logic that interacts with the UI components. They receive user input, communicate with the Use Cases in the Domain Layer, and update the UI accordingly.</font>
<figure><figcaption>Presentation layer project structure</figcaption> <img src="https://lh3.googleusercontent.com/d/1Y99wEdGIzrISGVMn7MD1k0eAaiU3S2Jj=w1000?authuser=0" height="400" alt="Welcome Page"></figure>

2.  **Domain Layer**
    #### Responsibility
    The Domain Layer, also known as the Business Logic or Use Case Layer, contains the core business rules and logic of the application. It represents the heart of the software system, encapsulating the essential functionality that is independent of any particular framework.

    #### Components

    - <font size="3"> **Entities:**  Represent the fundamental business objects or concepts.</font>
    - <font size="3"> **Use Cases**: Contain application-specific business rules and orchestrate the flow of data between entities. They are responsible for executing specific actions or operations.</font>
    - <font size="3"> **Business Rules and Logic (Repository):**  Core functionality that is crucial to the application’s domain.</font>
<figure><figcaption>Domain layer project structure</figcaption> <img src="https://lh3.googleusercontent.com/d/1dPwj2M9WffCo7OlN__prNISuhOjzXuxg=w1000?authuser=0" height="400" alt="Welcome Page"></figure>

3.  **Data Layer**

    #### Responsibility

    The Data Layer is responsible for interacting with external data sources, such as databases, network services, or repositories. It handles the storage and retrieval of data.

    #### Components

    - <font size="3"> **Repositories or Gateways**: Abstract interfaces that define how data is accessed and stored.</font>
    - <font size="3">**Data Models:**  Represent the structure of the data as it is stored in the external data sources.</font>
    - <font size="3">**Data Sources:**  Implementations of repositories that interact with databases, APIs, or other external services.</font>
<figure><figcaption>Data layer project structure</figcaption> <img src="https://lh3.googleusercontent.com/d/1HtGWZOZDsxYsOqn6ZBHMixM2rcT6zIB3=w1000?authuser=0" height="400" alt="Welcome Page"></figure>

### Reason for choosing this architecture
1.  **Separation of Concerns**: By dividing the app into distinct layers (presentation, domain, and data), each layer has a clear responsibility, making the codebase easier to manage and understand.

2.  **Scalability**: Clean architecture supports the growth of your application. As new features are added, the modular structure allows for easy integration without affecting existing functionality.

3.  **Testability**: With well-defined boundaries between layers, unit testing becomes more straightforward. You can test each layer independently, ensuring robust and reliable code.

4.  **Maintainability**: Clean architecture promotes writing clean, readable, and maintainable code. This reduces technical debt and makes it easier for new developers to understand and contribute to the project.

5.  **Reusability**: Components within the architecture can be reused across different parts of the application or even in different projects, enhancing productivity and consistency.

6.  **Flexibility**: The architecture allows for easy swapping of implementations. For instance, you can change the data source (e.g., from a local database to a remote API) without altering the business logic or presentation layer.

7.  **Consistency**: Adopting a standard architecture across projects ensures a consistent approach to development, which can improve collaboration and reduce onboarding time for new team members.

## State Management

The application’s state management is managed using the **flutter-bloc** library in conjunction with the **freezed** and **equatable** package for an optimized and maintainable codebase. It provides a **clear separation** of concerns between the **user interface** and **business logic**, making the codebase more organized and easy to understand.
<figure> <img src="https://www.ics.com/sites/default/files/images/figure2_%20bloc.png"  alt="Welcome Page"></figure>

**Reason**: Over the last year I've been building a lot of Flutter apps, big and small. During this time, I have experiment with almost all popular state management that are available some of are **BLoc**, **Riverpod**,  **Getx**, **setState**, **Provider**, **MobX**. The reason I prefer BLoc for big and scalable projects is Bloc makes it easy to separate presentation from business logic, making code fast, easy to test, and reusable.
Bloc's strength lies in its ability to handle complex, asynchronous state transitions while keeping code modular and testable, which makes it a good choice for larger projects or teams that benefit from a structured approach.
**The Unique Selling Proposition (USP)** of Bloc over other state management solutions are:
-   **Separation of Concerns**: Bloc enforces a clear separation between business logic and UI, which leads to a more maintainable and scalable codebase. This helps developers follow the **BLoC pattern** (Business Logic Component), keeping business logic independent of the Flutter framework.

-   **Testability**: Bloc is designed with a focus on **testability**. The separation of business logic into pure Dart classes makes it easier to test without needing UI components. Additionally, each Bloc uses **Streams**, which are straightforward to test with tools like mocktail or mockito.

-   **State Traceability**: Bloc makes state transitions **predictable and traceable**. The explicit definition of events and states makes debugging simpler, as you can follow the flow of states through events. The Bloc **transition** feature allows tracking changes in state as they occur, which is beneficial for understanding how and why the app arrived in a particular state.

-   **Consistency**: Bloc promotes **consistency** in how state is managed across the application. Unlike some other state management techniques, such as Provider or Riverpod, where there is flexibility in how state is accessed and mutated, Bloc's explicit pattern reduces ambiguity in how data flows within the app.

-   **Community and Ecosystem**: Bloc has a strong community and ecosystem around it, including well-maintained libraries like **flutter_bloc**, **bloc_test**, and **hydrated_bloc** (for state persistence). These make Bloc a feature-rich, mature option for state management.

## Project File Structure

Project is split in:

-  **Presentation Layer**  
   It is the  outermost layer, responsible for presenting information to the user and capturing user interactions.
    - Widgets, Views and State Management

- **Domain Layer**  
  The Domain Layer, also known as the Business Logic or Use Case Layer, contains the core business rules and logic of the application.

    - Entities, Repository, Usecases.

-  **Data Layer**  
   The Data Layer is responsible for interacting with external data sources, such as databases, network services. It handles the storage and retrieval of data.

    - Datasources(WebSocket, RestApis)
    - Models
    - Repositories

-  **Core**  
   This folder includes all common files that are used in an App  and independent of all these layers.
    - Data(Custom network exceptions from server)
    - Domain(base usecase)
    - Extensions
    - Presentation(reusable widgets)
    - Resources(App constants)
    - Services(service locator[get_it], internet connectivity service)
    - Theme(App theme and color schemes)
    - Utils(app search delegate, enums, global snakebar)

## Testing

Implemented widget test cases to ensure UI components render correctly and behave as expected, along with unit tests to thoroughly cover business logic. All test cases are systematically organized within the test directory. The implementation of these test cases was facilitated by the utilization of **flutter_test**, **Mocktail**, and **bloc_test** frameworks.


### Test Cases Project Structure
Test case project structure follows the same project structure as the main code does to make it easy to maintain and access as recommend by [Google Flutter Team](https://docs.flutter.dev/testing/overview).

- <figure><figcaption>Widget test cases</figcaption><br> <img src="https://lh3.googleusercontent.com/d/1zNJohA4YR5VSQQSYAXEEp0bruN2nbKCL=w1000?authuser=0" height="200" alt="Welcome Page"></figure>
- <figure><figcaption>Unit test cases</figcaption><br> <img src="https://lh3.googleusercontent.com/d/1ooYboVHsqvpMUMfUwMFIqo6i85R1ekPc=w1000?authuser=0" height="200" alt="Welcome Page"></figure>
- <figure><figcaption>Mocked classes</figcaption><br> <img src="https://lh3.googleusercontent.com/d/1fIM_3HIUZOsBkpwbYprbyBK-96NVY0rv=w1000?authuser=0" height="200" alt="Welcome Page"></figure>


### Test Setup/Run
Navigate to perticular test case file directory and run `flutter test file_name.dart`
for instance `flutter test detail_page_test.dart` This will runs all test cases in a perticular file.

## Fonts and Theme

Used Roboto font to provide styling to texts with all theme required information in `/lib/core/theme/theme.dart`

## Enhancements or Additions with more time

- [ ] User customised watchlist.

- [ ] Price trigger or alert if stock reached perticular price.

- [ ] Candlestick chart for stocks, crypto etc.

## App builds

- **Android** - [app_release.apk](https://drive.google.com/file/d/1Tv0JWALvyE6Tlz4tzDmKyturjK4p04qx/view?usp=sharing)
- **iOS** - if required I can provide but need apple device ids for iPhones.


## App Screenshots
|Light Mode| Dark Mode |
|--|--|
|<figure><figcaption>Home Page</figcaption><br> <img src="https://lh3.googleusercontent.com/d/1-92EqkN49-wxfOn3M0p8JYXh2Ojw3x-q=w1000?authuser=0" width="200" alt="Welcome Page"></figure>  |<figure><figcaption>Home Page</figcaption><br> <img src="https://lh3.googleusercontent.com/d/1KsVe8x-WFPwt73l63VBEKr-gb9LNK3HI=w1000?authuser=0" width="200" alt="Welcome Page"></figure> 
|<figure><figcaption>Company Profile Page</figcaption> <br><img src="https://lh3.googleusercontent.com/d/16dL7E1kBe4uF6EvsequnDydUtqel3IV1=w1000?authuser=0" width="200" alt="Welcome Page"></figure> |<figure><figcaption>Company Profile Page</figcaption><br> <img src="https://lh3.googleusercontent.com/d/1wfuKyfRciwpeyoxkjuz6TQLMovFEJBA8=w1000?authuser=0" width="200" alt="Welcome Page"></figure>|  
|<figure><figcaption>Search Page</figcaption><br> <img src="https://lh3.googleusercontent.com/d/12njjN-DHs22yKJpiMFCBNawP6ThDPcEX=w1000?authuser=0" width="200" alt="Welcome Page"></figure>|<figure><figcaption>Search Page</figcaption><br> <img src="https://lh3.googleusercontent.com/d/1gh8q7WXMmyzo3_bu7Lc6GIbtSeM2UyTt=w1000?authuser=0" width="200" alt="Welcome Page"></figure>|
|<figure><figcaption>Company profile not found</figcaption> <br><img src="https://lh3.googleusercontent.com/d/1pPb70R1mI6BMoMX49F_ercYiaiNUURou=w1000?authuser=0" width="200" alt="Welcome Page"></figure>  | <figure><figcaption>Company profile not found</figcaption><br> <img src="https://lh3.googleusercontent.com/d/15g_C_o7bQuwc-P0hBfJt8fCT9ggoPTIw=w1000?authuser=0" width="200" alt="Welcome Page"></figure>  |<figure><figcaption>Company profile not found</figcaption> <img src="https://lh3.googleusercontent.com/d/1pPb70R1mI6BMoMX49F_ercYiaiNUURou=w1000?authuser=0" width="200" alt="Welcome Page"></figure>  | <figure><figcaption>Company profile not found</figcaption><br> <img src="https://lh3.googleusercontent.com/d/15g_C_o7bQuwc-P0hBfJt8fCT9ggoPTIw=w1000?authuser=0" width="200" alt="Welcome Page"></figure>  
|<figure><figcaption>Detail page only for stock</figcaption><br> <img src="https://lh3.googleusercontent.com/d/1cv9OxqBtDI5U4b16AsDgE1aiNcqm85Hv=w1000?authuser=0" width="200" alt="Welcome Page"></figure>  | <figure><figcaption>Detail page only for stock</figcaption> <br><img src="https://lh3.googleusercontent.com/d/1kiRx5SgcMrqOS4Fmqi7dS6TPXRjC93QX=w1000?authuser=0" width="200" alt="Welcome Page"></figure>  |

