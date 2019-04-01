import 'dart:async';

import 'package:flutter/material.dart';
import "package:flutter_svg/flutter_svg.dart";
import 'package:doggie_app/utils/doggie_bloc_provider.dart';
import 'package:doggie_app/animations/doggie_splashscreen_login_animation.dart';
import 'package:doggie_app/utils/doggie_loginform_validator.dart';
import 'package:doggie_app/utils/doggie_custom_textformfield.dart';
import 'package:doggie_app/screens/doggie_homepage.dart';

enum AuthState {
  IS_LOADING,
  IS_DONE,
}

class DoggieSplashScreen extends StatefulWidget {
  @override
  _DoggieSplashScreenState createState() => _DoggieSplashScreenState();
}

class _DoggieSplashScreenState extends State<DoggieSplashScreen> with SingleTickerProviderStateMixin{
  DoggieSplashScreenLoginAnimation _dssla;
  AnimationController _controller;
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final TextEditingController _usernameTextEditingController = new TextEditingController();
  final TextEditingController _passwordTextEditingController = new TextEditingController();
  String username;
  String password;
  AuthState isloading = AuthState.IS_DONE;

  @override
  void initState() {
    super.initState();

//  Define a single controller to handle all the animation on our SplashScreen/Login Page
    this._controller = new AnimationController(vsync: this, duration: const Duration(seconds: 7));

//  Let's wait for the user to notice our application after 5seconds
    Timer(Duration(seconds: 5), (){
      this._controller.forward()..orCancel;
      this._dssla.logoScale.addListener(()=> this.setState((){}));
    });
  }

  @override
  Widget build(BuildContext context){

    Size size = MediaQuery.of(context).size;
    MaterialColor appTheme = DoggieBlocProvider.of(context).appTheme;
    this._dssla = new DoggieSplashScreenLoginAnimation(this._controller, size);

    return Scaffold(
      body: Container(
        color: appTheme[900],
        child:  Stack(
          fit: StackFit.expand,
          children: <Widget>[
            this._buildLogoWidget(size, appTheme),
            this._buildFormWidget(context, appTheme, size),
          ],
        ),
      ),
    );
  }

  Positioned _buildLogoWidget(Size size, MaterialColor appTheme) => Positioned(
    height: this._dssla.reduceLogoContainerHeight.value,
    width: size.width,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(200.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.diagonal3Values(this._dssla.logoScale.value, this._dssla.logoScale.value, 1.0),
              child: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "images/mobi-app-1.svg",
                  fit: BoxFit.cover,
                  height: 200.0,
                  width: 200.0,
                ),
              )
          ),
          SizedBox(height: 10.0,),
          Text("Doggie", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: appTheme[50].withOpacity(this._dssla.textOpacity1.value)),),
          Text("We sell smart dogs.", style: TextStyle(fontWeight: FontWeight.w200, fontSize: 15.0, color: appTheme[50].withOpacity(this._dssla.textOpacity2.value)),)
        ],
      ),
    ),
  );

  Positioned _buildFormWidget(BuildContext context, appTheme, Size size) => Positioned(
    top: this._dssla.increaseLoginContainerHeight.value,
    width: size.width,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.diagonal3Values(this._dssla.loginContainerScale.value, this._dssla.loginContainerScale.value, 1.0),
        child:Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Material(
                child: DoggieCustomTextFormField.createFlatTextField(
                  controller: this._usernameTextEditingController,
                  onSaved: _onSavedUsername,
                  validator: DoggieLoginFormValidator.validateUsername,
                  icon: Icons.person,
                  hintText: 'Username',
                  obscureText: false,
                ),
              ),
              SizedBox(height: 10.0, child: null,),
              Material(
                child: DoggieCustomTextFormField.createFlatTextField(
                  controller: this._passwordTextEditingController,
                  onSaved: _onSavedPassword,
                  validator: DoggieLoginFormValidator.validatePassword,
                  icon: Icons.lock_outline,
                  hintText: 'Password',
                  obscureText: true,
                ),
              ),
              SizedBox(height: 8.0, child: null,),
              RaisedButton(
                color: appTheme[400],
                padding: EdgeInsets.all(12.0),
                child: isloading == AuthState.IS_LOADING
                    ? CircularProgressIndicator()
                    : Text("LOGIN", style: TextStyle(color: appTheme[100], fontSize: 16.0 ),),
                onPressed: _saveUserCredential,
              )
            ],
          ),
        ),
      ),
    ),
  );


  void _onSavedUsername(String username) => this.username = username;
  void _onSavedPassword(String password) => this.password = password;
  void _saveUserCredential() {
    final FormState formState = formKey.currentState;
    if (formState.validate()) {
      formState.save();
      setState(() {isloading = AuthState.IS_LOADING;});
      Timer(Duration(milliseconds: 1000), () {
        setState(() {isloading = AuthState.IS_DONE;});
        this._controller.reverse();
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DoggieHomePage()));
      });
//      print("username: $username, password: $password");
    }
  }

  @override
  void dispose() {
    this._controller.dispose();
    this._usernameTextEditingController.dispose();
    this._passwordTextEditingController.dispose();
    super.dispose();
  }
}