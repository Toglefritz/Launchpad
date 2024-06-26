# Gadgetron :robot:

Gadgetron is your ultimate companion for diving into the exciting world of electronics, robotics, IoT, 3D printing, and more! Whether you’re a seasoned maker or just starting out, Gadgetron is here to streamline your project development, from the initial idea to ~~letting the blue smoke out~~ releasing a product to great commercial success.

## What is Gadgetron?

Getting started on a new project can be at once exciting and intimidating. You have a great idea, but where do you start? What components do you need? How do you put it all together? How do magnets work?

Gadgetron is a tool for Makers who are eager to dive into their projects and start building without
delay. It is a tool for getting over whatever the equivalent of "writer's block" is for electrical
engineers. Simply describe the project you’re working on, and Gadgetron will:

- **Recommend Key Components**: Discover the best development boards, sensors, breakout PCBs, power sources, and other essential elements for your project.
- **Provide Connection Guidance**: Understand how all these components connect and interact, so you can get started without getting bogged down in research.
- **Offer Learning Resources**: Access a treasure trove of tutorials, product recommendations, and guides that make learning new skills and concepts a breeze.

When you’re ready to build, Gadgetron’s job isn’t done! You can capture images of your breadboard,
parts collection, or prototype build, and Gadgetron will provide feedback and troubleshooting
assistance.

## Features

### Project Scoping and Recommendations

- **Describe Your Project**: Enter details about what you’re trying to build, and let Gadgetron work its magic.
- **Component Recommendations**: Get suggestions for development boards, sensors, power sources, and more.
- **Connection Guidance**: Learn how to connect all the components together seamlessly.

### Learning and Resources

- **Learning Resources**: Access tutorials, product recommendations, and more to expand your knowledge.
- **Community and Support**: Join our community of makers and get support from fellow enthusiasts.

### Build Assistance

- **Image Capture and Feedback**: Snap a photo of your setup and get instant feedback and troubleshooting tips.
- **Step-by-Step Instructions**: Follow detailed guides to assemble and test your project.

## Feedback and Support

Your feedback is invaluable! If you have any questions, suggestions, or need help, reach out or submit an issue on the GitHub repository.

## Repository Structure

This repository contains all the resources for the Gadgetron project. Here’s a quick overview:

```txt
Gadgetron/
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
│
├── demo/
│   ├── videos/
│   │   ├── introduction.mp4
│   │   ├── setup_guide.mp4
│   │   └── feature_walkthrough.mp4
│   ├── screenshots/
│   └── README.md
|
├── githooks/
│   ├── pre-commit
│   ├── pre-push
|
├── scripts/
│   └── README.md
│
|── setup-hooks.sh
└── README.md
```

### flutter_app/

Contains the source code for the Gadgetron Flutter app. This is a cross platform app designed to run on a wide
variety of platforms.

### docs/

Houses all documentation files, including API documentation, user guides, and architectural overviews.

### demo/

Includes demonstration materials such as videos and screenshots to help you understand and use Gadgetron effectively.

### githooks/

Includes Git hooks that help maintain high code quality and prevent accidental API key leaks.

### scripts/

Contains scripts for deployment, testing, and other automation tasks.

## License

Gadgetron is released under the MIT License. See the LICENSE file for more details.

## Git Hooks

Git hooks are custom scripts that are triggered by various Git actions such as commits, merges, and more. They allow you to automate tasks, enforce policies, and improve the overall workflow of a project. In this repository, Git hooks are used to ensure code quality and security before changes are committed.

### Hooks in This Project

- **Pre-commit hook**: The hook uses Gitleaks to scan for potential API key leaks and other sensitive information in your code. This helps prevent accidental exposure of sensitive data.
- **Pre-push hook**: The hook runs the `flutter analyze` command to check your Flutter code for potential issues. This ensures that only clean, well-formed code is committed to the repository. The hook also uses Gitleaks to scan for potential API key leaks and other sensitive information in your code. This helps prevent accidental exposure of sensitive data.

### How to Set Up Git Hooks

To ensure that the Git hooks are correctly set up in your local repository, follow these steps after cloning the project:

1. Clone the Repository:

```bash
git clone https://github.com/Toglefritz/Gadgetron
```

2. Run the setup-hooks.sh script to install the hooks:

```bash
chmod +x setup-hooks.sh
./setup-hooks.sh
```

This script will copy the hooks from the githooks/ directory to the .git/hooks directory, making them active in your local repository.

## Disclaimer

In the creation of this app, artificial intelligence (AI) tools have been utilized. These tools  have assisted in various stages of the plugin's development, from initial code generation to the optimization of algorithms.

It is emphasized that the contributions of these tools have been thoroughly overseen. Each segment of AI-assisted code has undergone meticulous scrutiny to ensure adherence to high standards of quality, reliability, and performance. This scrutiny was conducted by the sole developer responsible for the app's creation.

Rigorous testing has been applied to all AI-suggested outputs, encompassing a wide array of conditions and use cases. Modifications have been implemented where necessary, ensuring that the AI's contributions are well-suited to the specific requirements and limitations inherent in the project.

Commitment to the plugin's accuracy and functionality is paramount, and feedback or issue reports from users are invited to facilitate continuous improvement.

It is to be understood that this plugin, like all software, is subject to evolution over time. The developer is dedicated to its progressive refinement and is actively working to surpass the expectations of the community.