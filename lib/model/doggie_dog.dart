import 'package:doggie_app/model/doggie_superpower.dart';

class Dog {
  Dog({this.petName, this.weight, this.size, this.superPowers});

  final String petName;
  final double weight;
  final String size;
  final SuperPowers superPowers;

  factory Dog.fromJSON(Map<String, dynamic> json) => new Dog(
    petName: json['pet_name'], 
    weight: json['weight'], 
    size: json['size'], 
    superPowers: new SuperPowers(
      isTrainable: json['super_power']['is_trainable'], 
      milage: json['super_power']['milage'], 
      isCombactant: json['super_power']['is_combactant']
    ),
  );

  Map<String, dynamic> toJSON() => {
    "petName": petName, 
    "weight": weight, 
    "size": size, 
    "superPowers": superPowers,
  };
}