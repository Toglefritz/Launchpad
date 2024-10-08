# Launchpad :rocket:

Welcome to Launchpad, the ultimate platform for learning new skills through immersive, real-world projects. Launchpad is designed to help you dive into the exciting world of project-based learning, where the best way to master a new skill is by tackling the challenges that come with creating a tangible project from start to finish.

[![Test on iOS][testflight_badge]][testflight_link]
[![Test on Android][android_test_badge]][android_test_link]

## What is Launchpad?

Learning a new skill effectively requires more than just reading books or watching tutorial videos. Real growth comes from immersing yourself in the challenges of building a real project. By working on a project, you encounter obstacles and solve problems for which theoretical learning alone cannot prepare you.

Building a project from start to finish enforces a kind of honesty in the learning process because it forces you to test your understanding of every part of a skill. There’s no skipping over the difficult parts or glossing over the details. You must confront and resolve every aspect, ensuring a deep and comprehensive mastery of the skill.

Launchpad is here to help you embrace these challenges as critical parts of the learning process. It is crafted for learners who want to gain new skills by diving headfirst into real-world projects. With Launchpad, you will:

- **Create Custom Guided Projects**: Receive personalized, step-by-step instructions tailored to your specific project, ensuring you confront every aspect of the skill you aim to master.
- **Recommend Key Resources**: Discover the best tutorials, articles, and tools to aid you in your learning journey.
- **Offer Real-Time Feedback**: Get instant feedback on your progress, with suggestions and troubleshooting tips to keep you on track.

By completing projects with Launchpad, you not only acquire new skills but also build a portfolio of finished projects that demonstrate your mastery. Whether you’re a student, a professional looking to upskill, or a lifelong learner, Launchpad transforms your curiosity into tangible, demonstrable expertise through the power of hands-on projects.

## Features

- **Personalized Learning Pathways**: Tailored project recommendations based on your interests,
  goals, and skill level.
- **Step-by-Step Guidance**: Detailed instructions, multimedia tutorials, and real-time feedback to
  support you throughout your learning journey.
- **AI-Powered Assistance**: A virtual mentor available 24/7 to provide hints, answer questions, and
  offer encouragement.
- **Community Collaboration**: Join groups, share ideas, and get feedback from peers and experts.
- **Progress Tracking**: Visual indicators and detailed analytics to monitor your progress and
  achievements.
- **Resource Library**: Access a vast collection of articles, videos, and tutorials to supplement
  your learning.
- **Achievements and Rewards**: Earn badges, certificates, and rewards as you complete projects and
  reach milestones.

## Testing the App

You can easily test the Launchpad app without needing to build the project from scratch or set up your own Firebase resources. The app is available for testing on both iOS and Android platforms through TestFlight and Google Play Store’s open beta channel, respectively. Below are the instructions for accessing and testing the app on each platform:

### iOS (TestFlight)

1. Install TestFlight:
  - If you haven’t already, download and install the TestFlight app from the App Store on your iOS device.
