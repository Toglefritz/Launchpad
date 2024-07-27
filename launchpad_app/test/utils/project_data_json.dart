import 'package:flutter/cupertino.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';

/// A JSON object representing a project with all possible fields.
@visibleForTesting
final JSONObject projectDataJson = {
  '@context': 'https://schema.org',
  '@type': 'HowTo',
  'name': 'How to Scientifically Measure the Airspeed Velocity of an Unladen Swallow',
  'description':
  'A comprehensive guide to scientifically measure the airspeed velocity of an unladen swallow in a controlled lab environment using precise instruments and methods.',
  'step': [
    {
      '@type': 'HowToStep',
      'name': 'Prepare the Lab Environment',
      'description': 'Set up the lab with the necessary equipment and safety measures.',
      'itemListElement': [
        {
          '@type': 'HowToDirection',
          'text': 'Ensure the lab is equipped with adequate lighting and space for the experiment.',
        },
        {
          '@type': 'HowToDirection',
          'text': 'Set up safety barriers and equipment to protect the swallow and the researchers.',
        }
      ],
      'tool': [
        {
          '@type': 'HowToTool',
          'name': 'Lab Space',
        },
        {
          '@type': 'HowToTool',
          'name': 'Safety Barriers',
        }
      ],
    },
    {
      '@type': 'HowToStep',
      'name': 'Gather Necessary Equipment',
      'description': 'Collect all tools and equipment needed for the experiment.',
      'itemListElement': [
        {
          '@type': 'HowToDirection',
          'text': "Gather high-speed cameras for capturing the swallow's flight.",
        },
        {
          '@type': 'HowToDirection',
          'text': "Prepare a wind tunnel or large enclosed space to measure the swallow's flight.",
        }
      ],
      'tool': [
        {
          '@type': 'HowToTool',
          'name': 'High-Speed Camera',
        },
        {
          '@type': 'HowToTool',
          'name': 'Wind Tunnel',
        }
      ],
    },
    {
      '@type': 'HowToStep',
      'name': 'Calibrate Instruments',
      'description': 'Ensure all instruments are properly calibrated for accurate measurements.',
      'itemListElement': [
        {
          '@type': 'HowToDirection',
          'text': "Calibrate the high-speed cameras to accurately capture the swallow's speed.",
        },
        {
          '@type': 'HowToDirection',
          'text': 'Calibrate the wind tunnel to simulate natural flight conditions.',
        }
      ],
      'tool': [
        {
          '@type': 'HowToTool',
          'name': 'Calibration Equipment',
        }
      ],
    },
    {
      '@type': 'HowToStep',
      'name': 'Conduct the Experiment',
      'description': 'Perform the experiment to measure the airspeed velocity of the swallow.',
      'itemListElement': [
        {
          '@type': 'HowToDirection',
          'text': 'Release the swallow in the wind tunnel and start recording.',
        },
        {
          '@type': 'HowToDirection',
          'text': "Monitor the swallow's flight and ensure all data is being captured accurately.",
        }
      ],
      'tool': [
        {
          '@type': 'HowToTool',
          'name': 'Data Recording Software',
        }
      ],
    },
    {
      '@type': 'HowToStep',
      'name': 'Analyze the Data',
      'description': 'Analyze the collected data to determine the airspeed velocity.',
      'itemListElement': [
        {
          '@type': 'HowToDirection',
          'text': "Use motion analysis software to calculate the swallow's speed from the high-speed footage.",
        },
        {
          '@type': 'HowToDirection',
          'text': 'Compare the results with known values and ensure accuracy.',
        }
      ],
      'tool': [
        {
          '@type': 'HowToTool',
          'name': 'Motion Analysis Software',
        }
      ],
    }
  ],
  'tool': [
    {
      '@type': 'HowToTool',
      'name': 'High-Speed Camera',
    },
    {
      '@type': 'HowToTool',
      'name': 'Wind Tunnel',
    },
    {
      '@type': 'HowToTool',
      'name': 'Calibration Equipment',
    },
    {
      '@type': 'HowToTool',
      'name': 'Data Recording Software',
    },
    {
      '@type': 'HowToTool',
      'name': 'Motion Analysis Software',
    }
  ],
  'supply': [
    {
      '@type': 'HowToSupply',
      'name': 'Swallow',
    }
  ],
  'tip': [
    {
      '@type': 'HowToTip',
      'text': 'Ensure all equipment is calibrated properly for the most accurate measurements.',
    },
    {
      '@type': 'HowToTip',
      'text': 'Review footage multiple times to ensure consistency in data analysis.',
    }
  ],
  'totalTime': 'PT4H',
  'estimatedCost': {
    '@type': 'MonetaryAmount',
    'currency': 'USD',
    'value': 500,
  },
};
