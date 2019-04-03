import 'package:doggie_app/model/doggie_superpower.dart';

class Dog {
  Dog({this.petName, this.petWeight, this.petSex, this.petPicURL, this.petDescription });

  final String petName;
  final String petWeight;
  final String petSex;
  final String petPicURL;
  final String petDescription;
//  final SuperPowers superPowers;this.superPowers

  factory Dog.fromJSON(Map<String, dynamic> json) => new Dog(
    petName: json['pet_name'],
    petWeight: json['weight'],
    petSex: json['sex'],
    petPicURL: json['pic_url'],
    petDescription: json['desc'],
//    superPowers: new SuperPowers(
//      isTrainable: json['super_power']['is_trainable'],
//      milage: json['super_power']['milage'],
//      isCombactant: json['super_power']['is_combactant']
//    ),
  );

  Map<String, dynamic> toJSON() => {
    "petName": petName, 
    "petWeight": petWeight,
    "petSex": petSex,
    "petPicURL": petPicURL,
    "petDescription": petDescription,
//    "superPowers": superPowers,
  };
}