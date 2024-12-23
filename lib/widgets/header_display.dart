import 'package:flutter/material.dart';
import 'package:calculator/viewmodels/calculator_viewmodel.dart';
import 'package:provider/provider.dart';

class HeaderDisplay extends StatelessWidget {
  const HeaderDisplay({super.key});

  @override
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
