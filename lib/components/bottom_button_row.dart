import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomButtonRow extends StatelessWidget {
  BottomButtonRow(this.switchKeyboard, this.copyRomanNumeral, {super.key});

  final void Function() switchKeyboard;
  final void Function() copyRomanNumeral;
  double buttonPadding = 12.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(buttonPadding),
            child: ElevatedButton(
              onPressed: () {
                switchKeyboard();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              child: const Icon(
                CupertinoIcons.keyboard,
                color: Colors.white,
                // size: buttonHeight,
              ),
            ),
          ),
        ),
        // CAMERA  BUTTON - PLACEHOLDER FOR FUTURE CAMERA FEATURE
        // Expanded(
        //   child: Padding(
        //     padding: EdgeInsets.all(buttonPadding),
        //     child: ElevatedButton(
        //       onPressed: () {
        //         print('test');
        //       },
        //       style: ButtonStyle(
        //         backgroundColor: MaterialStateProperty.all(Colors.black),
        //       ),
        //       child: const Icon(
        //         CupertinoIcons.camera,
        //         color: Colors.white,
        //         // size: buttonHeight,
        //       ),
        //     ),
        //   ),
        // ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(buttonPadding),
            child: ElevatedButton(
              onPressed: copyRomanNumeral,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              child: const Icon(
                CupertinoIcons.doc_on_clipboard,
                // size: buttonHeight,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
