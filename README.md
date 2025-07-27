# WeatherWise News App

WeatherWise News App is a Flutter-based mobile application that combines **real-time weather updates** with **latest news headlines**. It is designed to provide users with a seamless experience of accessing weather conditions and curated news content in a single app.

---

## **Features**

### **1. Weather Module**
- Displays **real-time weather data** using OpenWeather API.
- Shows **temperature, weather conditions, and icons** based on the selected unit (Celsius/Fahrenheit).
- Uses **Lottie animations** for loading weather data and improving UX.

### **2. News Module**
- Fetches **latest news articles** using a news API.
- Allows users to filter between:
  - **All News** (general headlines).
  - **Weather-based News** (news filtered based on current weather conditions).
- Infinite scrolling for fetching more articles.
- Opens the **full article link** in the default browser using `url_launcher`.

### **3. User Preferences**
- **SharedPreferences Integration**:
  - Stores the user’s preferred temperature unit (Celsius/Fahrenheit).
  - Saves **selected news categories** (up to 5) for personalized news feeds.
- **Persistent settings** across app restarts.

### **4. UI & UX**
- Clean and modern **UI built with GetX (State Management)**.
- **ChoiceChip filters** for selecting news categories.
- **Lottie animations** for loading states.
- Dark-themed gradient background with smooth transitions.

---

## **Technologies & Packages**

The app is built using **Flutter** and includes the following key packages:

| Package              | Usage |
|----------------------|-------|
| **get**              | State management and dependency injection. |
| **shared_preferences** | Local storage for user settings. |
| **lottie**           | For loading animations. |
| **url_launcher**     | To open external links in the browser. |
| **http**             | API calls for weather and news data. |

---

## **Architecture**

- **State Management**: [GetX](https://pub.dev/packages/get) is used for controllers, observables (`Rx`), and navigation.
- **Modular Structure**:
  - `modules/home`: Contains the weather and news features.
  - `core/utils`: Helper utilities and extensions.
  - `core/constants`: Colors, images, and styling constants.
- **Controller Layer**:
  - `HomeController` handles both weather and news data fetching.
  - `SettingsController` manages user preferences.
- **Data Layer**:
  - `data/models`: Defines models for weather and news APIs.

---

## **Key Screens**

1. **Home Screen**  
   - Displays weather updates and news feed.
   - Includes filter chips (All News / Weather News).

2. **Settings Screen**  
   - Lets the user select units (Celsius/Fahrenheit).
   - Allows category selection for news personalization.

---

## **How to Run**

1. Clone the repository:
   ```bash
   https://github.com/RENEEV18/WeatherWise-News-App.git

