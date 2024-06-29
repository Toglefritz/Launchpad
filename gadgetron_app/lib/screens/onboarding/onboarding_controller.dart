import 'package:flutter/material.dart';
import 'package:gadgetron_app/screens/onboarding/onboarding_route.dart';
import 'package:gadgetron_app/screens/onboarding/onboarding_view.dart';

/// A controller for the [OnboardingRoute] widget.
class OnboardingController extends State<OnboardingRoute> {
  @override
  Widget build(BuildContext context) => OnboardingView(this);
}
