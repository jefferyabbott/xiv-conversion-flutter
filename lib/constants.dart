import 'package:flutter/material.dart';

const kNumberDisplayLabel = TextStyle(
  fontFamily: 'Times New Roman',
  backgroundColor: Colors.black,
);

const kButtonTextStyle = TextStyle(
  fontFamily: 'Times New Roman',
  color: Colors.white,
);

const double kButtonPadding = 4.0;

const double kHeightFactor = 0.6;

// presetFontSizes will always try these sizes, in this order:
const fontSizes = [
  100.0,
  90.0,
  80.0,
  70.0,
  60.0,
  50.0,
  40.0,
  30.0,
  20.0,
  15.0,
  14.0,
  13.0,
  12.0,
  11.0,
  10.0
];

// if roman numeral ends like the values in the array, disable the button
const kButtonDisableRules = {
  'I': <String>['III', 'IV', 'IX'],
  'V': <String>['II', 'IV', 'IX', 'V', 'VI', 'VII', 'VIII'],
  'X': <String>['II', 'IV', 'IX', 'V', 'VI', 'XL', 'XC', 'XXX'],
  'L': <String>['I', 'IV', 'IX', 'V', 'XX', 'XC', 'L', 'LX', 'CV'],
  'C': <String>[
    'I',
    'IV',
    'IX',
    'V',
    'XX',
    'XL',
    'XC',
    'L',
    'LX',
    'CV',
    'CCC',
    'CM',
    'D'
  ],
  'D': <String>[
    'I',
    'IV',
    'IX',
    'V',
    'X',
    'XL',
    'XC',
    'L',
    'CV',
    'CC',
    'CM',
    'D',
    'MC'
  ],
  'M': <String>[
    'I',
    'IV',
    'IX',
    'V',
    'X',
    'XL',
    'XC',
    'L',
    'CV',
    'CC',
    'CM',
    'D',
    'MMM'
  ]
};
