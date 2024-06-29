import 'package:flutter/material.dart';
import 'package:gadgetron_app/theme/insets.dart';

/// A route that displays the privacy policy of the app.
class PrivacyPolicyRoute extends StatelessWidget {
  /// Creates an instance of [PrivacyPolicyRoute].
  const PrivacyPolicyRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Insets.medium),
        child: Stack(
          children: [
            const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: Insets.medium),
                    child: Text(
                      'Welcome to Gadgetron! This privacy policy explains how we collect, use, disclose, and safeguard your information when you use our service. Please read this privacy policy carefully. If you do not agree with the terms of this privacy policy, please do not access the service.',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Insets.medium),
                    child: Text(
                      'Information We Collect',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'We may collect information about you in a variety of ways. The information we may collect on the Service includes:',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      '1. **Personal Data**: Personally identifiable information, such as your name, shipping address, email address, and telephone number, and demographic information, such as your age, gender, hometown, and interests, that you voluntarily give to us when you register with the Service or when you choose to participate in various activities related to the Service, such as online chat and message boards.\n'
                      '2. **Derivative Data**: Information our servers automatically collect when you access the Service, such as your IP address, your browser type, your operating system, your access times, and the pages you have viewed directly before and after accessing the Service.\n'
                      '3. **Financial Data**: Financial information, such as data related to your payment method (e.g., valid credit card number, card brand, expiration date) that we may collect when you purchase, order, return, exchange, or request information about our services from the Service.\n'
                      '4. **Mobile Device Data**: Device information, such as your mobile device ID, model, and manufacturer, and information about the location of your device, if you access the Service from a mobile device.',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Insets.medium),
                    child: Text(
                      'Use of Your Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'Having accurate information about you permits us to provide you with a smooth, efficient, and customized experience. Specifically, we may use information collected about you via the Service to:',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      '1. Create and manage your account.\n'
                      '2. Process your transactions and send you related information, including purchase confirmations and invoices.\n'
                      '3. Administer promotions, surveys, and other features of the Service.\n'
                      '4. Improve the Service to better serve you.\n'
                      '5. Send you marketing and promotional communications.\n'
                      '6. Respond to your comments and questions and provide customer service.\n'
                      '7. Communicate with you about products, services, offers, promotions, rewards, and events offered by Gadgetron and others, and provide news and information we think will be of interest to you.\n'
                      '8. Monitor and analyze trends, usage, and activities in connection with our Service.\n'
                      '9. Prevent fraudulent transactions, monitor against theft, and protect against criminal activity.',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Insets.medium),
                    child: Text(
                      'Disclosure of Your Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'We may share information we have collected about you in certain situations. Your information may be disclosed as follows:',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      '1. **By Law or to Protect Rights**: If we believe the release of information about you is necessary to respond to legal process, to investigate or remedy potential violations of our policies, or to protect the rights, property, and safety of others, we may share your information as permitted or required by any applicable law, rule, or regulation.\n'
                      '2. **Third-Party Service Providers**: We may share your information with third parties that perform services for us or on our behalf, including payment processing, data analysis, email delivery, hosting services, customer service, and marketing assistance.\n'
                      '3. **Marketing Communications**: With your consent, or with an opportunity for you to withdraw consent, we may share your information with third parties for marketing purposes, as permitted by law.\n'
                      '4. **Business Transfers**: We may share or transfer your information in connection with, or during negotiations of, any merger, sale of company assets, financing, or acquisition of all or a portion of our business to another company.\n'
                      '5. **Affiliates**: We may share your information with our affiliates, in which case we will require those affiliates to honor this privacy policy. Affiliates include our parent company and any subsidiaries, joint venture partners, or other companies that we control or that are under common control with us.',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Insets.medium),
                    child: Text(
                      'Security of Your Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'We use administrative, technical, and physical security measures to help protect your personal information. While we have taken reasonable steps to secure the personal information you provide to us, please be aware that despite our efforts, no security measures are perfect or impenetrable, and no method of data transmission can be guaranteed against any interception or other type of misuse.',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Insets.medium),
                    child: Text(
                      'Policy for Children',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'We do not knowingly solicit information from or market to children under the age of 13. If we learn that we have collected personal information from a child under age 13 without verification of parental consent, we will delete that information as quickly as possible. If you believe we might have any information from or about a child under 13, please contact us at privacy@gadgetron.com.',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Insets.medium),
                    child: Text(
                      'Changes to This Privacy Policy',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'We may update this privacy policy from time to time in order to reflect, for example, changes to our practices or for other operational, legal, or regulatory reasons.',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Insets.medium),
                    child: Text(
                      'Contact Us',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'If you have questions or comments about this Privacy Policy, please contact us at:',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Insets.small),
                    child: Text(
                      'Email: privacy@gadgetron.com\n'
                      'Address: 123 Gadgetron Lane, Innovation City, Tech State, 12345',
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
