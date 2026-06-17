
import 'package:e_chat/features/first_feature/domain/entities/cat_fact_entity.dart';

class CatFactModel extends CatFactEntity {
  CatFactModel({
    required super.fact,
    required super.length,
  });

  factory CatFactModel.fromJson(Map<String, dynamic> json) => CatFactModel(
        fact: json["fact"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "fact": fact,
        "length": length,
      };
}
