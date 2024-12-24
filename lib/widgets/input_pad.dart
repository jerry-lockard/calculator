import 'package:flutter/material.dart';
import 'package:calculator/models/input_type.dart';
import 'package:calculator/screens/calculator_screen.dart';
import 'package:calculator/widgets/input_button.dart';

const _inputPadOrder = [
  InputType.clear,
  InputType.delete,
  InputType.percent,
  InputType.division,
  InputType.number7,
  InputType.number8,
  InputType.number9,
  InputType.multiplication,
  InputType.number4,
  InputType.number5,
  InputType.number6,
  InputType.subtraction,
  InputType.number1,
  InputType.number2,
  InputType.number3,
  InputType.addition,
  InputType.number0,
  InputType.point,
  InputType.equality,
];

class InputPad extends StatelessWidget {
  const InputPad({super.key});

  @override

  /// Builds the input pad widget.
  ///
  /// The input pad widget displays the number and operator buttons in a
  /// responsive grid layout. The size of the buttons and the spacing between
  /// them are calculated based on the width of the screen.
  ///
  /// The [InputType.number0] button is double the width of the other buttons to
  /// make it easier to press on smaller screens.
  ///
  /// The widget is wrapped in a [Wrap] widget to make it responsive to different
  /// screen sizes and orientations.
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 2 * kSidePadding;
    var buttonsSize = width / 4 * 0.9;
    var buttonSpace = (width - buttonsSize * 4) / 3;

    return Wrap(
      spacing: buttonSpace,
      runSpacing: buttonSpace,
      children: _inputPadOrder
          .map(
            (e) => InputButton(
              inputType: e,
              size: e == InputType.number0
                  ? Size(buttonsSize * 2 + buttonSpace, buttonsSize)
                  : Size(buttonsSize, buttonsSize),
            ),
          )
          .toList(),
    );
  }
}
