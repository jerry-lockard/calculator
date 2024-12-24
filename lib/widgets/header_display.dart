import 'package:flutter/material.dart';
import 'package:calculator/viewmodels/calculator_viewmodel.dart';
import 'package:provider/provider.dart';

class HeaderDisplay extends StatelessWidget {
  const HeaderDisplay({super.key});

  @override

  /// Builds the header display widget.
  //
  /// This widget is used to display the header text at the top of the
  /// calculator screen. The text is displayed in a large font size and
  /// is centered at the right of the screen.
  //
  /// The text displayed is determined by the [CalculatorViewModel]'s
  /// [inputHeaderText] property.
  Widget build(BuildContext context) {
    var viewmodel = context.watch<CalculatorViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Spacer(),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerRight,
          child: Text(
            viewmodel.inputHeaderText,
            style: TextStyle(
              fontSize: 70,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
