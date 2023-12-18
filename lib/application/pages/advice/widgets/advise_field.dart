import 'package:flutter/material.dart';

class AdviceField extends StatelessWidget {
  const AdviceField({super.key, required this.advice});

  final String advice;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Material(
          borderRadius: BorderRadius.circular(15),
          elevation: 20,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.onPrimary),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: Text(
                  '''"$advice"''',
                  textAlign: TextAlign.center,
                )),
              )),
        ),
      ],
    );
  }
}
