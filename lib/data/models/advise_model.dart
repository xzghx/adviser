import 'package:advicer_app/domain/entities/advise_entity.dart';
import 'package:equatable/equatable.dart';

class AdviseModel extends AdviseEntity with EquatableMixin {
  AdviseModel({required id, required advise}) : super(id: id, advise: advise);

  factory AdviseModel.fromJson(Map<String, dynamic> json) {
    return AdviseModel(id: json['advice_id'], advise: json['advice']);
  }
}
