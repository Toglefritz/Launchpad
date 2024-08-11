import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:launchpad_app/components/dashed_outlines/dashed_box_border.dart';
import 'package:launchpad_app/theme/insets.dart';
import 'package:presentation/screens/components/slide.dart';

/// A slide that introduces the Launchpad app.
class IntroductionSlide extends StatefulWidget {
  /// Create an instance of the [IntroductionSlide] widget.
  const IntroductionSlide({
    super.key,
  });

  @override
  State<IntroductionSlide> createState() => _IntroductionSlideState();
}

class _IntroductionSlideState extends State<IntroductionSlide> {
  /// A list of records containing text and image file path pairs to be displayed in this slide.
  final List<(String, String)> _records = [
    ('COOK THAI FOOD', 'assets/introduction_images/cook_thai_food_project_cover.png'),
    ('MAKE A WOODEN TABLE', 'assets/introduction_images/make_a_wooden_table_project_cover.png'),
    ('BUILD A ROBOT', 'assets/introduction_images/build_a_robot_project_cover.png'),
    ('CREATE A FLUTTER APP', 'assets/introduction_images/create_a_flutter_app_project_cover.png'),
    ('WRITE A NOVEL', 'assets/introduction_images/write_a_novel_project_cover.png'),
    ('DESIGN A LOGO', 'assets/introduction_images/design_a_logo_project_cover.png'),
    ('PLAY THE GUITAR', 'assets/introduction_images/play_the_guitar_project_cover.png'),
    ('PAINT A LANDSCAPE', 'assets/introduction_images/paint_a_landscape_project_cover.png'),
    ('KNIT A SWEATER', 'assets/introduction_images/kit_a_sweater_project_cover.png'),
    ('WRITE A SONG', 'assets/introduction_images/write_a_song_project_cover.png'),
    ('GROW A GARDEN', 'assets/introduction_images/grow_a_garden_project_cover.png'),
  ];

  /// The index of the current image/text being displayed.
  int _currentIndex = 0;

  /// Called when the animated text widget advances to a new text.
  void _onNext(int index, bool isLast) {
    setState(() {
      _currentIndex = index + 1 < _records.length ? index + 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slide(
      content: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Insets.large,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                'assets/app_icon.png',
                width: 250,
                height: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Insets.large,
              ),
              child: Text(
                'Launchpad',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 72,
                    ),
              ),
            ),
            Text(
              'Gain knowledge and skills with real-world projects.',
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 56.0,
                horizontal: Insets.large,
              ),
              child: SizedBox(
                width: 900,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 325,
                      child: Text(
                        'I want to learn how to',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Container(
                      width: 375,
                      height: Theme.of(context).textTheme.headlineMedium!.fontSize! * 1.5,
                      decoration: const BoxDecoration(
                        border: DashedBoxBorder(),
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: Insets.medium,
                      ),
                      child: Center(
                        child: DefaultTextStyle(
                          style: Theme.of(context).textTheme.headlineMedium!,
                          child: AnimatedTextKit(
                            repeatForever: true,
                            onNext: _onNext,
                            animatedTexts: _records.map((record) => TypewriterAnimatedText(record.$1)).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      launchpadApp: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Image.asset(
          _records[_currentIndex].$2,
          key: ValueKey<String>(_records[_currentIndex].$2),
        ),
      ),
    );
  }
}
