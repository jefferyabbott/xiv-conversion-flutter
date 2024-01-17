import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiv_conversion/constants.dart';
import 'package:xiv_conversion/services/convert_to_number.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:xiv_conversion/services/convert_to_roman_numeral.dart';
import 'package:xiv_conversion/components/bottom_button_row.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String romanNumeral = ' ';
  int cardinalNumber = 0;
  bool romanNumeralKeyboardIsActive = true;

  void switchKeyboard() {
    setState(() {
      romanNumeralKeyboardIsActive = !romanNumeralKeyboardIsActive;
    });
  }

  OutlinedButton numeralButton(String numeral) {
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
      ),
      onPressed: (() {
        setState(() {
          if (romanNumeral == ' ') {
            romanNumeral = '';
          }
          romanNumeral = '$romanNumeral$numeral';
          cardinalNumber = convertToNumber(romanNumeral);
        });
      }),
      child: FractionallySizedBox(
        heightFactor: kHeightFactor,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(numeral, style: kButtonTextStyle),
        ),
      ),
    );
  }

  OutlinedButton disabledNumeralButton(String numeral) {
    return OutlinedButton(
      onPressed: null,
      child: FractionallySizedBox(
        heightFactor: kHeightFactor,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(numeral, style: kButtonTextStyle),
        ),
      ),
    );
  }

  OutlinedButton disabledActionButton(IconData actionIcon) {
    return OutlinedButton(
      onPressed: null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: FractionallySizedBox(
        heightFactor: kHeightFactor,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Icon(
            actionIcon,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  OutlinedButton numberButton(int number) {
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
      ),
      onPressed: (() {
        if (number == 0 && cardinalNumber == 0) {
          // no action necessary
        } else {
          int newCardinalNumber = int.parse('$cardinalNumber$number');
          if (newCardinalNumber > 3999) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("The largest possible roman numeral is 3999."),
              ),
            );
          } else {
            setState(() {
              cardinalNumber = newCardinalNumber;
              romanNumeral = convertToRoman(cardinalNumber);
            });
          }
        }
      }),
      child: FractionallySizedBox(
        heightFactor: kHeightFactor,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Text('$number', style: kButtonTextStyle),
        ),
      ),
    );
  }

  Expanded displayPanelExpanded(String displayText) {
    return Expanded(
      flex: 2,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
          color: Colors.black,
        ),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Center(
          child: AutoSizeText(
            displayText,
            maxLines: 1,
            style: kNumberDisplayLabel,
            textAlign: TextAlign.center,
            presetFontSizes: fontSizes,
          ),
        ),
      ),
    );
  }

  Expanded numberButtonExpanded(int number) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.all(kButtonPadding),
          child: numberButton(number)),
    );
  }

  Expanded romanNumeralButton(String romanNumeralText, int romanNumeralValue) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(kButtonPadding),
        child: Column(
          children: [
            if (kButtonDisableRules[romanNumeralText]!
                .any((rule) => romanNumeral.endsWith(rule))) ...[
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: disabledNumeralButton(romanNumeralText),
                  ),
                ],
              ))
            ] else ...[
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: numeralButton(romanNumeralText),
                  ),
                ],
              ))
            ],
            if (MediaQuery.of(context).orientation == Orientation.portrait) ...[
              Text('$romanNumeralValue')
            ],
          ],
        ),
      ),
    );
  }

  void copyRomanNumeral() async {
    await Clipboard.setData(ClipboardData(text: romanNumeral));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              displayPanelExpanded(romanNumeral),
              const SizedBox(
                height: 20,
              ),
              displayPanelExpanded(
                  cardinalNumber == 0 ? '' : '$cardinalNumber'),
              const SizedBox(
                height: 20,
              ),
              romanNumeralKeyboardIsActive
                  ? Expanded(
                      flex: 8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                romanNumeralButton('C', 100),
                                romanNumeralButton('D', 500),
                                romanNumeralButton('M', 1000),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                romanNumeralButton('V', 5),
                                romanNumeralButton('X', 10),
                                romanNumeralButton('L', 50),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(kButtonPadding),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // CANCEL button
                                        if (romanNumeral.isEmpty ||
                                            cardinalNumber == 0) ...[
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Expanded(
                                                  child: disabledActionButton(
                                                      CupertinoIcons
                                                          .clear_circled),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.portrait) ...[
                                            const Text(' ')
                                          ],
                                        ] else ...[
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Expanded(
                                                  child: OutlinedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors.blue),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        romanNumeral = ' ';
                                                        cardinalNumber = 0;
                                                      });
                                                    },
                                                    child:
                                                        const FractionallySizedBox(
                                                      heightFactor:
                                                          kHeightFactor,
                                                      child: FittedBox(
                                                        fit: BoxFit.fitHeight,
                                                        child: Icon(
                                                          CupertinoIcons
                                                              .clear_circled,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.portrait) ...[
                                            const Text(' ')
                                          ],
                                        ]
                                      ],
                                    ),
                                  ),
                                ),
                                romanNumeralButton('I', 1),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              kButtonPadding),
                                          child: Column(
                                            children: [
                                              // BACK button,
                                              if (romanNumeral.isEmpty ||
                                                  cardinalNumber == 0) ...[
                                                Expanded(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Expanded(
                                                        child:
                                                            disabledActionButton(
                                                                CupertinoIcons
                                                                    .delete_left),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait) ...[
                                                  const Text(' ')
                                                ],
                                              ] else ...[
                                                Expanded(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Expanded(
                                                        child: OutlinedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .blue),
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              romanNumeral =
                                                                  romanNumeral
                                                                      .substring(
                                                                          0,
                                                                          romanNumeral.length -
                                                                              1);
                                                              cardinalNumber =
                                                                  convertToNumber(
                                                                      romanNumeral);
                                                            });
                                                          },
                                                          child:
                                                              const FractionallySizedBox(
                                                            heightFactor:
                                                                kHeightFactor,
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .fitHeight,
                                                              child: Icon(
                                                                CupertinoIcons
                                                                    .delete_left,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.portrait) ...[
                                                  const Text(' ')
                                                ],
                                              ]
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      flex: 8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                numberButtonExpanded(7),
                                numberButtonExpanded(8),
                                numberButtonExpanded(9),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                numberButtonExpanded(4),
                                numberButtonExpanded(5),
                                numberButtonExpanded(6),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                numberButtonExpanded(1),
                                numberButtonExpanded(2),
                                numberButtonExpanded(3),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(kButtonPadding),
                                    child: romanNumeral.isEmpty ||
                                            cardinalNumber == 0
                                        ? disabledActionButton(
                                            CupertinoIcons.clear_circled)
                                        : OutlinedButton(
                                            onPressed: () {
                                              setState(() {
                                                romanNumeral = ' ';
                                                cardinalNumber = 0;
                                              });
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.blue),
                                            ),
                                            child: const FractionallySizedBox(
                                              heightFactor: kHeightFactor,
                                              child: FittedBox(
                                                fit: BoxFit.fitHeight,
                                                child: Icon(
                                                  CupertinoIcons.clear_circled,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                numberButtonExpanded(0),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(kButtonPadding),
                                    child: romanNumeral.isEmpty ||
                                            cardinalNumber == 0
                                        ? disabledActionButton(
                                            CupertinoIcons.delete_left)
                                        : OutlinedButton(
                                            onPressed: () {
                                              setState(() {
                                                if (cardinalNumber >= 10) {
                                                  cardinalNumber =
                                                      cardinalNumber ~/ 10;
                                                  romanNumeral = convertToRoman(
                                                      cardinalNumber);
                                                } else {
                                                  cardinalNumber = 0;
                                                  romanNumeral = ' ';
                                                }
                                              });
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.blue),
                                            ),
                                            child: const FractionallySizedBox(
                                              heightFactor: kHeightFactor,
                                              child: FittedBox(
                                                fit: BoxFit.fitHeight,
                                                child: Icon(
                                                  CupertinoIcons.delete_left,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              BottomButtonRow(switchKeyboard, copyRomanNumeral),
            ],
          ),
        ),
      ),
    );
  }
}
