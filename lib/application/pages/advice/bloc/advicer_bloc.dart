import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

class AdviserBloc extends Bloc<AdviserEvent, AdviserState> {
  AdviserBloc() : super(AdviserInitial()) {
    on<AdviceRequest>((event, emit) async {
      emit(AdviserLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(AdviserLoaded(advice: 'Fake advice'));
    });
  }
}
