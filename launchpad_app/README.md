# Launchpad Flutter App :rocket:

![Launchpad app icon](assets/app_icon.png)

[![License: MIT][license_badge]][license_badge_link]
[![style: very good analysis][badge]][badge_link]

Welcome to the Launchpad Flutter App! This is the core component of the Launchpad project,
an innovative learning app designed to propel your skill acquisition through hands-on projects.
There is no better way to learn than by doing, and the Launchpad app is here to help people do just
that. Whether you’re a student, a professional looking to upskill, or simply a lifelong learner,
Launchpad offers a platform to transform your curiosity into tangible skills.

## Introduction :wave:

By completing projects with Launchpad, you not only acquire new skills but also build a portfolio of
finished projects that demonstrate your mastery. Building a project can be difficult and often
intimidating, but learners with the grit to take on these challenges will come out the other side
having gained real, valuable, and demonstrable skills. Whether you’re a student, a professional
looking to upskill, or a lifelong learner, Launchpad transforms your curiosity into tangible,
demonstrable expertise through the power of hands-on projects.

## Features :goat:

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
git clone https://github.com/Toglefritz/Launchpad
cd launchpad/launchpad_app
```

2. Run the setup-hooks.sh script to install the hooks:

```bash
chmod +x setup-hooks.sh
./setup-hooks.sh
```

3. Install dependencies:

```bash
cd launchpad_app
flutter pub get
flutter gen-l10n
```

### Running the App

1. Run on an emulator or connected device:

```bash
flutter run
```

## Style Description

The Launchpad mobile app features a minimalist and modern design, optimized for both aesthetics and
functionality, as well as accessibility. Below is a detailed description of the design style,
highlighting the key elements that define the app’s visual and interactive experience.

### Design Elements

- **Near-White Background**: The app employs a near-white background, which enhances brightness and provides a clean, sterile visual experience. This choice creates a neutral canvas that allows content to stand out and reduces visual clutter.
- **Clean and Simple Layout**: Emphasizing simplicity, the layout incorporates clean lines and ample white space. This approach ensures an uncluttered interface, improving usability and focus on content.
- **Rounded Corners**: Consistent use of rounded corners for UI elements such as buttons, cards, and containers adds to the modern aesthetic. This design choice softens the interface, making it more inviting and user-friendly.
- **Neumorphism Elements**: Subtle shadows and highlights are applied to create a neumorphic effect, giving elements a slightly raised or inset appearance. This tactile feel adds depth to the design while maintaining a soft and approachable look.
- **Monospace Typography**: The app utilizes a monospace font family, which introduces a distinctive, modern look. This typeface adds a tech-savvy or coding-related vibe to the design, aligning with the app’s innovative and forward-thinking ethos.
- **Consistent Iconography**: Simple and consistent icons are used throughout the app, ensuring clarity and coherence. The icon design complements the overall minimalist theme, aiding in intuitive navigation and interaction.

### Design Principles

- **Minimalist Design**: Adopting a “less is more” philosophy, the app’s design minimizes unnecessary elements, focusing on essential functionality and aesthetic appeal.
- **Modern UI**: The use of modern design techniques, such as neumorphism and rounded corners, positions the app at the forefront of current design trends.
- **Bright and Neutral Palette**: The near-white background combined with subtle color accents enhances readability and visual comfort.
- **Tech-Savvy Aesthetic**: The monospace typography reinforces the app’s alignment with technology and innovation, appealing to users who value modern, tech-oriented design.

By incorporating these design elements and principles, the Launchpad mobile app delivers a visually
appealing and highly functional user experience. This thoughtful design approach ensures that users
can easily navigate and interact with the app, while also appreciating its modern and minimalist
aesthetic.

## Experimentation with Firebase Remote Config :test_tube:

The Launchpad app leverages Firebase Remote Config to enable dynamic experimentation with various
aspects of our AI-powered prompting strategy. AI systems, especially those involving generative
models, are a blend of science and art. Fine-tuning these models involves both empirical testing
and creative adjustments to ensure they provide the most effective and engaging user experience.
By using Firebase Remote Config, A/B(/C) testing can be performed with different variations of
system instructions, few-shot examples, personas, reasoning steps, recap statements, and other
parts of the prompting strategy without needing to deploy new versions of the app.

### Overview

Firebase Remote Config allows configuration parameters to be updated dynamically from the cloud.
This capability is crucial for ongoing experimentation with the AI systems powering Launchpad. The
primary components of our prompting strategy that are subject to experimentation include:

- **System Instructions**: Directives provided to the AI model to guide its responses.
- **Few-Shot Examples**: Sample interactions included in the prompt to set the context for the model.
- **Personas**: Specific characteristics or roles assigned to the AI to shape its responses.
- **Reasoning Steps**: Instructions for the AI to follow a logical sequence in its reasoning.
- **Recap Statements**: Summarizations included in the responses to enhance clarity and 
        comprehension.

### Implementation

Using Firebase Remote Config, these components can be adjusted and their impact on user
interactions observed. Here’s how it works:

1. **Configuration Setup**: Parameters for different parts of the prompting strategy are set up in
   Firebase Remote Config. For example:
    - system_instructions
    - few_shot_examples
    - persona
    - reasoning_steps
        - recap_statements
2. **Fetching Configurations**: The app fetches these parameters at runtime, ensuring it always uses
   the latest configuration without requiring an update. This is done using Firebase Remote Config’s
   SDK.
3. **Experimentation**: Different configurations (A/B/C variations) are created and deployed to
   different user segments. Firebase’s A/B testing framework allows us to define these variations
   and measure their impact on user engagement and satisfaction.
4. **Analysis and Optimization**: Data collected from these experiments is analyzed to determine
   which configurations yield the best results. Based on these insights, configurations are further
   refined to enhance the AI’s performance.

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

[badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg

[badge_link]: https://pub.dev/packages/very_good_analysis

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg

[license_badge_link]: https://opensource.org/licenses/MIT