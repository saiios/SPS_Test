# CocktailBook

CocktailBook is a Swift-based iOS application that provides users with a collection of cocktail recipes, allowing them to filter, favorite, and explore various cocktails. The app supports an interactive UI, seamless navigation, and offline favorite management using UserDefaults.


**Features**

**Cocktail Browsing**: Explore a list of cocktails fetched from a fake API.

**Filtering**: Filter cocktails by categories such as "All", "Alcoholic", and "Non-Alcoholic".

**Favorites Management**: Mark cocktails as favorites and persist them across sessions.

**Detailed View**: View a detailed page for each cocktail with ingredients and preparation time.

**Error Handling**: Handles API unavailability gracefully with retry functionality.

**Loading Indicators**: Displays activity indicators during data loading.


**Project Structure**

**Core Components**


**Models**:

Cocktail: Represents a cocktail with attributes such as name, description, preparation time, and ingredients.

CocktailsAPIError: Custom error type for handling API errors.


**ViewModels**:

ListViewModel: Manages the list of cocktails, filtering logic, and API interactions.

DetailsViewModel: Handles the state and logic for the cocktail details screen.

FavoritesViewModel: Manages favorite cocktails and persists them using UserDefaults.


**Views**:

ListView: Displays the list of cocktails with filter options.

DetailsView: Shows detailed information about a selected cocktail.

CocktailRow: A reusable row view for each cocktail in the list.

LoadingView and ActivityIndicator: Displays loading animations.


**Utilities**:

CocktailFilter: Enum for managing cocktail filtering options.

NavigationBarModifier: Custom modifier for navigation title compatibility with iOS 13.


**API**

FakeCocktailsAPI:
Simulates an API with controlled success and failure states to mimic real-world scenarios.


**Unit Tests and UI Tests**

The project includes unit tests for ViewModels and API interactions and UI tests for critical user flows to ensure quality and reliability.


**Installation**

Clone the repository:

git clone https://github.com/wios8/CocktailBook.git

Open CocktailBook.xcodeproj in Xcode.

Build and run the project using an iOS simulator or a physical device.


**Usage**

Launch the app to view the list of cocktails.

Use the filter picker at the top to switch between different categories.

Tap on a cocktail to view its details.

Mark your favorite cocktails by tapping the heart icon.

Favorites persist even after restarting the app.


**Sample Data**

The project uses a sample.json file bundled within the app to provide mock data for cocktails. Ensure that the sample.json file exists in the main bundle to avoid runtime issues.


**Requirements**

iOS 13.0+

Xcode 14.0+

Swift 5.0+


**Screenshots**

Include relevant screenshots of the app here (e.g., list view, detailed view, loading indicator).


**Testing**

Run unit tests:

Open Xcode.

Navigate to the Test Navigator (⌘ + 6).

Click on the play button next to each test or run all tests.

Run UI tests:

Select the UI test scheme.

Run the tests on a simulator or physical device.

Contributions

Contributions are welcome! Feel free to fork the repository and submit a pull request. Please ensure that your code follows the project structure and is well-tested.


**License**

This project is licensed under the MIT License. See the LICENSE file for details.

Contact

For any questions or suggestions, feel free to reach out via the GitHub repository or create an issue.

**Thank you for exploring CocktailBook! 🍹**
