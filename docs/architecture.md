# Introduction

The Launchpad project aims to provide an engaging and comprehensive learning experience by guiding users through hands-on projects. To achieve this, the project leverages a combination of cloud-based services and client app technologies, organized into distinct yet interconnected codebases. This document provides an overview of the architectural decisions made for the various components of the Launchpad project, including the Firebase Functions codebase, the Flutter app codebase, and the Firestore database organization.

Each section of this document will explain the architecture of these components, covering the rationale behind key design choices and how they work together to support the overall functionality of the Launchpad platform. This document will offer a high-level understanding of the system’s structure.

## Flutter App Codebase

The Flutter app codebase for the Launchpad project is designed using two main architectural principles: the Model-View-Controller (MVC) architecture for individual screens and a service-oriented architecture for interacting with backend services and shared functionalities. This dual approach provides a clean separation of concerns, facilitating maintainability, scalability, and ease of testing.

### Model-View-Controller (MVC) Architecture

The MVC architecture is implemented for each screen in the application, providing a clear structure that separates the application’s data (Model), user interface (View), and business logic (Controller). The purpose of this architecture is to separate business logic from presentation logic for each screen.

- **Model**: The Model represents the data used for an individual screen in the application. It is responsible for accepting parameters necessary for a particular screen. In the Launchpad app, models correspond to "routes" that extend the `StatefulWidget` widget.
- **View**: The View comprises the user interface components that display the data to the user. It listens for updates from the Controller and reflects changes in the Model. Each screen in the app includes one or more Views, implemented as Flutter widgets, that provide the visual representation of data. These can include form inputs, lists, and interactive elements. The views are "dumb" and purly declarative; they extend the `StatelessWidget` widget.
- **Controller**: The Controller acts as an intermediary between the Model and the View. It handles user input, updates the Model, and refreshes the View accordingly. Controllers in the Launchpad app are responsible for processing user actions, such as form submissions or navigation events, and for orchestrating the interaction between the View and the Model. They are also responsible for coordinating information obtained from the app's services.

Each screen in the Launchpad app adheres to this MVC pattern, ensuring that business logic is decoupled from UI components, which simplifies debugging and enhances testability.

### Service-Oriented Architecture

To handle interactions with backend services and functionalities that span across multiple screens, the Launchpad app employs a service-oriented architecture. This approach involves creating dedicated service classes that encapsulate the logic for interacting with various external and internal services. Services within the Launchpad app are not Flutter widgets, instead, they are Dart classes.

- **Backend Service Interactions**: Service classes are responsible for communication with Firebase services, such as Firestore, Firebase Authentication, and Firebase Functions. For example, a service might handle the retrieval, creation, and update of project data, while an authentication manages user authentication and session management.
- **Cross-Screen Functionalities**: Services are also used for functionalities that need to be accessed from multiple screens or components. This includes services for caching, analytics, and logging.
- **Integration with Controllers**: Controllers leverage these services to perform complex operations, ensuring that the core business logic remains centralized and reusable. By abstracting backend interactions and shared functionalities into services, the app maintains a clean separation of concerns, reducing duplication and making it easier to manage and scale the codebase.

### Conclusion

The combination of MVC and service-oriented architectures in the Launchpad app ensures a modular and well-organized codebase. The MVC pattern provides clarity and separation within individual screens, while the service-oriented architecture enables consistent and efficient handling of backend interactions and cross-screen functionalities.

## Firebase Functions Codebase

The Firebase Functions codebase for the Launchpad project is designed with a modular architecture, promoting a clean separation of concerns and ease of maintenance. This modularity is achieved by defining distinct functions for each endpoint and utilizing middleware to handle common functionalities across multiple endpoints.

### Modular Function Design

For each endpoint provided by the Firebase Functions backend, there is a dedicated function responsible for handling the business logic related to processing requests. This design approach ensures that each function encapsulates a specific piece of functionality, making the codebase easier to understand, test, and maintain.

