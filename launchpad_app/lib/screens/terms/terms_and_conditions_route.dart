import 'package:flutter/material.dart';
import 'package:launchpad_app/theme/insets.dart';

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
                      'Welcome to Launchpad! These terms and conditions outline the rules and regulations for the use of Launchpad\'s services. By accessing this service, we assume you accept these terms and conditions in full. Do not continue to use Launchpad\'s services if you do not accept all the terms and conditions stated on this page.',
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
                      'Launchpad is a tool designed to assist people in learning new skills by taking on real projects. The best way to learn something new is to face the challenges involved in creating something real. Launchpad provides a platform for users to describe their projects and receive tailored guides, advice, recommendations, and support.',
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
                      'By using Launchpad, you agree to:\n'
                      '1. Provide accurate and detailed descriptions of your learning goals.\n'
                      '2. Use the provided leaning resources and guided project guidance responsibly.\n'
                      '3. Access and utilize learning resources for educational purposes.\n'
                      '4. Participate in the community respectfully and supportively.\n'
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
                      'Unless otherwise stated, Launchpad and/or its licensors own the intellectual property rights for all material on Launchpad. All intellectual property rights are reserved. You may view and/or print pages from Launchpad for your own personal use subject to restrictions set in these terms and conditions.',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'You must not:\n'
                      '1. Republish material from Launchpad without proper attribution.\n'
                      '2. Sell, rent, or sub-license material from Launchpad.\n'
                      '3. Reproduce, duplicate, or copy material from Launchpad for commercial purposes.\n'
                      '4. Redistribute content from Launchpad, unless the content is specifically made for redistribution.',
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
                      'In these terms and conditions, “your user content” means material (including without limitation text, images, audio material, video material, and audio-visual material) that you submit to Launchpad, for whatever purpose.',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'You grant to Launchpad a worldwide, irrevocable, non-exclusive, royalty-free license to use, reproduce, adapt, publish, translate, and distribute your user content in any existing or future media. You also grant to Launchpad the right to sub-license these rights, and the right to bring an action for infringement.',
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
