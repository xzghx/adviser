import 'package:flutter/material.dart';

class AdviceField extends StatelessWidget {
  const AdviceField({super.key, required this.advice});

  static const String emptyString = 'No advise';
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
                  advice.isNotEmpty ? '''"$advice"''' : emptyString,
                  textAlign: TextAlign.center,
                )),
              )),
        ),
      ],
    );
  }
}

class AdviceError extends StatelessWidget {
  const AdviceError({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Theme.of(context).colorScheme.error,
          size: 43,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
              child: Text(
            '''"$error"''',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          )),
        ),
      ],
    );
  }
}