- **Function Structure**: Each function in the codebase is designed to handle a specific endpoint. For instance, an endpoint for generating images based on a project description might be handled by a function named `generateImage`. This function includes all the necessary logic for processing the request, such as validating input data, interacting with external APIs, and forming the response.

- **index.cjs File**: The *index.cjs* file serves as the main entry point for the Firebase Functions codebase. It defines the available endpoints and maps them to the corresponding functions. This file acts as a central registry for all endpoints, ensuring that the routing of requests is straightforward and easy to manage. By delegating the business logic to specific functions, the *index.cjs* file remains focused on endpoint configuration and routing.

## Middleware

Middleware functions provide reusable functionality that can be applied across multiple REST request endpoints. These middleware functions are designed to handle common tasks, such as authentication, validation, and logging, ensuring consistency and reducing code duplication.

## Firestore Database Structure

The Firestore database for the Launchpad app is structured to support efficient data retrieval and storage, facilitating the app’s functionalities around user management, project tracking, and achievements. This section provides an overview of the database’s organization, detailing the structure of key collections and the data models used within the app.

### Users Collection

For each user who has created an account in the Launchpad app (via Firebase Auth), a file is created in the "users" collection containing information relevant the user's interaction with the app.

```json
{
  "userId": "abc123",
  "profilePicture": "default",
  "joinedDate": "2024-07-25T06:11:00+06:00",
  "email": "email@domain.com",
  "currentProjects": [],
  "completedProjects": [],
  "achievements": []
}
```

- **userId**: A unique identifier for the user, matching the UID provided by Firebase Auth.
- **profilePicture**: A string representing the URL or identifier for the user’s profile picture. The default value indicates that a generic image is used.
- **joinedDate**: The date and time when the user joined the app, stored in ISO 8601 format.
- **email**: The user’s email address.
- **currentProjects**: An array of identifiers corresponding to the user’s ongoing projects.
- **completedProjects**: An array of identifiers corresponding to the projects the user has completed.
- **achievements**: An array of identifiers for achievements the user has earned.

### Projects Collection

The Firestore database includes a collection dedicated to projects, which are represented as JSON objects conforming to the HowTo schema from schema.org. This schema has been extended to include additional fields specific to the Launchpad app, such as a cover image URL.

```json
{
  "@context": "https://schema.org",
  "@type": "HowTo",
  "name": "Build a Simple Birdhouse",
  "description": "A step-by-step guide to building a simple birdhouse.",
  "step": [...],
  "tool": [...],
  "supply": [...],
  "tip": [...],
  "coverImageUrl": "https://example.com/images/birdhouse.jpg",
  "createdBy": "abc123",
  "createdDate": "2024-07-25T06:11:00+06:00"
}
```

- **@context**: Specifies the schema.org context.
- **@type**: Indicates the type of schema used, typically “HowTo”.
- **name**: The name of the project.
- **description**: A brief description of the project.
- **step**: A list of steps required to complete the project, each represented by an object conforming to the HowToStep schema.
- **tool**: A list of tools required for the project.
- **supply**: A list of supplies needed for the project.
- **tip**: A list of tips to assist users in completing the project.
- **coverImageUrl**: A URL pointing to a cover image for the project, providing a visual preview.
- **createdBy**: The userId of the user who created the project.
- **createdDate**: The date and time when the project was created.

### Achievements Collection

The “achievements” collection stores information about various achievements users can earn within the app:

```json
{
  "achievementId": "ach001",
  "name": "First Project Completion",
  "description": "Awarded for completing the first project.",
  "iconUrl": "https://example.com/icons/first_project_completion.png"
}
```

- **achievementId**: A unique identifier for the achievement.
- **name**: The name of the achievement.
- **description**: A brief description of the achievement and the criteria for earning it.
- **iconUrl**: A URL pointing to an icon representing the achievement.