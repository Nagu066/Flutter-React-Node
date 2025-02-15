# Real-Time Token-Based Order System

This project demonstrates a real-time token-based system for order management, with communication between a **Flutter App** (mobile app), **React App** (web app), and a **Node.js backend**. 

### Project Structure

- **Server/**: Node.js backend server with Express and Socket.IO for real-time communication.
- **flutter-app/**: Flutter app for mobile users to log in, submit orders, and manage tokens.
- **react-app/**: React app to process orders and display real-time updates.
- **README.md**: This file with instructions to run the project.

---

## Prerequisites

- Node.js (LTS version)
- Flutter SDK (latest stable version)
- npm (Node Package Manager)
- Any IDE (Visual Studio Code, IntelliJ, etc.)

---

## Setup Instructions

### 1. **Backend (Server)**

The backend is built with **Node.js** and **Express**. It handles the login, order submission, token validation, and real-time order updates using **Socket.IO**.

#### Steps to Set Up the Server:
1. Navigate to the `Server/` folder:
   ```
   cd Server
Install the required dependencies:



npm install
Start the server:



node server.js
The server will run on http://localhost:5000. It handles the following endpoints:
POST /login: For login and token generation.
POST /validate-token: For token validation.
POST /order: For submitting orders.
Real-time updates via Socket.IO.
2. Flutter App
The Flutter App allows users to log in, store tokens securely, and submit orders.

Steps to Set Up the Flutter App:
Navigate to the flutter-app/ folder:



cd flutter-app
Install Flutter dependencies:



flutter pub get
Run the Flutter app:



flutter run
The app will prompt for a username and password. The valid credentials are:
Username: test
Password: password123
After logging in, the user can submit orders.
3. React App
The React App allows users to view real-time orders submitted from the Flutter app. It connects to the backend using Socket.IO for real-time communication.

Steps to Set Up the React App:
Navigate to the react-app/ folder:



cd react-app
Install the required dependencies:



npm install
Start the React app:



npm start
The app will run on http://localhost:3000 and will display incoming orders in real-time.
Key Features
Login System: Users log in using pre-defined credentials and receive a JWT token for session management.
Token Management: The token is securely stored in the Flutter app using flutter_secure_storage and validated before sending any orders.
Order Management: Users can submit orders via the Flutter app. The orders are displayed in real-time on the React app using Socket.IO.
Real-Time Communication: WebSockets (via Socket.IO) ensure that both Flutter and React apps receive real-time updates when new orders are submitted.
Error Handling
Invalid or expired tokens will trigger an error message on both the Flutter and React apps.
Invalid order data will be rejected by the backend and shown as an error in both apps.
Demo
In this demo:

Login in the Flutter app using the provided credentials.
Submit orders from the Flutter app.
View real-time updates in the React app as new orders are submitted.
Test error handling by using an invalid token or submitting invalid data.
Conclusion
This project demonstrates a simple but effective real-time order management system with token-based authentication and communication between a mobile Flutter app, a web React app, and a Node.js backend.

License
This project is licensed under the MIT License - see the LICENSE file for details.


---

### Key Sections in the README:

1. **Project Overview**: A brief description of the project, including the structure and technologies used.
2. **Setup Instructions**: Clear steps for setting up the **backend**, **Flutter app**, and **React app**. 
3. **Key Features**: Describes the main features and what each app does (Flutter for login and order submission, React for real-time updates).
4. **Error Handling**: Mention how the system handles token errors and invalid orders.
5. **Demo**: Brief instructions to demonstrate the features.
6. **License**: You can adjust the licensing section if needed.

---

This README file should guide users through the process of setting up and running the project. Let me know if you'd like any further customizations!









