---
layout: default
title: Start AndroidStudio
description: Install AndroidStudio
---


# Login

로그인이란 무엇인가

운영체제나 인터넷 사이트 등에서 자신의 계정을 이용하기 위해 사용자 인증을 하여 자신의 계정으로 접속하는 컴퓨터 용어이다. 로그온(log on)이나 사인 인(sign in)으로 쓰기도 한다. 해외 사이트에서 log in이 보이지 않을 경우 log on이나 sign in을 찾을 수 있다. 나무위키는 sign in으로 표기한다. 반댓말 로그아웃(log out) 또는 로그오프(log off), 사인 아웃(sign out).*

이런 과정을 schooldev 에서는 firebase auth 를 이용해서 구현합니다

*Firebase 인증은 앱에서 사용자 인증 시 필요한 백엔드 서비스와 사용하기 쉬운 SDK, 기성 UI 라이브러리를 제공합니다. 비밀번호, 전화번호, 인기 ID 제공업체(예: Google, Facebook, Twitter 등)를 통한 인증이 지원됩니다.*

우리는 이중 이메일을 이용할거고요

*사용자를 앱에 로그인시키려면 우선 사용자에게서 인증 정보를 받아야 합니다. 이 사용자 인증 정보는 사용자의 이메일 주소와 비밀번호일 수도 있고, 제휴 ID 공급업체에서 받은 OAuth 토큰일 수도 있습니다. 그런 다음 이 사용자 인증 정보를 Firebase 인증 SDK로 전달합니다. 그러면 Firebase의 백엔드 서비스가 정보를 확인하여 클라이언트에 응답을 반환합니다.*

*로그인이 정상적으로 이루어진 후에는 사용자의 기본 프로필 정보에 액세스할 수 있으며 다른 Firebase 제품에 저장된 데이터에 대한 사용자의 액세스 권한을 제어할 수 있습니다. 또한 받은 인증 토큰을 사용해서 자체 백엔드 서비스에서도 사용자의 신원을 확인할 수 있습니다.*

