import 'package:advicer_app/domain/failures/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/usecases/advice_usecases.dart';

part 'advicer_state.dart';

class AdvicerCubit extends Cubit<AdviserState> {
  AdvicerCubit() : super(AdviserInitial());
  AdviseUseCase adviseUseCase = AdviseUseCase();

  void adviceRequest() async {
    emit(AdviserLoading());
    final advice = await adviseUseCase.getAdvice();
    advice.fold((failure) => emit(AdviserError(error: failure.getMessage())),
        (r) => emit(AdviserLoaded(advice: r.advise)));
  }
}
