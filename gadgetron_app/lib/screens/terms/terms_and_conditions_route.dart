import 'package:flutter/material.dart';
import 'package:gadgetron_app/theme/insets.dart';

/// A route that displays the terms and conditions of the app.
class TermsAndConditionsRoute extends StatelessWidget {
  /// Creates an instance of the [TermsAndConditionsRoute] widget.
  const TermsAndConditionsRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Insets.medium),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Terms and Conditions',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.medium),
                    child: Text(
                      'Welcome to Gadgetron! These terms and conditions outline the rules and regulations for the use of Gadgetron\'s services. By accessing this service, we assume you accept these terms and conditions in full. Do not continue to use Gadgetron\'s services if you do not accept all the terms and conditions stated on this page.',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.medium),
                    child: Text(
                      'Introduction',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'Gadgetron is a tool designed to assist Makers in starting their projects efficiently and effectively. Whether you\'re a seasoned professional or just starting out, Gadgetron aims to eliminate the initial hurdles by providing recommendations, connection guidance, learning resources, and troubleshooting assistance for your electronics, robotics, IoT, and 3D printing projects.',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.medium),
                    child: Text(
                      'Services Provided',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'Project Scoping and Recommendations',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      '1. Describe Your Project: Users can enter details about their project to receive tailored advice.\n'
                      '2. Component Recommendations: Gadgetron will suggest appropriate development boards, sensors, power sources, and other components based on the project description.\n'
                      '3. Connection Guidance: Users will receive information on how to connect these components seamlessly.',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'Learning and Resources',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      '1. Learning Resources: Access a variety of tutorials, product recommendations, and guides.\n'
                      '2. Community and Support: Users can join a community of like-minded makers to receive and provide support.',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'Build Assistance',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      '1. Image Capture and Feedback: Users can upload images of their setups to get feedback and troubleshooting tips.\n'
                      '2. Step-by-Step Instructions: Detailed guides will be provided to help users assemble and test their projects.',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.medium),
                    child: Text(
                      'User Responsibilities',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'By using Gadgetron, you agree to:\n'
                      '1. Provide accurate and detailed descriptions of your projects.\n'
                      '2. Use the component recommendations and connection guidance responsibly.\n'
                      '3. Access and utilize learning resources for educational purposes.\n'
                      '4. Participate in the community respectfully and supportively.\n'
                      '5. Use the image capture and feedback feature to enhance your learning and project development.',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.medium),
                    child: Text(
                      'Intellectual Property Rights',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'Unless otherwise stated, Gadgetron and/or its licensors own the intellectual property rights for all material on Gadgetron. All intellectual property rights are reserved. You may view and/or print pages from Gadgetron for your own personal use subject to restrictions set in these terms and conditions.',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'You must not:\n'
                      '1. Republish material from Gadgetron without proper attribution.\n'
                      '2. Sell, rent, or sub-license material from Gadgetron.\n'
                      '3. Reproduce, duplicate, or copy material from Gadgetron for commercial purposes.\n'
                      '4. Redistribute content from Gadgetron, unless the content is specifically made for redistribution.',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.medium),
                    child: Text(
                      'User Content',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'In these terms and conditions, “your user content” means material (including without limitation text, images, audio material, video material, and audio-visual material) that you submit to Gadgetron, for whatever purpose.',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'You grant to Gadgetron a worldwide, irrevocable, non-exclusive, royalty-free license to use, reproduce, adapt, publish, translate, and distribute your user content in any existing or future media. You also grant to Gadgetron the right to sub-license these rights, and the right to bring an action for infringement.',
                    ),
                  ),
                ],
              ),
            ),
            Align(
              child: IgnorePointer(
                child: Transform.rotate(
                  angle: -0.785398, // 45 degrees in radians
                  child: Text(
                    'DRAFT',
                    style: TextStyle(
                      fontSize: 100,
                      color: Colors.grey.withOpacity(0.3),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
