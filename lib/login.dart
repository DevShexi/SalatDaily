import 'package:flutter/material.dart';
import 'package:salatdaily/constants.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:salatdaily/notificationManager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();
  bool requestedLogin = false;
  String username;
  String password;
  String deviceType;
  String deviceID;
  String token; // fmctoken from Firebase Cloud Messaging
  @override
  initState() {
    super.initState();
    fetchDeviceToken();
  }

  fetchDeviceToken() async {
    NotificationManager _fcmManager = new NotificationManager();
    String fetchedToken = await _fcmManager.getfcmToken();
    setState(() {
      token = fetchedToken;
    });
    // print(token);
  }

  //saving the jwt token into shared preferences to be used in all the post requests
  _getAndSaveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String _jwttoken = await loginUser();
    if (_jwttoken != null) {
      await prefs.setString('jwt', _jwttoken);
      Navigator.pushNamed(
        context,
        '/home',
      );
    } else {
      print('Login Attempt failed');
    }
  }

  Future<String> loginUser() async {
    final String loginUrl = '$kBaseUrl/api/v1/auth/attempt';
    final http.Response response = await http.post(
      loginUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, Map>{
          'session': {
            'username': username,
            'password': password,
            'device_type': 'android',
            'device_id': token,
            'app': 'customer'
          }
        },
      ),
    );
    if (response.statusCode == 200) {
      print('Auth request has been successfull.');
      var decodeData = json.decode(response.body);
      var jwt = decodeData['session']['jwt'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (jwt != null) {
        await prefs.setString('jwt', jwt);
        print('Authentication Successful');
      } else {
        print('Login Attempt failed');
      }
    } else {
      print('Login Failed');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return !requestedLogin
        ? Scaffold(
            body: ListView(
              children: [
                SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 120,
                        ),
                        Image(
                          image: AssetImage('images/quran.png'),
                          width: 120,
                          height: 120,
                        ),
                        Text(
                          'LEARN QURAN',
                          style: TextStyle(
                              fontSize: 20,
                              color: kTeal,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 80),
                        FormBuilder(
                          key: _key,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 24),
                                child: FormBuilderTextField(
                                  attribute: 'username',
                                  initialValue: 'shexiakram@gmail.com',
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: kLight,
                                    prefixIcon:
                                        Icon(Icons.person, color: kTeal),
                                    labelText: 'Username',
                                    labelStyle: TextStyle(color: kTeal),
                                    hintText: 'Enter your User Name',
                                    hintStyle: TextStyle(color: kTeal),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: kTeal),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: kTeal),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: kThird),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: kThird),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                  ),
                                  validators: [
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.maxLength(32),
                                    FormBuilderValidators.minLength(2),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 24),
                                child: FormBuilderTextField(
                                  attribute: 'password',
                                  initialValue: '123456',

                                  obscureText: true,
                                  //obscuringCharacter: '*',
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: kLight,
                                    labelText: 'Password',
                                    labelStyle: TextStyle(color: kTeal),
                                    prefixIcon: Icon(Icons.lock, color: kTeal),
                                    hintText: 'Enter a password',
                                    hintStyle: TextStyle(color: kTeal),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: kTeal),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: kTeal),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: kThird),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: kThird),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                  ),

                                  validators: [
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.minLength(6),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 24),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 55,
                                  child: RaisedButton(
                                    color: kTeal,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      if (_key.currentState.saveAndValidate()) {
                                        setState(() {
                                          username = _key
                                              .currentState
                                              .fields['username']
                                              .currentState
                                              .value;
                                          password = _key
                                              .currentState
                                              .fields['password']
                                              .currentState
                                              .value;
                                        });
                                        setState(() {
                                          requestedLogin = true;
                                        });
                                        // Navigator.pushNamed(
                                        //     context, '/readQuran');

                                        _getAndSaveToken(); //has to be called to authenticate login
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        : Loading();
  }
}

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  static const spinkit = SpinKitFadingCircle(
    color: kTeal,
    size: 50.0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: spinkit,
      ),
    );
  }
}
