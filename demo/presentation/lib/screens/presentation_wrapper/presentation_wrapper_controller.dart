import 'package:flutter/material.dart';
import 'package:presentation/screens/presentation_wrapper/presentation_wrapper_route.dart';
import 'package:presentation/screens/presentation_wrapper/presentation_wrapper_view.dart';

/// A controller for the [PresentationWrapperRoute] widget.
class PresentationWrapperController extends State<PresentationWrapperRoute> {
  @override
  Widget build(BuildContext context) => PresentationWrapperView(this);
}
