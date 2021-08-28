import 'package:finnaport/config/config.dart';
import 'package:finnaport/provider/performance_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class ChoiceChipForm extends StatelessWidget {
  const ChoiceChipForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final performanceProvider = Provider.of<PerformanceProvider>(context);
    final Size screenSize = MediaQuery.of(context).size;
    FocusNode f1 = FocusNode();
    return Container(
      width: screenSize.width - 16.0,
      height: 45,
      child: FormBuilderChoiceChip(
        focusNode: f1,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Palette.finnaDarkBox,
        ),
        alignment: WrapAlignment.center,
        runSpacing: 8,
        spacing: 8,
        initialValue: performanceProvider.getTypeChoice,
        name: 'choice_chip',
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (String changed) {
          f1.unfocus();
          performanceProvider.setTypeChoice(changed);
        },
        options: [
          FormBuilderFieldOption(value: 'ALL', child: Text('ALL')),
          FormBuilderFieldOption(value: 'STOCKS', child: Text('STOCKS')),
          FormBuilderFieldOption(value: 'CRYPTO', child: Text('CRYPTO')),
          FormBuilderFieldOption(value: 'FUNDS', child: Text('FUNDS')),
        ],
        selectedColor: Palette.finnaGreen,
        shadowColor: Palette.finnaDarkBox,
        selectedShadowColor: Palette.finnaDarkBox,
        backgroundColor: Colors.grey,
      ),
    );
  }
}
