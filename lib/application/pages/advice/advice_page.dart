import 'package:advicer_app/application/core/services/theme_service.dart';
import 'package:advicer_app/application/pages/advice/bloc/advicer_bloc.dart';
import 'package:advicer_app/application/pages/advice/widgets/advice_button.dart';
import 'package:advicer_app/application/pages/advice/widgets/advise_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AdviserPageWrapper extends StatelessWidget {
  const AdviserPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdviserBloc>(
      create: (context) => AdviserBloc(),
      child: const _AdvicePage(),
    );
  }
}

class _AdvicePage extends StatelessWidget {
  const _AdvicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adviser',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        actions: [
          Switch(
            value: Provider.of<ThemeService>(context).isDarkMode,
            onChanged: (_) =>
                Provider.of<ThemeService>(context, listen: false).toggleTheme(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(child: BlocBuilder<AdviserBloc, AdviserState>(
                builder: (context, state) {
                  if (state is AdviserInitial) {
                    return const AdviceField(advice: 'Let see an advice!');
                  } else if (state is AdviserLoading) {
                    return CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    );
                  } else if (state is AdviserLoaded) {
                    return AdviceField(advice: state.advice);
                  } else if (state is AdviserError) {
                    return AdviceField(advice: state.error);
                  }
                  return const SizedBox();
                },
              )),
              // ErrorMessage(error: 'Something went wrong.')
            ),
            const SizedBox(height: 200, child: Center(child: AdviceButton())),
          ],
        ),
      ),
    );
  }
}
