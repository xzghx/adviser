import 'package:advicer_app/application/pages/advice/cubit/advicer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdviceButton extends StatelessWidget {
  const AdviceButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkResponse(
      onTap: () => context.read<AdvicerCubit>().adviceRequest(),
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(15),
        shadowColor: Colors.grey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: theme.colorScheme.secondary),
          child: Text(
            'Get Advice',
            style: theme.textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}
