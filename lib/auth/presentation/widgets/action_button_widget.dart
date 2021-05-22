import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Function? onPressed;
  final String text;
  const ActionButton({this.onPressed, this.text = ''});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: ElevatedButton(
          child: Text(text),
          onPressed: () => onPressed!(),
          style: ElevatedButton.styleFrom(primary: Colors.blue),
        ));
  }
}
