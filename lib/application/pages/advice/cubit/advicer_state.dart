part of 'advicer_cubit.dart';

@immutable
abstract class AdviserState extends Equatable {
  const AdviserState();

  @override
  List<Object?> get props => [];
}

class AdviserInitial extends AdviserState {
  const AdviserInitial();
}

class AdviserLoading extends AdviserState {
  const AdviserLoading();
}

class AdviserLoaded extends AdviserState {
  final String advice;

  const AdviserLoaded({required this.advice});

  @override
  List<Object?> get props => [advice];
}

class AdviserError extends AdviserState {
  final String error;

  const AdviserError({required this.error});

  @override
  List<Object?> get props => [error];
}
