import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calculator/models/input_type.dart';
import 'package:calculator/viewmodels/calculator_viewmodel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

const _kTextButtonPadding = 0.2;
const _kIconButtonPadding = 0.3;

enum _InputButtonColorType {
  primary,
  secondary,
  normal,
}

class InputButton extends StatelessWidget {
  const InputButton({
    super.key,
    required this.inputType,
    required this.size,
  });
  final InputType inputType;
  final Size size;

  @override

  /// Returns a [SizedBox] containing a [MaterialButton] with a round
  /// rectangle shape, infinite height and width, and a child of [_getSymbol()].
  /// The button is configured with [_getForegroundColor], [_getHighlightColor],
  /// and [_getButtonColor] as its text color, highlight color, and color
  /// respectively. When the button is pressed, [_onPressButton] is called.
  /// The button is also configured with zero padding and elevation.
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: MaterialButton(
        textColor: _getForegroundColor(context),
        onPressed: () => _onPressButton(context),
        padding: EdgeInsets.zero,
        highlightColor: _getHighlightColor(context),
        color: _getButtonColor(context),
        highlightElevation: 0,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.height / 2),
        ),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: _getSymbol(),
        ),
      ),
    );
  }

  /// Calls [CalculatorViewModel.onPressButton] with the given [inputType] and
  /// a callback that shows a Cupertino alert dialog with a message and an OK
  /// button if the text overflows.
  void _onPressButton(BuildContext context) {
    var viewmodel = context.read<CalculatorViewModel>();
    viewmodel.onPressButton(
      inputType: inputType,
      onTextOverflow: () {
        showDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            content: const Text('You can\'t enter more than 18 characters.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              )
            ],
          ),
        );
      },
    );
  }

  /// Returns a symbol for the given [inputType].
  ///
  /// - A [Text] widget with a bold font style for number buttons and the
  ///   decimal point button.
  /// - A [FaIcon] widget with a centered and fitted icon for operator buttons.
  /// - A [FaIcon] widget with a centered and fitted icon for the clear,
  ///   delete, and percent buttons.
  ///
  Widget _getSymbol() {
    switch (inputType) {
      case InputType.point:
        return _getTextSymbol('.');
      case InputType.addition:
        return _getIconSymbol(FontAwesomeIcons.plus);
      case InputType.subtraction:
        return _getIconSymbol(FontAwesomeIcons.minus);
      case InputType.multiplication:
        return _getIconSymbol(FontAwesomeIcons.xmark);
      case InputType.division:
        return _getIconSymbol(FontAwesomeIcons.divide);
      case InputType.equality:
        return _getIconSymbol(FontAwesomeIcons.equals);
      case InputType.clear:
        return _getTextSymbol('C');
      case InputType.delete:
        return _getIconSymbol(FontAwesomeIcons.deleteLeft);
      case InputType.percent:
        return _getIconSymbol(FontAwesomeIcons.percent);
      default:
        return _getTextSymbol(inputType.name.replaceFirst('number', ''));
    }
  }

  /// Returns a [Padding] widget containing a [FittedBox] widget with an [FaIcon]
  /// widget inside. The padding is set to [_kIconButtonPadding] of the button's
  /// height, and the [FaIcon] widget is given the [iconData] as its icon.
  /// The purpose of this method is to create a symbol for an operator button.
  /// The icon is always centered in the button.
  Widget _getIconSymbol(IconData iconData) {
    return Padding(
      padding: EdgeInsets.all(size.height * _kIconButtonPadding),
      child: FittedBox(child: FaIcon(iconData)),
    );
  }

  /// Returns a [Padding] widget containing a [FittedBox] widget with a [Text]
  /// widget inside. The padding is set to [_kTextButtonPadding] of the button's
  /// height, and the [Text] widget is given the [text] as its text and a bold
  /// font style. The purpose of this method is to create a symbol for a number
  /// button. The text is always centered in the button.
  Widget _getTextSymbol(String text) {
    return Padding(
      padding: EdgeInsets.all(size.height * _kTextButtonPadding),
      child: FittedBox(
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  /// Returns the color type of the button based on the [inputType].
  ///
  /// - number buttons and the decimal point button are normal color.
  /// - operator buttons are primary color.
  /// - clear, delete, and percent buttons are secondary color.
  _InputButtonColorType _getColorType() {
    switch (inputType) {
      case InputType.number0:
      case InputType.number1:
      case InputType.number2:
      case InputType.number3:
      case InputType.number4:
      case InputType.number5:
      case InputType.number6:
      case InputType.number7:
      case InputType.number8:
      case InputType.number9:
      case InputType.point:
        return _InputButtonColorType.normal;
      case InputType.addition:
      case InputType.subtraction:
      case InputType.multiplication:
      case InputType.division:
      case InputType.equality:
        return _InputButtonColorType.primary;
      case InputType.clear:
      case InputType.delete:
      case InputType.percent:
        return _InputButtonColorType.secondary;
    }
  }

  /// Returns the button color based on the [inputType].
  ///
  /// - primary color for operator buttons.
  /// - secondary color for clear, delete, and percent buttons.
  /// - normal color for number buttons and the decimal point button.
  Color _getButtonColor(BuildContext context) {
    switch (_getColorType()) {
      case _InputButtonColorType.primary:
        return Theme.of(context).colorScheme.primary;
      case _InputButtonColorType.secondary:
        return Theme.of(context).colorScheme.secondary;
      case _InputButtonColorType.normal:
        return Theme.of(context).colorScheme.surfaceContainerHighest;
    }
  }

  /// Returns the highlight color of the button based on the [inputType].
  ///
  /// - primaryContainer color for operator buttons.
  /// - secondaryContainer color for clear, delete, and percent buttons.
  /// - tertiaryContainer color for number buttons and the decimal point button.
  Color _getHighlightColor(BuildContext context) {
    switch (_getColorType()) {
      case _InputButtonColorType.primary:
        return Theme.of(context).colorScheme.primaryContainer;
      case _InputButtonColorType.secondary:
        return Theme.of(context).colorScheme.secondaryContainer;
      case _InputButtonColorType.normal:
        return Theme.of(context).colorScheme.tertiaryContainer;
    }
  }

  /// Returns the foreground color of the button based on the [inputType].
  ///
  /// - onPrimary color for operator buttons.
  /// - onSecondary color for clear, delete, and percent buttons.
  /// - onSurfaceVariant color for number buttons and the decimal point button.
  Color _getForegroundColor(BuildContext context) {
    switch (_getColorType()) {
      case _InputButtonColorType.primary:
        return Theme.of(context).colorScheme.onPrimary;
      case _InputButtonColorType.secondary:
        return Theme.of(context).colorScheme.onSecondary;
      case _InputButtonColorType.normal:
        return Theme.of(context).colorScheme.onSurfaceVariant;
    }
  }
}
