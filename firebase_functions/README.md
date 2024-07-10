# Firebase Functions Infrastructure

This repository contains the serverless backend code that powers various functionalities of the Gadgetron application. By leveraging Firebase Functions, functions are created and deployed to respond to HTTP requests, Firebase Realtime Database events, Firestore events, and more, without managing any server infrastructure.

## Introduction

This codebase is designed to provide a scalable and maintainable backend solution using Firebase Functions. Firebase Functions allow backend code to run in response to events triggered by Firebase features and HTTPS requests. This means that app capabilities can be extended with custom backend logic without the need for server management.

## Firebase Functions Directory Structure

This project organizes its Firebase Functions codebase into a modular and maintainable structure. Each function is encapsulated into its own file, promoting better organization and easier management. Below is an overview of the directory structure and the purpose of each component:

### Directory Structure

```
firebase-functions/
├── functions/
│   ├── config/
│   │   └── firebaseConfig.cjs
│   ├── middleware/
│   │   └── authMiddleware.cjs
│   ├── functions/
│   │   ├── performSearch.cjs
│   ├── index.cjs
│   └── package.json
└── .firebaserc
└── firebase.json
```

### Directory and File Explanations

#### functions/config/firebaseConfig.cjs

- **Purpose**: Initializes and configures the Firebase Admin SDK.
- **Details**: This file sets up the Firebase Admin SDK, which is used for server-side authentication and other administrative tasks.

#### functions/middleware/authMiddleware.cjs

- **Purpose**: Contains middleware functions for request authentication.
- **Details**: This middleware verifies the Firebase ID token from incoming requests to ensure that only authenticated users can access certain functions.

#### functions/functions/performSearch.cjs

- **Purpose**: Performs a search using a Google Programmable Search Engine.
- **Details**: After verifying the authentication of requests, this function forwards a search query to a Google Programmable Search Engine and returns the search results to the client.

#### functions/index.cjs

- **Purpose**: Aggregates all functions for export.
- **Details**: Imports and exports all the individual functions, making them available for deployment.

#### functions/package.json

- **Purpose**: Manages dependencies and scripts for Firebase Functions.
- **Details**: Contains information about the project and lists dependencies required for running the functions. Also includes scripts for common tasks like deployment and logging.

#### .firebaserc

- **Purpose**: Configuration file for Firebase CLI.
- **Details**: Specifies the Firebase project settings, including the default project to use for CLI commands.

#### firebase.json

- **Purpose**: Configuration file for Firebase project.
- **Details**: Defines settings specific to Firebase services, such as functions. Indicates the source directory for the functions code.

## Getting Started

Follow these steps to set up the Firebase Functions codebase and deploy it to Firebase:

### Prerequisites

Before getting started, ensure the following tools are installed:

- Node.js (version 14 or later)
- Firebase CLI (version 9.0.0 or later)

### Step 1: Clone the Repository

Clone the repository to your local machine.

### Step 2: Install Dependencies

Navigate to the *functions/* directory and install the necessary dependencies:

```sh
cd functions
npm install
```

### Step 3: Initialize Firebase Project

If not already done, initialize Firebase in your local project directory. This step links the local project to a Firebase project in the Firebase console.

```sh
firebase login
firebase init
```

During the initialization, select the following options:

1. Functions: Setup Firebase Functions.
2.	Existing Project: Choose an existing Firebase project or create a new one.
3.	JavaScript: Select JavaScript as the language for Firebase Functions.
4.	ESLint: Enable ESLint for code quality and consistency.
5.	Install Dependencies: Choose ‘Yes’ to install dependencies immediately.

### Step 4: Deploy Firebase Functions

Deploy the Firebase Functions to the Firebase project:

```sh
firebase deploy --only functions
```

The Firebase CLI will deploy the functions to the specified Firebase project. Upon successful deployment, the functions will be available and ready to use.

### Step 5: Verify Deployment

Verify that the functions are deployed correctly by visiting the Firebase console:

1.	Go to the Firebase Console.
2.	Select the Firebase project used during the setup.
3.	Navigate to the “Functions” section to see the deployed functions.
