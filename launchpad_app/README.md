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

- **Near-White Background**: The app employs a near-white background, which enhances brightness and
  provides a clean, sterile visual experience. This choice creates a neutral canvas that allows
  content to stand out and reduces visual clutter.
- **Clean and Simple Layout**: Emphasizing simplicity, the layout incorporates clean lines and ample
  white space. This approach ensures an uncluttered interface, improving usability and focus on
  content.
- **Rounded Corners**: Consistent use of rounded corners for UI elements such as buttons, cards, and
  containers adds to the modern aesthetic. This design choice softens the interface, making it more
  inviting and user-friendly.
- **Neumorphism Elements**: Subtle shadows and highlights are applied to create a neumorphic effect,
  giving elements a slightly raised or inset appearance. This tactile feel adds depth to the design
  while maintaining a soft and approachable look.
- **Monospace Typography**: The app utilizes a monospace font family, which introduces a
  distinctive, modern look. This typeface adds a tech-savvy or coding-related vibe to the design,
  aligning with the app’s innovative and forward-thinking ethos.
- **Consistent Iconography**: Simple and consistent icons are used throughout the app, ensuring
  clarity and coherence. The icon design complements the overall minimalist theme, aiding in
  intuitive navigation and interaction.

### Design Principles

- **Minimalist Design**: Adopting a “less is more” philosophy, the app’s design minimizes
  unnecessary elements, focusing on essential functionality and aesthetic appeal.
- **Modern UI**: The use of modern design techniques, such as neumorphism and rounded corners,
  positions the app at the forefront of current design trends.
- **Bright and Neutral Palette**: The near-white background combined with subtle color accents
  enhances readability and visual comfort.
- **Tech-Savvy Aesthetic**: The monospace typography reinforces the app’s alignment with technology
  and innovation, appealing to users who value modern, tech-oriented design.

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
- **Few-Shot Examples**: Sample interactions included in the prompt to set the context for the
  model.
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

## Using the schema.org HowTo Schema to Represent Projects

Launchpad leverages the schema.org HowTo schema to represent projects, ensuring that all project
guides are structured, comprehensive, and follow a standardized format. This approach facilitates
the creation of detailed, actionable project guides that help users learn new skills through
hands-on experience.

### Overview of schema.org HowTo Schema

The schema.org HowTo schema is a structured format for representing instructional content. It
includes various fields to describe the steps, tools, supplies, tips, and other relevant information
required to complete a project. This schema ensures consistency and clarity across all project
guides, making them easy to understand and follow.

### Key Fields in the schema.org HowTo Schema

- @context: Always set to “https://schema.org”.
- @type: Always set to “HowTo”.
- name: The name of the project.
- description: A brief description of the project.
- step: A list of steps required to complete the project, each containing:
    - @type: “HowToStep”.
    - name: The name of the step.
    - itemListElement: A list of directions or sub-steps within the step, each containing:
        - @type: “HowToDirection”.
        - text: Detailed instructions for the sub-step.
- tool: A list of tools needed for the project, each containing:
    - @type: “HowToTool”.
    - name: The name of the tool.
- supply: A list of supplies needed for the project, each containing:
    - @type: “HowToSupply”.
    - name: The name of the supply.
- tip: A list of tips to help users complete the project, each containing:
    - @type: “HowToTip”.
    - text: The tip content.
- totalTime: The estimated total time required to complete the project.

### System Instructions and Prompting Strategy for the Gemini Model

To ensure that the AI system generates JSON documents that comply with the schema.org HowTo schema,
the following system instructions and prompting strategies are employed:

1. System Instructions:

- The AI model is instructed to always generate project guides that conform to the schema.org HowTo
  schema.
- The model is guided to include all necessary fields and follow the correct structure.
- Detailed descriptions and examples are provided to the model to ensure it understands how to
  format the JSON output correctly.

2. Prompting Strategy:

- Initial prompts to the AI model include clear instructions to generate a project guide using the
  schema.org HowTo schema.
- Example prompts include specific details about the project to be generated, such as the project
  name, description, and steps.
- The AI model is prompted to include all relevant fields (steps, tools, supplies, tips, and
  totalTime) in the output.
- Multiple rounds of refinement are used to gather feedback from users and iteratively improve the
  generated guides. Users review the initial output, provide feedback on missing details or
  inaccuracies, and the model is re-prompted to refine the guide.
- The final JSON output is validated against the schema.org HowTo schema to ensure compliance and
  completeness.

## Localization with app_en.arb

Localization is a crucial aspect of ensuring that the Launchpad app can reach a broad audience by
supporting multiple languages. The *app_en.arb* file is used as part of the infrastructure for
localizing the app. This file follows the Application Resource Bundle (ARB) format, which is used by
Flutter to manage and maintain localized strings.

### Structure of app_en.arb

The *app_en.arb* file contains key-value pairs where the key is a unique identifier for the
localized string, and the value is the localized string itself. Additionally, each entry can include
a description to provide context for translators.

Here is an example of a basic value in the *app_en.arb* file:

```json
{
  "welcomeMessage": "Welcome to Launchpad!",
  "@welcomeMessage": {
    "description": "The welcome message displayed on the home screen when the app is first opened."
  }
}
```

In this example:

- `welcomeMessage` is the key used in the code to refer to this localized string.
- "Welcome to Launchpad!" is the localized string in English.
- The `@welcomeMessage` entry includes a description field that provides context to translators
  about where and how this string is used.

### Categorizing Localized Strings

Because Flutter currently has limitations in splitting strings among multiple localization files, it
can be helpful to categorize the keys in the *app_en.arb* file using prefixes. This approach helps
maintain organization and clarity, especially as the number of localized strings grows. For example,
keys for values used as part of prompts sent to Gemini models begin with "prompt."

```json
{
  "promptInitialGuide": "Generate a comprehensive project guide for {projectName}.",
  "@promptInitialGuide": {
    "description": "Initial prompt to generate a project guide for the given project name."
  }
}
```

## Contributing :raised_hands:

Contributions are welcome! If you have ideas for new features, improvements, or bug fixes, feel free
to submit a pull request or open an issue.

Steps to Contribute

1. Fork the repository.
2. Create a new branch (git checkout -b feature-name).
3. Make your changes.
4. Commit your changes (git commit -m 'Add some feature').
5. Push to the branch (git push origin feature-name).
6. Open a pull request.

## License :page_facing_up:

This project is licensed under the MIT License - see the LICENSE file for details.

[badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg

[badge_link]: https://pub.dev/packages/very_good_analysis

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg

[license_badge_link]: https://opensource.org/licenses/MIT