2.	Join the Launchpad App Beta via Public Link:
  - Click on the following public TestFlight link to join the beta: [https://testflight.apple.com/join/4xh6A2RQ](https://testflight.apple.com/join/4xh6A2RQ). This link will take you directly to the TestFlight app, where you can opt-in to the beta testing program for the Launchpad app.
3.	Install and Test the App:
  - After joining, the Launchpad app will appear in your TestFlight app under “Available Apps.” Tap “Install” to download the beta version of the app to your device.
  - Once installed, you can open the app and start testing. You can also provide feedback directly within the TestFlight app by taking screenshots or submitting any issues you encounter.

## Android (Google Play Store Open Beta)

1.	Join the Beta Program:
 - Access the Launchpad app’s Google Play Store page via the following link: [https://play.google.com/store/apps/details?id=com.splendidendeavors.launchpad.launchpad_app](https://play.google.com/store/apps/details?id=com.splendidendeavors.launchpad.launchpad_app).
 - Scroll down to the “Join the beta” section and opt-in to the beta testing program.
2.	Install the Beta App:
 - After joining the beta program, the Launchpad app will be available for installation as an update if you already have it installed, or as a new install.
 - Tap “Install” to download the beta version of the app on your Android device.
3.	Start Testing:
 - Once installed, open the Launchpad app from your app drawer and begin testing.
 - Any feedback or issues can be reported through the Google Play Store’s beta feedback feature.

## Feedback and Support

Your feedback is invaluable! If you have any questions, suggestions, or need help, reach out or submit an issue on the GitHub repository.

## Repository Structure

This repository contains all the resources for the Launchpad project. Here’s a quick overview:

```txt
Launchpad/
│
├── flutter_app/
│   ├── lib/
│   ├── test/
│   ├── pubspec.yaml
│   └── README.md
│
├── docs/
│   ├── api/
│   │   ├── overview.md
│   │   └── endpoints.md
│   ├── guides/
│   │   ├── getting_started.md
│   │   ├── installation.md
│   │   ├── usage.md
│   │   └── troubleshooting.md
│   ├── architecture.md
│   └── README.md
|
├── firebase_functions/
│   ├── functions/
│   └── README.md
│
├── demo/
│   ├── video/
│   ├── screenshots/
│   ├── app_icon/
│   └── README.md
|
├── experiments/
|
├── githooks/
│   ├── pre-commit
│   ├── pre-push
│
|── setup-hooks.sh
└── README.md
```

### flutter_app/

Contains the source code for the Launchpad Flutter app. This is a cross platform app designed to run on a wide
variety of platforms.

### docs/

Houses all documentation files, including API documentation, user guides, and architectural overviews.

### cloud_functions/

Contains code for the Firebase Functions backend infrastructed used by this project.

### demo/

Includes demonstration materials such as videos and screenshots to help you understand and use Launchpad effectively.

### experiments/

Tracks investigations into experiments conducted with the goal of improving the performance of the AI systems used by Launchpad.

### githooks/

Includes Git hooks that help maintain high code quality and prevent accidental API key leaks.

## Git Hooks

Git hooks are custom scripts that are triggered by various Git actions such as commits, merges, and more. They allow you to automate tasks, enforce policies, and improve the overall workflow of a project. In this repository, Git hooks are used to ensure code quality and security before changes are committed.

### Hooks in This Project

- **Pre-commit hook**: The hook uses Gitleaks to scan for potential API key leaks and other sensitive information in your code. This helps prevent accidental exposure of sensitive data.
- **Pre-push hook**: The hook runs the `flutter analyze` command to check your Flutter code for potential issues. This ensures that only clean, well-formed code is committed to the repository. The hook also uses Gitleaks to scan for potential API key leaks and other sensitive information in your code. This helps prevent accidental exposure of sensitive data.

### How to Set Up Git Hooks

To ensure that the Git hooks are correctly set up in your local repository, follow these steps after cloning the project:

1. Clone the Repository:

```bash
git https://github.com/Toglefritz/Launchpad
```

2. Run the setup-hooks.sh script to install the hooks:

```bash
chmod +x setup-hooks.sh
./setup-hooks.sh
```

This script will copy the hooks from the githooks/ directory to the .git/hooks directory, making them active in your local repository.

## License

Launchpad is released under the MIT License. See the LICENSE file for more details.

## Disclaimer

In the creation of this app, artificial intelligence (AI) tools have been utilized. These tools  have assisted in various stages of the plugin's development, from initial code generation to the optimization of algorithms.

It is emphasized that the contributions of these tools have been thoroughly overseen. Each segment of AI-assisted code has undergone meticulous scrutiny to ensure adherence to high standards of quality, reliability, and performance. This scrutiny was conducted by the sole developer responsible for the app's creation.

Rigorous testing has been applied to all AI-suggested outputs, encompassing a wide array of conditions and use cases. Modifications have been implemented where necessary, ensuring that the AI's contributions are well-suited to the specific requirements and limitations inherent in the project.

Commitment to the plugin's accuracy and functionality is paramount, and feedback or issue reports from users are invited to facilitate continuous improvement.

It is to be understood that this plugin, like all software, is subject to evolution over time. The developer is dedicated to its progressive refinement and is actively working to surpass the expectations of the community.


[testflight_badge]: https://img.shields.io/badge/Test_on_iOS-TestFlight-blue
[testflight_link]: https://testflight.apple.com/join/4xh6A2RQ

[android_test_badge]: https://img.shields.io/badge/Test_on_Android-Play_Store-green
[android_test_link]: https://play.google.com/store/apps/details?id=com.splendidendeavors.launchpad.launchpad_app