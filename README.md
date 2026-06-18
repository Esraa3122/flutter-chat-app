# Mock Chat Application (E Chat) 

A fully functional, offline-first mock chat application built with Flutter. This project demonstrates strict adherence to Clean Architecture principles, reactive state management, and seamless UI/UX, built without a real backend but designed to be API-ready.

## How to Run the Project

1. Ensure you have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
2. Clone this repository.
3. Open a terminal in the project root directory and run:
   ```bash
   flutter pub get
4. Run the app on an emulator or physical device:
    ```bash
    flutter run

(Note: Upon the first launch, the app seeds the local database with mock conversations to allow immediate testing of features like search and chat history).

## Architectural Decisions
I strictly followed Clean Architecture (Presentation, Domain, Data) to ensure the codebase is scalable, testable, and highly maintainable.

The Swappability Factor (Data Layer Structure):
As requested, the app is built with backend-swappability in mind.

The Domain layer defines abstract Repositories and UseCases (e.g., SearchChatsUseCase, SendMessageUseCase).

The Data layer implements these via a LocalDataSource using Hive.

If a real REST API or WebSocket/Firebase is introduced later, we simply create a RemoteDataSourceImpl, inject it into the Repository, and the entire UI and Business Logic will remain 100% untouched.

##  State Management Choice
I chose Cubit (flutter_bloc) for state management.
Reasoning:

Separation of Concerns: It perfectly decouples the UI from the business logic.

Predictability: Emitting distinct states (Loading, Loaded, Error) makes handling UI edge cases straightforward.

Less Boilerplate: Cubit offers the reactive power of Bloc without the overhead of defining events, which is ideal for the straightforward data flow of a chat app while keeping the code clean and readable.

##  Third-Party Packages & Justifications
* **`flutter_bloc`**: For predictable, reactive state management.
* **`hive` & `hive_flutter`**: A lightweight, blazing-fast NoSQL local database used to simulate backend persistence and support offline-first capabilities.
* **`get_it`**: A service locator for Dependency Injection (DI), essential for keeping layers decoupled and swapping data sources easily.
* **`go_router`**: For declarative routing and seamless passing of arguments (like Chat Entities) between screens.
* **`intl`**: For formatting timestamps dynamically (e.g., "Today • 04:05 AM" or converting dates to localized strings).
* **`easy_localization`**: To handle language translation (e.g., "Typing..." / "Yesterday"), ensuring the app is scalable for different locales.
* **`cached_network_image`**: To cache dummy profile pictures efficiently and prevent unnecessary re-downloading.
* **`flutter_screenutil`**: For dynamic UI responsiveness, ensuring text, padding, and widget sizes adapt beautifully across different screen dimensions.
* **`connectivity_plus` & `internet_connection_checker`**: Working together to listen to network state changes and verify active internet access, which triggers the offline message synchronization logic.
* **`swipe_to`**: To provide an intuitive, native-like user experience by allowing users to swipe on chat bubbles to trigger replies.
* **`url_launcher`**: To launch external applications seamlessly for actions like making phone calls, opening email clients, or loading map URLs.
* **`geolocator` & `geocoding`**: Used to fetch the user's current GPS coordinates and handle location-based operations for the map feature.
* **`permission_handler`**: To securely request and manage system permissions (like Location or Contacts) before accessing device hardware.
* **`lottie`**: To render high-quality, lightweight vector animations for empty states (e.g., the empty chat room background).
* **`day_night_themed_switcher`**: Used to provide a smooth, visually appealing animated toggle for switching between Light and Dark themes.
* **`animate_do`**: To implement beautiful, lightweight, and declarative animations (like fade-ins for chat lists) with minimal boilerplate.
* **`flutter_contacts`**: To seamlessly access and handle the device's native contacts, powering the feature to share contact cards within the chat.
* **`flutter_native_splash`**: To configure and generate a seamless, native splash screen for both Android and iOS, providing a polished initial load experience.
* **`flutter_launcher_icons`**: A development tool used to automatically generate app icons for iOS and Android, ensuring consistent branding across devices.

## Notes & Assumptions
Database Seeding: Since no backend is provided, I assumed the reviewer needs immediate data to test the UI. The local database seeds itself with dummy chats and users on the very first run.

Network Simulation: To make the mock feel real, I simulated network latency using Future.delayed.

Auto-Reply & Realism: When the user sends a message, it transitions from sending ⏱️ -> sent ✔️ -> delivered ✔️✔️. After a simulated delay, the mock friend will transition to a "Typing..." state, the message is marked as read (blue ticks), and an auto-reply is generated and saved locally.

## What I Would Improve Given More Time

While the current foundation is solid and meets the core mock requirements, my technical roadmap for scaling this application includes:

1. **Automated Testing:** Implement the comprehensive Unit and Widget tests mentioned in the task requirements to ensure maximum reliability, prevent regressions, and guarantee a bulletproof business logic.
2. **Real Backend Integration:** Swap the mock local data source with a live backend API (e.g., RESTful API, WebSockets, or Firebase), seamlessly plugging it into the existing Clean Architecture Data Layer without altering the UI.
3. **Rich Media Sharing:** Expand the attachment features to support recording/sending voice notes and uploading various file formats (PDFs, documents, etc.).
4. **Chat Management:** Implement delete functionalities, allowing users to unsend/delete specific messages and clear or delete entire conversations.
5. **Group Messaging:** Introduce the ability to create group chats, add participants, and manage basic group info.
6. **Contact Management:** Build a user discovery system to search for people, send friend requests, and seamlessly add new contacts.
7. **Status/Stories Feature:** Add a "Stories" feature, allowing users to share ephemeral 24-hour photo or video updates with their contacts.
8. **Voice Calls:** Integrate VoIP technology (using WebRTC or an SDK like Agora) to enable real-time, seamless voice calling between users.