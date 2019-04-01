import 'package:flutter/material.dart';
class DoggieCustomTextFormField extends Container{

  DoggieCustomTextFormField({
    this.decoration,
    this.child,
    this.padding,
    this.alignment,
  });

// final TextEditingController controller;
// final FormFieldSetter onSaved;
// final FormFieldValidator validator;
 final Decoration decoration;
 final Widget child;
 final EdgeInsets padding;
 final Alignment alignment;

 factory DoggieCustomTextFormField.createFlatTextField({
   @required controller, @required onSaved, @required validator,
   @required IconData icon, @required String hintText, MaterialColor appTheme,
   obscureText = false, }) => DoggieCustomTextFormField(
     alignment: Alignment.center,
     padding: EdgeInsets.only(left: 8.0),
     decoration: BoxDecoration(),
     child: TextFormField(
       key: Key(hintText.toLowerCase().trim()),
       controller: controller,
       onSaved: onSaved,
       validator: validator,
       obscureText: obscureText,
       decoration: InputDecoration(
         icon: Icon(icon,),
         hintText: hintText,
         border: InputBorder.none,
       ),
     ),
   );

 factory DoggieCustomTextFormField.createCapsuleTextField({
   @required controller, @required onSaved, @required validator, @required IconData icon,
   @required String hintText, @required MaterialColor appTheme, obscureText = false }) => DoggieCustomTextFormField(
     alignment: Alignment.center,
     padding: EdgeInsets.only(left: 8.0),
     decoration: BoxDecoration(borderRadius: BorderRadius.circular(200.0), color: appTheme[50]),
     child: TextFormField(
       key: Key(hintText.toLowerCase().trim()),
       controller: controller,
       onSaved: onSaved,
       validator: validator,
       obscureText: obscureText,
       decoration: InputDecoration(
         icon: Icon(icon,),
         hintText: hintText,
         border: InputBorder.none,
       ),
     ),
   );
}