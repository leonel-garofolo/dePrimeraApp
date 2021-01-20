

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FieldDatePicker extends StatelessWidget{
  FieldDatePicker({this.label, this.value, this.enabled, this.valueChanged});
  @required
  final String label;
  @required
  final ValueChanged<DateTime> valueChanged;
  @required
  final DateTime value;
  @required
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMd(Intl.defaultLocale);
    return InkWell(
      onTap: () {
        showDatePicker(
            context: context,
            initialDate: value,
            firstDate: DateTime(2001),
            lastDate: DateTime(2099),
        ).then((date) {
          valueChanged(date);
        });
      },
      child: InputDecorator(
        decoration: InputDecoration(labelText: label, enabled: enabled == null? true : enabled),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              dateFormat.format(value),
            ),
            Icon(Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ),
      ),
    );
  }
}