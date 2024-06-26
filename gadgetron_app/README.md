# Gadgetron Flutter App :robot:

Welcome to the Gadgetron Flutter App! This is the core component of the Gadgetron project,
designed to help makers jumpstart their projects in electronics, robotics, IoT, 3D printing, and
more.

## Introduction :wave:

The Gadgetron Flutter App is your personal assistant for scoping out electronics projects,
recommending components, providing learning resources, and offering real-time feedback during the
building process. Say goodbye to “maker’s block” and dive right into your projects with Gadgetron!

## Features :goat:

- **Project Scoping**: Describe your project and get a curated list of components.
- **Component Recommendations**: Discover the best development boards, sensors, and power sources
  for your project.
- **Learning Resources**: Access tutorials, guides, and product recommendations.
- **Build Assistance**: Capture images of your setup for instant feedback and troubleshooting tips.

## Getting Started :rocket:

### Prerequisites

Before you begin, ensure you have met the following requirements:

- Flutter SDK: [Install Flutter](https://docs.flutter.dev/get-started/install)
- A suitable IDE (
  e.g., [Android Studio](https://developer.android.com/studio), [VS Code](https://code.visualstudio.com/))
- An emulator or a physical device for testing

### Installation

1. Clone the repository:

```bash
git clone https://github.com/Toglefritz/Gadgetron
cd gadgetron/flutter_app
```

2. Run the setup-hooks.sh script to install the hooks:

```bash
chmod +x setup-hooks.sh
./setup-hooks.sh
```

3. Install dependencies:

```bash
cd gadgetron_app
flutter pub get
flutter gen-l10n
```

### Running the App

1. Run on an emulator or connected device:

```bash
flutter run
```

## Contributing :raised_hands:

Contributions are welcome! If you have ideas for new features, improvements, or bug fixes, feel free
to submit a pull request or open an issue.

Steps to Contribute

	1.	Fork the repository.
	2.	Create a new branch (git checkout -b feature-name).
	3.	Make your changes.
	4.	Commit your changes (git commit -m 'Add some feature').
	5.	Push to the branch (git push origin feature-name).
	6.	Open a pull request.

## License :page_facing_up:

This project is licensed under the MIT License - see the LICENSE file for details.