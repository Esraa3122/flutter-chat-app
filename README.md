# Mock Chat Application (Flovoo Technical Task) 💬

A fully functional, offline-first mock chat application built with Flutter. This project demonstrates strict adherence to Clean Architecture principles, reactive state management, and seamless UI/UX, built without a real backend but designed to be API-ready.

## 🚀 How to Run the Project

1. Ensure you have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
2. Clone this repository.
3. Open a terminal in the project root directory and run:
   ```bash
   flutter pub get
Run the app on an emulator or physical device:

Bash
flutter run
(Note: Upon the first launch, the app seeds the local database with mock conversations to allow immediate testing of features like search and chat history).

🏗️ Architectural Decisions
I strictly followed Clean Architecture (Presentation, Domain, Data) to ensure the codebase is scalable, testable, and highly maintainable.

The Swappability Factor (Data Layer Structure):
As requested, the app is built with backend-swappability in mind.

The Domain layer defines abstract Repositories and UseCases (e.g., SearchChatsUseCase, SendMessageUseCase).

The Data layer implements these via a LocalDataSource using Hive.

If a real REST API or WebSocket/Firebase is introduced later, we simply create a RemoteDataSourceImpl, inject it into the Repository, and the entire UI and Business Logic will remain 100% untouched.

🧠 State Management Choice
I chose Cubit (flutter_bloc) for state management.
Reasoning:

Separation of Concerns: It perfectly decouples the UI from the business logic.

Predictability: Emitting distinct states (Loading, Loaded, Error) makes handling UI edge cases straightforward.

Less Boilerplate: Cubit offers the reactive power of Bloc without the overhead of defining events, which is ideal for the straightforward data flow of a chat app while keeping the code clean and readable.

📦 Third-Party Packages & Justifications
flutter_bloc: For predictable, reactive state management.

hive & hive_flutter: A lightweight, blazing-fast NoSQL local database used to simulate backend persistence and support offline-first capabilities.

get_it: A service locator for Dependency Injection (DI), essential for keeping layers decoupled and swapping data sources easily.

go_router: For declarative routing and seamless passing of arguments (like Chat Entities) between screens.

intl: For formatting timestamps dynamically (e.g., "Today • 04:05 AM" or converting dates to localized strings).

easy_localization: To handle language translation (e.g., "Typing..." / "Yesterday"), ensuring the app is scalable for different locales.

cached_network_image: To cache dummy profile pictures efficiently and prevent unnecessary re-downloading.

📌 Notes & Assumptions
Database Seeding: Since no backend is provided, I assumed the reviewer needs immediate data to test the UI. The local database seeds itself with dummy chats and users on the very first run.

Network Simulation: To make the mock feel real, I simulated network latency using Future.delayed.

Auto-Reply & Realism: When the user sends a message, it transitions from sending ⏱️ -> sent ✔️ -> delivered ✔️✔️. After a simulated delay, the mock friend will transition to a "Typing..." state, the message is marked as read (blue ticks), and an auto-reply is generated and saved locally.

🔮 What I Would Improve Given More Time
While the foundation is solid, here is what I would add with more time:

Unit & Widget Testing: Write comprehensive tests for the UseCases, Cubits, and core UI components using mockito and bloc_test.

Pagination: Implement lazy loading/pagination in the ListView to handle rooms with thousands of messages without performance hits.

Real Media Picker: Replace the simulated pending image attachment with image_picker to allow users to select real photos from their gallery/camera.

Animations: Add flutter_animate for smoother transitions when new messages enter the chat bubble list.


***