*참고: 인증을 마친 사용자는 기본적으로 Firebase 실시간 데이터베이스와 Cloud Storage에서 데이터를 읽고 쓸 수 있습니다. 사용자의 액세스 권한을 제어하려면* [*Firebase 실시간 데이터베이스*](https://firebase.google.com/docs/database/security/index?hl=ko) *및* [*Cloud Storage 보안 규칙*](https://firebase.google.com/docs/storage/security/index?hl=ko)*을 수정하면 됩니다.*![img](https://lh5.googleusercontent.com/uiW_xAtcOA7v2vSsUdEJGy1Ps4MluPqu8iEiQHVofmlV6A67RhztZiX1REyzM6wFh66WgRFvctadgnQVxL-BcENke6BmXiABGsFtEiY6uho-9j4-lIsxGg1bIEBckerzp7G6XU1L)

어떻게 하느냐 하면은 

일단 파이어 베이스에 들어갑니다

그전 과정에서 아마 플러터에 연결까지는

해보셨을거에요

여기서 노랑칠해져있는 authentication으로 

갑니다

![img](https://lh4.googleusercontent.com/NmxtjhOtTImQD06bIJCxlnr7UlCrinqCHUY31VL38Izoz00jSTbY4a6qaBgFxpRH6W42MaG4b8lcY2wQPMyiCkKQ89QvC2M6ppMQ6yrhBalV9NCCB5V0T_WjyRWN3v_fC9W9wIRp)

로그인 방법으로 간 후에 원하는 서비스를 사용설정하십쇼

![img](https://lh6.googleusercontent.com/938he4Pn6lDPOSceh1FTA_thwUM4hL02eVOLSaZUGPCk6u00uBnxtb42ll_nlw7AkGv6UzYs6Mu-cAPKkUmETFjg6wBhTbCKfhpmitfgUMjgA1nEUYeO919T26hbcXsAmDrP55Wo)

그 옆 탬플릿에서는 이메일 주소 번경, 비밀번호 재설정 과 같은 서비스를 수정 할 수 있습니다. 

![img](https://lh3.googleusercontent.com/-vENmiBUcBvhpb6GA5rdpn9Y-QTbgAHUCslqiuiItOCPQnZzveauPhAcv5GN6SymFyGKj1FEQPzJavxd7eURYr3KWW3uzWixRkVkroEeRL7BQ-VPtpitsu7BfkgF-P3q3RLmMWhR)

후에 앱의 사용자들이 계정을 만들면 다음과 같이 보일 것 입니다

여기 까지 하면 기본 준비는 끝난 셈이네요

그럼 이제 앱으로 돌아가죠

main.dart 부터 보겠습니다

```dart

import 'package:flutter/material.dart';

import 'package:flutter_schooldev/pages/auth/authentication.dart';

import 'package:flutter_schooldev/pages/auth/root_page.dart';

void main() {

 runApp(new MyApp());

}

class MyApp extends StatelessWidget {

 @override

 Widget build(BuildContext context) {

   return new MaterialApp(

​       title: 'SchoolDev', // 앱이름입니다

​       debugShowCheckedModeBanner: false,

​       theme: new ThemeData(

​         primarySwatch: Colors.lightGreen, // 테마색

​       ),

​       home: new RootPage(auth: new Auth()));

 }

}

```

main.dart의 코드 입니다

참고로 import를 하는 이유는 다른 클래스의 코드나 외부 라이브러리등을 이용하려면 위와 같이 import를 해와야 합니다

그리고 인증 부분의 코드들 입니다

코딩에 들어가기 전어 우리는 firebase 서비스를 이용하기위해 몇가지 플러그인 들을 pubspec.yaml 에 추가하여야 합니다

![img](https://lh5.googleusercontent.com/0rJShu1T9RJc-k6VU4pmzvL6Pbt9NQQypwDPZg9eODMfERiqPuZrl_eIVVXIZC_HXj5qu3bPKT_otP18_WL3ENDp1NvjCJmlV7rNZ3VMZsiaPsZd-bfr37Hn3-VEB5VIJZvW0nzM)

이렇게 생긴 부분이 있을 거에요

<https://pub.dev/flutter/packages>

이 사이트로 갑니다

여기에서 우리가 필요한 플러그인들을 구할 거에요

<https://pub.dev/packages/firebase_auth>

일단은 firebase auth 플러그인 입니다

![img](https://lh6.googleusercontent.com/h22pRb1gx7RWBASLkkME2mUeIEBDuyHbSmUWlVjyDH1u0M6JlAFdkxOcvqdKWquG1KuI7M_8JLFhEvyYrfqRtgGfGHKYVav4-Oa2McTb4AYKpM9NUC2BFEfMf34rUI5jwVV3fzmo)

installing 으로 가보면

![img](https://lh5.googleusercontent.com/CbXBJU4WWJ92yJzJZQlp2qITVaxdE1_YmsomSYrsDZjpSobHEZQTqFjEvlLTDju9XzE1_H03Aw6QOzwPUID4qQ_9EUwTJtyPO75MQJd7JRdQGiNjK-9KUb__Xh_2odTLbguu05H1)

이렇게 있을텐데 저기서 보이는 예시처럼 pubspec.yaml에 추가해줍시다

추가하고 나면 안드로이드 스튜디오 상단 부분에 get dependencies 라고 뜰건데 눌러줍시다 만약에 안뜨면 커맨드 라인으로 하시면 됩니다 자세한건 사이트 참고 ㄱㄱ

이 과정을 하면 이제 우리는 firebase auth 를 import 해서 사용 할 수 있는 것 입니다

```dart

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {

 Future<String> signIn(String email, String password);

 Future<String> signUp(String email, String password);

 Future<FirebaseUser> getCurrentUser();

 Future<void> sendEmailVerification();

 Future<void> signOut();

 Future<bool> isEmailVerified();

 Future<void> sendPasswordResetEmail(String email);

}

class Auth implements BaseAuth {

 final FirebaseAuth _firebaseAuth = FirebaseAuth.*instance*;

 Future<String> signIn(String email, String password) async {

   AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(

​       email: email, password: password);

   FirebaseUser user = result.user;

   return user.uid;

 }

 Future<String> signUp(String email, String password) async {

   AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(

​       email: email, password: password);

   FirebaseUser user = result.user;

   return user.uid;

 }

 Future<FirebaseUser> getCurrentUser() async {

   FirebaseUser user = await _firebaseAuth.currentUser();

   return user;

 }

 Future<void> signOut() async {

   return _firebaseAuth.signOut();

 }

 Future<void> sendEmailVerification() async {

   FirebaseUser user = await _firebaseAuth.currentUser();

   user.sendEmailVerification();

 }

 Future<bool> isEmailVerified() async {

   FirebaseUser user = await _firebaseAuth.currentUser();

   return user.isEmailVerified;

 }

 Future<void> sendPasswordResetEmail(String email) async {

   return _firebaseAuth.sendPasswordResetEmail(email: email);

 }

}

```

authentication.dart

```dart
import 'package:flutter/material.dart';

import 'package:flutter_schooldev/pages/auth/authentication.dart';

class LoginSignUpPage extends StatefulWidget {

 LoginSignUpPage({this.auth, this.onSignedIn});

 final BaseAuth auth;

 final VoidCallback onSignedIn;

 @override

 State<StatefulWidget> createState() => new _LoginSignUpPageState();

}

enum FormMode { LOGIN, SIGNUP, RESET } // password reset func to be made

class _LoginSignUpPageState extends State<LoginSignUpPage> {

 final _formKey = new GlobalKey<FormState>();

 String _email;

 String _password;

 String _errorMessage;

 // Initial form is login form

 FormMode _formMode = FormMode.LOGIN;

 bool _isIos;

 bool _isLoading;

 // Check if form is valid before perform login or signup

 bool _validateAndSave() {

   final form = _formKey.currentState;

   if (form.validate()) {

​     form.save();

​     return true;

   }

   return false;

 }

 // Perform login or signup

 void _validateAndSubmit() async {

   setState(() {

​     _errorMessage = "";

​     _isLoading = true;

   });

   if (_validateAndSave()) {

​     String userId = "";

​     try {

​       if (_formMode == FormMode.LOGIN) {

​         userId = await widget.auth.signIn(_email, _password);

​         print('Signed in: $userId');

​       }

​       if (_formMode == FormMode.SIGNUP){

​         userId = await widget.auth.signUp(_email, _password);

​         widget.auth.sendEmailVerification();

​         _showVerifyEmailSentDialog();

​         print('Signed up user: $userId');

​         print('test');

​       }

​       if (_formMode == FormMode.RESET){

​         await widget.auth.sendPasswordResetEmail(_email);

​         setState(() {

​           _formMode = FormMode.LOGIN;

​         });

​       }

​       setState(() {

​         _isLoading = false;

​       });

​       if (userId.length > 0 && userId != null && _formMode == FormMode.LOGIN) {

​         widget.onSignedIn();

​       }

​     } catch (e) {

​       print('Error: $e ');

​       setState(() {

​         _isLoading = false;

​         if (_isIos) {

​           _errorMessage = e.details;

​         } else

​           _errorMessage = e.message;

​       });

​     }

   }

 }

 @override

 void initState() {

   _errorMessage = "";

   _isLoading = false;

   super.initState();

 }

 void _changeFormToSignUp() {

   _formKey.currentState.reset();

   _errorMessage = "";

   setState(() {

​     _formMode = FormMode.SIGNUP;

   });

 }

 void _changeFormToLogin() {

   _formKey.currentState.reset();

   _errorMessage = "";

   setState(() {

​     _formMode = FormMode.LOGIN;

   });

 }

 void _changeFormToReset(){

   _formKey.currentState.reset();

   _errorMessage = "";

   setState(() {

​     _formMode = FormMode.RESET;

   });

 }

 @override

 Widget build(BuildContext context) {

   _isIos = Theme.*of*(context).platform == TargetPlatform.iOS;

   return new Scaffold(

//        appBar: new AppBar(

//          title: new Text('SchoolDev Login'),

//        ),

​       body: Stack(

​         children: <Widget>[

​           _showBody(),

​           _showCircularProgress(),

​         ],

​       ));

 }

 Widget _showCircularProgress(){

   if (_isLoading) {

​     return Center(child: CircularProgressIndicator());

   } return Container(height: 0.0, width: 0.0,);

 }

 void _showVerifyEmailSentDialog() {

   showDialog(

​     context: context,

​     builder: (BuildContext context) {

​       // return object of type Dialog

​       return AlertDialog(

​         title: new Text("Verify your account"),

​         content: new Text("Link to verify account has been sent to your email"),

​         actions: <Widget>[

​           new FlatButton(

​             child: new Text("Dismiss"),

​             onPressed: () {

​               _changeFormToLogin();

​               Navigator.*of*(context).pop();

​             },

​           ),

​         ],

​       );

​     },

   );

 }

 Widget _showBody(){

   if(_formMode == FormMode.RESET){

​     return new Container(

​         padding: EdgeInsets.all(16.0),

​         child: new Form(

​           key: _formKey,

​           child: new ListView(

​             shrinkWrap: true,

​             children: <Widget>[

​               _showLogo(),

​               _showEmailInput(),

​               _showPrimaryButton(),

​               _showSecondaryButton(),

​               _showPasswordResetButton(),

​               _showErrorMessage(),

​             ],

​           ),

​         ));

   }else{

​     return new Container(

​         padding: EdgeInsets.all(16.0),

​         child: new Form(

​           key: _formKey,

​           child: new ListView(

​             shrinkWrap: true,

​             children: <Widget>[

​               _showLogo(),

​               _showEmailInput(),

​               _showPasswordInput(),

​               _showPrimaryButton(),

​               _showSecondaryButton(),

​               _showPasswordResetButton(),

​               _showErrorMessage(),

​             ],

​           ),

​         ));

   }

 }

 Widget _showErrorMessage() {

   if (_errorMessage.length > 0 && _errorMessage != null) {

​     return new Text(

​       _errorMessage,

​       style: TextStyle(

​           fontSize: 13.0,

​           color: Colors.*red*,

​           height: 1.0,

​           fontWeight: FontWeight.*w300*),

​     );

   } else {

​     return new Container(

​       height: 0.0,

​     );

   }

 }

 Widget _showLogo() {

   return new Hero(

​     tag: 'hero',

​     child: Padding(

​       padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),

​       child: CircleAvatar(

​         backgroundColor: Colors.*transparent*,

​         radius: 48.0,

​         child: Image.asset('assets/Logo.png'),

​       ),

​     ),

   );

 }

 Widget _showEmailInput() {

   return Padding(

​     padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),

​     child: new TextFormField(

​       maxLines: 1,

​       keyboardType: TextInputType.*emailAddress*,

​       autofocus: false,

​       decoration: new InputDecoration(

​           hintText: 'Email',

​           icon: new Icon(

​             Icons.*mail*,

​             color: Colors.*grey*,

​           )),

​       validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,

​       onSaved: (value) => _email = value.trim(),

​     ),

   );

 }

 Widget _showPasswordInput() {

   return Padding(

​     padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),

​     child: new TextFormField(

​       maxLines: 1,

​       obscureText: true,

​       autofocus: false,

​       decoration: new InputDecoration(

​           hintText: 'Password',

​           icon: new Icon(

​             Icons.*lock*,

​             color: Colors.*grey*,

​           )),

​       validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,

​       onSaved: (value) => _password = value.trim(),

​     ),

   );

 }

 Widget _showPasswordResetButton(){

   if(_formMode == FormMode.LOGIN){

​     return new FlatButton(

​       child: new Text('Forgot password?',

​           style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.*w300*)),

​       onPressed:

​       _changeFormToReset,

​     );

   }else{

​     return SizedBox();

   }

 }

 Widget _showSecondaryButton() {

   if(_formMode == FormMode.LOGIN){

​     return new FlatButton(

​       child: new Text('Create an account',

​           style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.*w300*)),

​       onPressed:

​         _changeFormToSignUp,

​     );

   }

   if(_formMode == FormMode.SIGNUP){

​     return new FlatButton(

​       child: new Text('Have an account? Sign in',

​           style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.*w300*)),

​       onPressed:

​       _changeFormToLogin,

​     );

   }

   if(_formMode == FormMode.RESET){

​     return new FlatButton(

​       child: new Text('Have an account? Sign in',

​           style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.*w300*)),

​       onPressed:

​       _changeFormToLogin,

​     );

   }

 }

 Widget _showPrimaryButton() {

   if(_formMode == FormMode.SIGNUP || _formMode == FormMode.LOGIN){

​     return new Padding(

​         padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),

​         child: SizedBox(

​           height: 40.0,

​           child: new RaisedButton(

​             elevation: 5.0,

​             shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),

​             color: Colors.*green*,

​             child: _formMode == FormMode.LOGIN

​                 ? new Text('Login',

​                 style: new TextStyle(fontSize: 20.0, color: Colors.*white*))

​                 : new Text('Create account',

​                 style: new TextStyle(fontSize: 20.0, color: Colors.*white*)),

​             onPressed: _validateAndSubmit,

​           ),

​         ));

   }else{

​     return new Padding(

​       padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),

​       child: SizedBox(

​         height: 40.0,

​         child: new RaisedButton(

​           elevation: 5.0,

​           shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),

​           color: Colors.*green*,

​           child:

​             new Text('Submit',

​             style: new TextStyle(fontSize: 20.0, color: Colors.*white*)),

​           onPressed: _validateAndSubmit,

​         )

​       ),

​     );

   }

 }

}
```



login_signup_page.dart

\```dart

import 'package:flutter/material.dart';

import 'package:flutter_schooldev/pages/auth/login_signup_page.dart';

import 'package:flutter_schooldev/pages/auth/authentication.dart';

import 'package:flutter_schooldev/pages/Home/home_page.dart';

class RootPage extends StatefulWidget {

 RootPage({this.auth});

 final BaseAuth auth;

 @override

 State<StatefulWidget> createState() => new _RootPageState();

}

enum AuthStatus {

 NOT_DETERMINED,

 NOT_LOGGED_IN,

 LOGGED_IN,

}

class _RootPageState extends State<RootPage> {

 AuthStatus authStatus = AuthStatus.NOT_DETERMINED;

 String _userId = "";

 String _username;

 @override

 void initState() {

   super.initState();

   widget.auth.getCurrentUser().then((user) {

​     setState(() {

​       if (user != null) {

​         _userId = user?.uid;

​         _username = user?.displayName;

​       }

​       authStatus =

​       user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;

​     });

   });

 }

 void _onLoggedIn() {

   widget.auth.getCurrentUser().then((user){

​     setState(() {

​       _userId = user.uid.toString();

​     });

   });

   setState(() {

​     authStatus = AuthStatus.LOGGED_IN;

   });

 }

 void _onSignedOut() {

   setState(() {

​     authStatus = AuthStatus.NOT_LOGGED_IN;

​     _userId = "";

   });

 }

 Widget _buildWaitingScreen() {

   return Scaffold(

​     body: Container(

​       alignment: Alignment.*center*,

​       child: CircularProgressIndicator(),

​     ),

   );

 }

 @override

 Widget build(BuildContext context) {

   switch (authStatus) {

​     case AuthStatus.NOT_DETERMINED:

​       return _buildWaitingScreen();

​       break;

​     case AuthStatus.NOT_LOGGED_IN:

​       return new LoginSignUpPage(

​         auth: widget.auth,

​         onSignedIn: _onLoggedIn,

​       );

​       break;

​     case AuthStatus.LOGGED_IN:

​       if (_userId.length > 0 && _userId != null) {

​         return new HomePage(

​           userId: _userId,

​           auth: widget.auth,

​           onSignedOut: _onSignedOut,

​           username: _username,

​         );

​       } else return _buildWaitingScreen();

​       break;

​     default:

​       return _buildWaitingScreen();

   }

 }

}

\```

root_page.dart

코드 복붙하세요

![img](https://lh3.googleusercontent.com/SK_-yf_5_3gwNqjFn4ssvcOgu3ECAAsM7OzjNyGvEP6SBNohE6v96UZK1GjNPFQv2RvTt-nayFxxrChj3X3m_81GtQVGFCqM4VrXfysCo6bXMHYym0LnmEaI3UQLiAkRvnjdmUsn)

파일 구조는 이런 식으로 하는 거 추천 합니다

이렇게 정리해줘야 나중에 편해요

아직 실행하면 에러가 날거에요

다음 과정인 홈 화면을 만들고 나면 에러가 사라질 겁니다
