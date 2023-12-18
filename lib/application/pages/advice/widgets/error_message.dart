import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.error,
          color: Colors.redAccent,
          size: 40,
        ),
        Text(error, style: Theme.of(context).textTheme.displayLarge),
      ],
    );
  }
}
