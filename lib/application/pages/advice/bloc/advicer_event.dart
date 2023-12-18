part of 'advicer_bloc.dart';

@immutable
abstract class AdviserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdviceRequest extends AdviserEvent {}
