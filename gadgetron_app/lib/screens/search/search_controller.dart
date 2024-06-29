import 'package:flutter/material.dart';

import 'package:gadgetron_app/screens/search/search_route.dart';
import 'package:gadgetron_app/screens/search/search_view.dart';

/// A controller for the [ProjectSearchRoute] widget.
class ProjectSearchController extends State<ProjectSearchRoute> {
  /// A controller for the text input field used by users to describe their project as a method of searching.
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) => ProjectSearchView(this);
}
