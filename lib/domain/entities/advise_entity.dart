import 'package:equatable/equatable.dart';

class AdviseEntity extends Equatable {
  final int id;
  final String advise;

  const AdviseEntity({required this.id, required this.advise});

  @override
  List<Object?> get props => [id, advise];
}
