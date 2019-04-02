import 'package:doggie_app/model/doggie_superpower.dart';

class Dog {
  Dog({this.petName, this.petWeight, this.petSize, this.petPicURL, this.petDescription, this.superPowers});

  final String petName;
  final double petWeight;
  final String petSize;
  final String petPicURL;
  final String petDescription;
  final SuperPowers superPowers;

  factory Dog.fromJSON(Map<String, dynamic> json) => new Dog(
    petName: json['pet_name'],
    petWeight: json['weight'],
    petSize: json['size'],
    petPicURL: json['pic_url'],
    petDescription: json['desc'],
    superPowers: new SuperPowers(
      isTrainable: json['super_power']['is_trainable'], 
      milage: json['super_power']['milage'], 
      isCombactant: json['super_power']['is_combactant']
    ),
  );

  Map<String, dynamic> toJSON() => {
    "petName": petName, 
    "petWeight": petWeight,
    "petSize": petSize,
    "petPicURL": petPicURL,
    "petDescription": petDescription,
    "superPowers": superPowers,
  };
}