import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

class Hashtag {
  final Color background_color;
  final Color color;
  final String name;

  Hashtag(this.background_color, this.color, this.name);

  factory Hashtag.fromJson(Map<String, dynamic> json) {
    return Hashtag(
      json['background_color'],
      json['color'],
      json['name'],
    );
  }
}

class Task {
  final String description;
  final int user_id;
  final bool can_be_performed_after_dd;
  final DateTime deadline;
  final DateTime start_time;
  final DateTime completed_at;
  final bool importance;
  final int id;
  final String name;
  final bool result;
  final Duration duration_of_completing;
  final DateTime created_at;
  final String recommendation;
  final List<String> hashtags;

  Task(
      {required this.completed_at,
      required this.description,
      required this.user_id,
      required this.can_be_performed_after_dd,
      required this.deadline,
      required this.start_time,
      required this.importance,
      required this.id,
      required this.name,
      required this.result,
      required this.duration_of_completing,
      required this.created_at,
      required this.recommendation,
      required this.hashtags});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      can_be_performed_after_dd: json['can_be_performed_after_dd'],
      completed_at: json['completed_at'],
      created_at: json['created_at'],
      deadline: json[''],
      description: json['description'],
      duration_of_completing: json['duration_of_completing'],
      id: json['id'],
      importance: json['importance'],
      hashtags: json['hashtags'],
      name: json['name'],
      recommendation: json['recommendation'],
      result: json['result'],
      start_time: json['start_time'],
      user_id: json['user_id'],
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/signup',
      routes: {
        '/signup': (context) => const SignUpPage(),
        '/signin': (context) => const SignInPage(),
        '/signuptwo': (context) => const SignUpPageTwo(),
        '/home': (context) => const HomePage(),
        '/addevent': (context) => const AddEventPage(),
        '/addevent2': (context) => const AddEventPage2(),
        '/eventnote': (context) => const EventNotePage(),
      },
      theme: ThemeData(),
    ),
  );
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String email = "";
  String password = "";
  String confirmpassword = "";
  int status = 0;

  void click() {
    status = 0;
    if (email == "" || password == "" || confirmpassword == "") {
    } else if (password != confirmpassword) {
      status = 2;
    } else if (email.contains(' ') || !email.contains('@')) {
      status = 1;
    } else if (password.length < 8) {
      status = 3;
    } else {
      Navigator.pushNamed(context, '/signuptwo', arguments: [email, password]);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(3, 64, 156, 1),
              Color.fromRGBO(1, 0, 54, 1),
            ],
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 1),
            Column(
              children: [
                //#region Logo
                Container(
                  alignment: Alignment.topCenter,
                  width: width * 0.4,
                  child: SvgPicture.asset('assets/image/logo.svg'),
                ),
                //#endregion
                //#region Sign in
                Visibility(
                  visible: height > 350,
                  child: Container(
                    margin: const EdgeInsets.only(top: 23),
                    child: GestureDetector(
                      onTap: () => {Navigator.pushNamed(context, '/signin')},
                      child: RichText(
                        textDirection: TextDirection.ltr,
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(0.6),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Sign in",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ) //#endregion
              ],
            ),
            const Spacer(flex: 2),
            Container(
              alignment: Alignment.center,
              width: width * 0.86,
              child: Column(
                children: [
                  //#region Email
                  Container(
                    height: 37,
                    decoration: BoxDecoration(color: const Color.fromRGBO(255, 255, 255, 0.09), borderRadius: BorderRadius.circular(5.37)),
                    child: TextFormField(
                      initialValue: '',
                      onChanged: (value) => setState(() {
                        email = value;
                        status = 0;
                      }),
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.5)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        errorText: status == 1 ? "incorect email" : null,
                        errorStyle: const TextStyle(fontSize: 8),
                        hintText: 'Email',
                        hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.45)),
                        contentPadding: const EdgeInsets.only(left: 14.5, bottom: 9),
                      ),
                    ),
                  ),
                  //#endregion
                  //#region Password
                  Container(
                    margin: const EdgeInsets.only(top: 4.3),
                    height: 37,
                    decoration: BoxDecoration(color: const Color.fromRGBO(255, 255, 255, 0.09), borderRadius: BorderRadius.circular(5.37)),
                    child: TextFormField(
                      initialValue: '',
                      onChanged: (value) => setState(() {
                        password = value;
                        status = 0;
                      }),
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.5)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        errorText: status == 3 ? "password must be at least 8 characters" : null,
                        hintText: 'Create password',
                        hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.45)),
                        contentPadding: const EdgeInsets.only(left: 14.5, top: -7),
                      ),
                    ),
                  ),
                  //#endregion
                  //#region Confirm password
                  Container(
                    margin: const EdgeInsets.only(top: 4.3),
                    height: 37,
                    decoration: BoxDecoration(color: const Color.fromRGBO(255, 255, 255, 0.09), borderRadius: BorderRadius.circular(5.37)),
                    child: TextFormField(
                      initialValue: '',
                      onChanged: (value) => setState(() {
                        confirmpassword = value;
                        status = 0;
                      }),
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.5)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        errorText: status == 2 ? "password do not match" : null,
                        errorStyle: TextStyle(fontSize: 8),
                        hintText: 'Repeat password',
                        hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.45)),
                        contentPadding: const EdgeInsets.only(left: 14.5, top: -7),
                      ),
                    ),
                  ),
                  //#endregion
                  //#region Register
                  Container(
                    width: width * 0.86,
                    height: 48.37,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.37),
                      color: const Color.fromRGBO(48, 35, 174, 1),
                    ),
                    margin: const EdgeInsets.only(top: 9),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => click(),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Register",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                  //#endregion
                ],
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String email = "";
  String password = "";
  int status = 0;

  void signin() async {
    status = 0;
    var response = await http.post(
      Uri.parse('https://fastapihackatonapi.herokuapp.com/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'email': email,
          'password': password,
        },
      ),
    );
    if (response.statusCode == 401) {
      status = 1;
    } else {
      Navigator.pushNamed(context, "/home", arguments: [jsonDecode(response.body)['access_token']]);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(3, 64, 156, 1),
              Color.fromRGBO(1, 0, 54, 1),
            ],
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 1),
            //#region Logo
            Container(
              alignment: Alignment.topCenter,
              width: width * 0.4,
              child: SvgPicture.asset('assets/image/logo.svg'),
            ),
            //#endregion
            Visibility(
              visible: height > 350,
              child: Container(
                margin: const EdgeInsets.only(top: 23),
                child: GestureDetector(
                  onTap: () => {},
                  child: Text(
                    'It`s good to see you again!',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 2),
            SizedBox(
              width: width * 0.86,
              child: Column(
                children: [
                  //#region Email
                  Container(
                    height: 37,
                    decoration: BoxDecoration(color: const Color.fromRGBO(255, 255, 255, 0.09), borderRadius: BorderRadius.circular(5.37)),
                    child: TextFormField(
                      initialValue: '',
                      onChanged: (value) {
                        setState(() {
                          email = value;
                          status = 0;
                        });
                      },
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.5)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.45)),
                        contentPadding: const EdgeInsets.only(left: 14.5, bottom: 9),
                      ),
                    ),
                  ),
                  //#endregion
                  //#region Password
                  Container(
                    margin: const EdgeInsets.only(top: 4.3),
                    height: 37,
                    decoration: BoxDecoration(color: const Color.fromRGBO(255, 255, 255, 0.09), borderRadius: BorderRadius.circular(5.37)),
                    child: TextFormField(
                      initialValue: '',
                      onChanged: (value) => setState(() {
                        password = value;
                        status = 0;
                      }),
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.5)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Create password',
                        hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.45)),
                        contentPadding: const EdgeInsets.only(left: 14.5, bottom: 9),
                      ),
                    ),
                  ),
                  //#endregion
                  //#region Sign in
                  Container(
                    width: width * 0.86,
                    height: 48.37,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.37),
                      color: const Color.fromRGBO(48, 35, 174, 1),
                    ),
                    margin: const EdgeInsets.only(top: 9),
                    child: GestureDetector(
                      onTap: () {
                        signin();
                        setState(() {});
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Sign In",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //#endregion
                  Visibility(
                    visible: status == 1,
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Incorrect email or password",
                        style: GoogleFonts.montserrat(fontSize: 10, color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //#region Back
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 36, left: width * 0.07),
              child: GestureDetector(
                onTap: () => {Navigator.pop(context)},
                child: Text(
                  'Back',
                  style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            //#endregion
            const Spacer(flex: 1)
          ],
        ),
      ),
    );
  }
}

class SignUpPageTwo extends StatefulWidget {
  const SignUpPageTwo({Key? key}) : super(key: key);

  @override
  _SignInTwoPageState createState() => _SignInTwoPageState();
}

class _SignInTwoPageState extends State<SignUpPageTwo> {
  String email = "";
  String password = "";
  String firstname = "";
  String lastname = "";
  String username = "";
  String job = "";
  int status = 0;

  void Regestration() async {
    if (username.trim() == "") {
      status = 1;
    } else if (username.contains(" ")) {
      status = 2;
    } else {
      var response = await http.post(
        Uri.parse('https://fastapihackatonapi.herokuapp.com/auth/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'email': email,
            'password': password,
            'username': username + "${Random().nextInt(9999)}",
            'job': job,
            'first_name': firstname,
            'last_name': lastname
          },
        ),
      );
      if (response.statusCode == 409) {
        Navigator.pop(context);
      } else {
        Navigator.pushNamed(context, "/home", arguments: [jsonDecode(response.body)['access_token']]);
      }
    }
  }

  String type = 'Student';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    email = args[0];
    password = args[1];

    double height = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(3, 64, 156, 1),
              Color.fromRGBO(1, 0, 54, 1),
            ],
          ),
        ),
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Column(
              children: [
                //#region Logo
                Container(
                  alignment: Alignment.topCenter,
                  width: width * 0.4,
                  child: SvgPicture.asset('assets/image/logo.svg'),
                ),
                //#endregion
                Visibility(
                  visible: height > 350,
                  child: Container(
                    margin: const EdgeInsets.only(top: 23),
                    child: GestureDetector(
                      onTap: () => {},
                      child: Text(
                        'The best solutions from the best team',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w300,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
            Container(
              alignment: Alignment.center,
              width: width * 0.86,
              child: Column(
                children: [
                  //#region Job
                  Container(
                    height: 37,
                    width: width * 0.86,
                    padding: const EdgeInsets.only(left: 14.33),
                    decoration: BoxDecoration(color: const Color.fromRGBO(255, 255, 255, 0.09), borderRadius: BorderRadius.circular(5.37)),
                    child: IgnorePointer(
                      ignoring: true,
                      child: DropdownButton<String>(
                        dropdownColor: Colors.black,
                        value: type,
                        underline: Container(),
                        icon: Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(right: 6),
                            child: const Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_drop_down)),
                          ),
                        ),
                        iconSize: 24,
                        elevation: 16,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(255, 255, 255, 0.45),
                          fontSize: 16,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            type = newValue!;
                          });
                        },
                        items: <String>['Student', 'Teacher', 'Other'].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  //#endregion
                  //#region First Name
                  Container(
                    margin: const EdgeInsets.only(top: 4.3),
                    height: 37,
                    decoration: BoxDecoration(color: const Color.fromRGBO(255, 255, 255, 0.09), borderRadius: BorderRadius.circular(5.37)),
                    child: TextFormField(
                      initialValue: '',
                      onChanged: (value) => setState(() {
                        firstname = value;
                        status = 0;
                      }),
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.5)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'First Name',
                        hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.45)),
                        contentPadding: const EdgeInsets.only(left: 14.5, bottom: 9),
                      ),
                    ),
                  ),
                  //#endregion
                  //#region Last Name
                  Container(
                    margin: const EdgeInsets.only(top: 4.3),
                    height: 37,
                    decoration: BoxDecoration(color: const Color.fromRGBO(255, 255, 255, 0.09), borderRadius: BorderRadius.circular(5.37)),
                    child: TextFormField(
                      initialValue: '',
                      onChanged: (value) => setState(() {
                        lastname = value;
                        status = 0;
                      }),
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.5)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Last Name',
                        hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.45)),
                        contentPadding: const EdgeInsets.only(left: 14.5, bottom: 9),
                      ),
                    ),
                  ),
                  //#endregion
                  //#region Username
                  Container(
                    margin: const EdgeInsets.only(top: 4.3),
                    height: 37,
                    decoration: BoxDecoration(color: const Color.fromRGBO(255, 255, 255, 0.09), borderRadius: BorderRadius.circular(5.37)),
                    child: TextFormField(
                      initialValue: '',
                      onChanged: (value) => setState(() {
                        username = value;
                        status = 0;
                      }),
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.5)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        errorText: status == 1
                            ? "enter username"
                            : status == 2
                                ? "incorrect username"
                                : null,
                        hintText: 'Create username',
                        hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.45)),
                        contentPadding: const EdgeInsets.only(left: 14.5, bottom: 9),
                      ),
                    ),
                  ),
                  //#endregion
                  //#region Start
                  Container(
                    width: width * 0.86,
                    height: 48.37,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.37),
                      color: const Color.fromRGBO(48, 35, 174, 1),
                    ),
                    margin: const EdgeInsets.only(top: 9),
                    child: GestureDetector(
                      onTap: () => Regestration(),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Start using FASA",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                  //#endregion
                ],
              ),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    String token = (ModalRoute.of(context)!.settings.arguments as List)[0].toString();

    PageController controller = PageController(initialPage: index);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(3, 64, 156, 1),
            Color.fromRGBO(1, 0, 54, 1),
          ],
        ),
      ),
      child: Scaffold(
        //#region Appbar
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 6, left: 10),
            child: Text(
              "Hi Egor!",
              style: GoogleFonts.montserrat(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          toolbarHeight: 100,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(
                Icons.notifications_outlined,
                size: 25,
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(top: 31, right: 22),
              width: 38,
              height: 38,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(19)),
              child: Image.asset("assets/image/acc.png"),
            )
          ],
        ),
        //#endregion
        backgroundColor: Colors.transparent,
        //#region BottomBar
        bottomNavigationBar: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 7), // changes position of shadow
              ),
            ],
          ),
          margin: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                child: Container(
                  margin: const EdgeInsets.only(top: 11, bottom: 11),
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: index == 0 ? const Color.fromRGBO(61, 68, 231, 1) : Colors.transparent, borderRadius: BorderRadius.circular(12)),
                  child: Icon(
                    Icons.home_rounded,
                    color: index == 0 ? Colors.white : const Color.fromRGBO(209, 209, 209, 1),
                  ),
                ),
                onTap: () => setState(
                  () {
                    index = 0;
                    controller.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                  },
                ),
              ),
              GestureDetector(
                child: Container(
                  margin: const EdgeInsets.only(top: 11, bottom: 11),
                  height: 45,
                  width: 45,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: index == 1 ? const Color.fromRGBO(61, 68, 231, 1) : Colors.transparent, borderRadius: BorderRadius.circular(12)),
                  child: SvgPicture.asset(
                    "assets/image/menu.svg",
                    color: index == 1 ? Colors.white : const Color.fromRGBO(209, 209, 209, 1),
                  ),
                ),
                onTap: () => setState(
                  () {
                    index = 1;
                    controller.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                  },
                ),
              ),
              GestureDetector(
                child: Container(
                  margin: const EdgeInsets.only(top: 11, bottom: 11),
                  height: 45,
                  width: 45,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: index == 2 ? const Color.fromRGBO(61, 68, 231, 1) : Colors.transparent, borderRadius: BorderRadius.circular(12)),
                  child: SvgPicture.asset(
                    "assets/image/menu3.svg",
                    color: index == 2 ? Colors.white : const Color.fromRGBO(209, 209, 209, 1),
                    height: 26,
                    width: 26,
                  ),
                ),
                onTap: () => setState(
                  () {
                    index = 2;
                    controller.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                  },
                ),
              ),
            ],
          ),
        ),
        //#endregion
        body: PageView(
          controller: controller,
          children: [
            Home1Page(),
            Home2Page(
              token: token,
            ),
            Home3Page(),
          ],
          onPageChanged: (i) => setState(() => index = i),
        ),
      ),
    );
  }
}

class Home1Page extends StatefulWidget {
  const Home1Page({Key? key}) : super(key: key);

  @override
  _Home1PageState createState() => _Home1PageState();
}

class _Home1PageState extends State<Home1Page> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: 146,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  margin: const EdgeInsets.only(left: 22),
                  height: 146,
                  width: 71,
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/addevent'),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 23),
                          alignment: Alignment.center,
                          height: 93,
                          width: 67,
                          decoration: BoxDecoration(color: const Color.fromRGBO(0, 0, 0, 0.24), borderRadius: BorderRadius.circular(13)),
                          child: const Icon(
                            Icons.add,
                            size: 24,
                            color: Color.fromRGBO(61, 68, 231, 1),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 9),
                          child: Text(
                            "Add event",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (index != 10) {
                return Container(
                  height: 146,
                  width: 71,
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 23),
                        alignment: Alignment.center,
                        height: 93,
                        width: 67,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage("assets/image/Background.png"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(13)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        height: 93,
                        width: 67,
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 22),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(
                                    "17:00",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "18/12/2021",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 62),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.schedule_rounded, color: Colors.white, size: 10),
                                  const SizedBox(width: 3),
                                  Text("7d:8Hr", style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.white))
                                ],
                              ),
                            ),
                            Container(
                              width: 8.5,
                              height: 8.5,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(69, 239, 54, 1),
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5.5)),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(
                                left: 13,
                              ),
                              width: 8.5,
                              height: 8.5,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(255, 33, 219, 1),
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5.5)),
                              child: const Icon(Icons.priority_high_rounded, size: 6, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        margin: const EdgeInsets.only(top: 127),
                        child: Text(
                          "Add event",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container(width: 0);
              }
            },
            separatorBuilder: (context, index) => Container(width: 20),
            itemCount: 11,
          ),
        ),
        Visibility(
          visible: height > 820,
          child: const Spacer(
            flex: 1,
          ),
        ),
        Visibility(
          visible: height > 820,
          child: Flexible(
            flex: 4,
            child: Container(
              width: width * 0.875,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 13, left: 15),
                    child: Image.asset(
                      "assets/image/weather.png",
                      height: 47 + height * 0.01,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 85),
                    child: Text(
                      "Weather 06.12.2021\n+21°, Windy",
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(2, 36, 111, 1),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: const EdgeInsets.only(top: 13, right: 18),
                    child: Text(
                      "21:37",
                      style: GoogleFonts.montserrat(
                        fontSize: 40,
                        fontWeight: FontWeight.w300,
                        color: const Color.fromRGBO(2, 36, 111, 1),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: const EdgeInsets.only(bottom: 21, left: 21, right: 21),
                    child: Text(
                      "Phrase of the day:\nЕврей не делает репосты потому что у него нет кнопки поделиться.",
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(2, 36, 111, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Flexible(
          flex: 4,
          child: Container(
            width: width * 0.875,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 58,
                    height: 58,
                    margin: const EdgeInsets.only(top: 19, right: 21),
                    child: Image.asset("assets/image/image1.png"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 21, left: 19),
                  child: Text(
                    "Weekly statistics:",
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(2, 36, 111, 1),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 55, left: 21),
                  child: Text(
                    "Tasks done 23",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(2, 36, 111, 1),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 75, left: 21),
                  child: Text(
                    "Tasks left 7",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(2, 36, 111, 1),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 95, left: 21),
                  child: Text(
                    "Tasks failed 17",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(2, 36, 111, 1),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(bottom: 20, left: 21),
                  child: Text(
                    "Your productivity is higher than N% of users.",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(2, 36, 111, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }
}

class Home2Page extends StatefulWidget {
  final String token;

  const Home2Page({Key? key, required this.token}) : super(key: key);

  @override
  _Home2PageState createState() => _Home2PageState();
}

class _Home2PageState extends State<Home2Page> {
  List<Future<Task>> items = [];

  void func() async {
    final response =
        await http.get(Uri.parse('https://fastapihackatonapi.herokuapp.com/task/all'), headers: {'Authorization': 'Bearer ${widget.token}'});
    print(jsonDecode(response.body)['tasks']);
    if (response.statusCode == 200) {
      List<dynamic> a = jsonDecode(response.body)['tasks'];
      for (var element in a) {
        items.add(
          fetchTask(element as Map<String, dynamic>),
        );
      }
    }
  }

  void add() async {
    var response = await http.post(
      Uri.parse('https://fastapihackatonapi.herokuapp.com/task/create'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${widget.token}'},
      body: jsonEncode(
        <String, String>{'name': "Task1", 'deadline': "${DateTime.utc(2021, 12, 06)}", 'hashtags': "[]"},
      ),
    );
    // print(response.)
  }

  Future<Task> fetchTask(Map<String, dynamic> el) async {
    return Task.fromJson(el);
  }

  @override
  Widget build(BuildContext context) {
    add();
    func();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: height,
          width: width * 0.870,
          margin: EdgeInsets.symmetric(
            horizontal: width * 0.065,
          ),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              if (index != 5) {
                return Container(
                  padding: index == 0 ? const EdgeInsets.only(top: 70) : EdgeInsets.zero,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        height: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 18, left: 15),
                        child: Text(
                          "Labortornaya",
                          style: GoogleFonts.montserrat(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(2, 36, 111, 1),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 41, left: 15),
                        child: Text(
                          "The numbers from the textbook\nAntiDemidovich\n13.5, 13.6, 15.1, 18.1-5",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(2, 36, 111, 1),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.only(right: 11),
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(69, 239, 54, 1),
                              border: Border.all(color: Colors.white, width: 2.5),
                              borderRadius: BorderRadius.circular(9)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.only(right: 34),
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 33, 219, 1),
                              border: Border.all(color: Colors.white, width: 2.5),
                              borderRadius: BorderRadius.circular(9)),
                          child: const Icon(Icons.priority_high_rounded, size: 8, color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 115, left: 15),
                        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 7),
                        decoration: BoxDecoration(color: const Color.fromRGBO(182, 211, 255, 1), borderRadius: BorderRadius.circular(3)),
                        child: Text(
                          "#algebra Tuesday Denisenko",
                          style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w600, color: const Color.fromRGBO(27, 118, 253, 1)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 145),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 21),
                              decoration: BoxDecoration(color: const Color.fromRGBO(182, 255, 198, 1), borderRadius: BorderRadius.circular(3)),
                              child: Text(
                                "task done",
                                style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w600, color: const Color.fromRGBO(0, 220, 62, 1)),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 21),
                              decoration: BoxDecoration(color: const Color.fromRGBO(254, 255, 182, 1), borderRadius: BorderRadius.circular(3)),
                              child: Text(
                                "cancel task",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromRGBO(220, 211, 0, 1),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.schedule_rounded,
                                  size: 10,
                                  color: Color.fromRGBO(69, 239, 54, 1),
                                ),
                                Text("7d:8Hr", style: GoogleFonts.roboto(fontWeight: FontWeight.w400, color: const Color.fromRGBO(69, 239, 54, 1)))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        height: 170,
                        width: width * 1,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage("assets/image/image2.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.only(right: 11),
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(69, 239, 54, 1),
                              border: Border.all(
                                color: Color.fromRGBO(3, 30, 54, 1),
                                width: 2.5,
                              ),
                              borderRadius: BorderRadius.circular(9)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.only(right: 34),
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 33, 219, 1),
                              border: Border.all(
                                color: Color.fromRGBO(3, 30, 54, 1),
                                width: 2.5,
                              ),
                              borderRadius: BorderRadius.circular(9)),
                          child: const Icon(Icons.priority_high_rounded, size: 8, color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 140, left: 15),
                        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(250, 252, 173, 1),
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(250, 252, 173, 1),
                              spreadRadius: 0,
                              blurRadius: 7,
                              offset: Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Text(
                          "Time to rest",
                          style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w600, color: const Color.fromRGBO(228, 193, 7, 1)),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
            itemCount: 10,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(61, 68, 231, 1),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(horizontal: width * 0.041),
          height: 51,
          width: width * 0.918,
          child: Center(
            child: Text(
              "Daily recommendations",
              style: GoogleFonts.montserrat(fontSize: 28, fontWeight: FontWeight.w400, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}

class Home3Page extends StatefulWidget {
  const Home3Page({Key? key}) : super(key: key);

  @override
  _Home3PageState createState() => _Home3PageState();
}

class _Home3PageState extends State<Home3Page> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: height,
          width: width * 0.870,
          margin: EdgeInsets.symmetric(
            horizontal: width * 0.065,
          ),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => Container(
              padding: index == 0 ? const EdgeInsets.only(top: 70) : EdgeInsets.zero,
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    height: 147,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 18, left: 15),
                    child: Text(
                      "Labortornaya",
                      style: GoogleFonts.montserrat(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(2, 36, 111, 1),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 41, left: 15),
                    child: Text(
                      "The numbers from the textbook\nAntiDemidovich\n13.5, 13.6, 15.1, 18.1-5",
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(2, 36, 111, 1),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 11),
                      width: 17,
                      height: 17,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(69, 239, 54, 1),
                          border: Border.all(color: Colors.white, width: 2.5),
                          borderRadius: BorderRadius.circular(9)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 34),
                      width: 17,
                      height: 17,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 33, 219, 1),
                          border: Border.all(color: Colors.white, width: 2.5),
                          borderRadius: BorderRadius.circular(9)),
                      child: const Icon(Icons.priority_high_rounded, size: 8, color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 124, left: 15),
                    padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 7),
                    decoration: BoxDecoration(color: const Color.fromRGBO(182, 211, 255, 1), borderRadius: BorderRadius.circular(3)),
                    child: Text(
                      "#algebra",
                      style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: const Color.fromRGBO(27, 118, 253, 1)),
                    ),
                  ),
                  Builder(builder: (BuildContext context) {
                    if (index % 3 == 0) {
                      return Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.only(top: 23, right: 10),
                          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 7),
                          decoration: BoxDecoration(color: const Color.fromRGBO(255, 208, 182, 1), borderRadius: BorderRadius.circular(3)),
                          child: Text(
                            "Task not completed",
                            style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: const Color.fromRGBO(220, 79, 0, 1)),
                          ),
                        ),
                      );
                    } else if (index % 3 == 1) {
                      return Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.only(top: 23, right: 10),
                          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 7),
                          decoration: BoxDecoration(color: const Color.fromRGBO(254, 255, 182, 1), borderRadius: BorderRadius.circular(3)),
                          child: Text(
                            "Task canceled",
                            style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: const Color.fromRGBO(220, 211, 0, 1)),
                          ),
                        ),
                      );
                    } else {
                      return Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.only(top: 23, right: 10),
                          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 7),
                          decoration: BoxDecoration(color: const Color.fromRGBO(182, 255, 198, 1), borderRadius: BorderRadius.circular(3)),
                          child: Text(
                            "Task completed",
                            style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: const Color.fromRGBO(0, 220, 62, 1)),
                          ),
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
            itemCount: 10,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(61, 68, 231, 1),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(horizontal: width * 0.041),
          height: 51,
          width: width * 0.918,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 4, left: 22),
                child: Text(
                  "Task story",
                  style: GoogleFonts.montserrat(fontSize: 28, fontWeight: FontWeight.w400, color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 12, right: 24),
                child: Text(
                  "32",
                  style: GoogleFonts.montserrat(fontSize: 28, fontWeight: FontWeight.w400, color: Colors.white),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(3, 64, 156, 1),
              Color.fromRGBO(1, 0, 54, 1),
            ],
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 1),
            Column(
              children: [
                //#region Logo
                Container(
                  alignment: Alignment.topCenter,
                  width: width * 0.4,
                  child: SvgPicture.asset('assets/image/logo.svg'),
                ),
                //#endregion
                Visibility(
                  visible: height > 350,
                  child: Container(
                    margin: const EdgeInsets.only(top: 23),
                    child: Text(
                      "The best solutions from the best team",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Spacer(flex: 2),
            Container(
              alignment: Alignment.center,
              width: width * 0.86,
              child: Column(
                children: [
                  //#region Name
                  Container(
                    height: 37,
                    decoration: BoxDecoration(color: const Color.fromRGBO(255, 255, 255, 0.09), borderRadius: BorderRadius.circular(5.37)),
                    child: TextFormField(
                      initialValue: '',
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.5)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Event Name',
                        hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.45)),
                        contentPadding: const EdgeInsets.only(left: 14.5, bottom: 9),
                      ),
                    ),
                  ),
                  //#endregion
                  //#region Note
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/eventnote'),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      margin: const EdgeInsets.only(top: 4.3),
                      padding: const EdgeInsets.only(left: 14.5, bottom: 9),
                      height: 37,
                      width: width * 0.86,
                      decoration: BoxDecoration(color: const Color.fromRGBO(255, 255, 255, 0.09), borderRadius: BorderRadius.circular(5.37)),
                      child: Text(
                        "Note",
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.5)),
                      ),
                    ),
                  ),
                  //#endregion
                  //#region Hashtags
                  Container(
                    height: 37,
                    margin: const EdgeInsets.only(top: 4.3),
                    decoration: BoxDecoration(color: const Color.fromRGBO(255, 255, 255, 0.09), borderRadius: BorderRadius.circular(5.37)),
                    child: TextFormField(
                      initialValue: '',
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.5)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '#Hashtags',
                        hintStyle: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(255, 255, 255, 0.45),
                        ),
                        contentPadding: const EdgeInsets.only(left: 14.5, bottom: 10, right: 12),
                        suffixText: 'one at least',
                        suffixStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.45)),
                      ),
                    ),
                  ),
                  //#endregion
                  //#region Deadline
                  Container(
                    margin: const EdgeInsets.only(top: 4.3),
                    height: 37,
                    decoration: BoxDecoration(color: const Color.fromRGBO(255, 255, 255, 0.09), borderRadius: BorderRadius.circular(5.37)),
                    child: TextFormField(
                      initialValue: '',
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.5)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Choose deadline time',
                        hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.45)),
                        contentPadding: const EdgeInsets.only(left: 14.5, bottom: 9),
                      ),
                    ),
                  ),
                  //#endregion
                  //#region Next
                  Container(
                    width: width * 0.86,
                    height: 48.37,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.37),
                      color: const Color.fromRGBO(48, 35, 174, 1),
                    ),
                    margin: const EdgeInsets.only(top: 9),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.pushNamed(context, '/addevent2'),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Next step",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                  //#endregion
                ],
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}

class AddEventPage2 extends StatefulWidget {
  const AddEventPage2({Key? key}) : super(key: key);

  @override
  _AddEventPage2State createState() => _AddEventPage2State();
}

class _AddEventPage2State extends State<AddEventPage2> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(3, 64, 156, 1),
              Color.fromRGBO(1, 0, 54, 1),
            ],
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 1),
            Column(
              children: [
                //#region Logo
                Container(
                  alignment: Alignment.topCenter,
                  width: width * 0.4,
                  child: SvgPicture.asset('assets/image/logo.svg'),
                ),
                //#endregion
                Visibility(
                  visible: height > 350,
                  child: Container(
                    margin: const EdgeInsets.only(top: 23),
                    child: Text(
                      "The best solutions from the best team",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Spacer(flex: 2),
            Container(
              alignment: Alignment.center,
              width: width * 0.86,
              child: Column(
                children: [
                  //#region Name
                  DropdownButtonFormField(
                    onChanged: (i) {},
                    onTap: () {},
                    value: 0,
                    decoration: const InputDecoration(
                      contentPadding: const EdgeInsets.all(0.0),
                    ),
                    items: [
                      DropdownMenuItem<int>(
                        value: 0,
                        child: Container(
                          width: 100,
                          child: const Text(
                            "less character",
                          ),
                        ),
                      ),
                      DropdownMenuItem<int>(
                        value: 1,
                        child: Container(
                          width: 100,
                          child: const Text(
                            "mooooorrrrreeee character",
                          ),
                        ),
                      ),
                    ],
                  ),
                  //#endregion
                  //#region Note
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/eventnote'),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      margin: const EdgeInsets.only(top: 4.3),
                      padding: const EdgeInsets.only(left: 14.5, bottom: 9),
                      height: 37,
                      width: width * 0.86,
                      decoration: BoxDecoration(color: const Color.fromRGBO(255, 255, 255, 0.09), borderRadius: BorderRadius.circular(5.37)),
                      child: Text(
                        "Note",
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.5)),
                      ),
                    ),
                  ),
                  //#endregion
                  //#region Hashtags
                  Container(
                    height: 37,
                    margin: const EdgeInsets.only(top: 4.3),
                    decoration: BoxDecoration(color: const Color.fromRGBO(255, 255, 255, 0.09), borderRadius: BorderRadius.circular(5.37)),
                    child: TextFormField(
                      initialValue: '',
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.5)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '#Hashtags',
                        hintStyle: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(255, 255, 255, 0.45),
                        ),
                        contentPadding: const EdgeInsets.only(left: 14.5, bottom: 10, right: 12),
                        suffixText: 'one at least',
                        suffixStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.45)),
                      ),
                    ),
                  ),
                  //#endregion
                  //#region Deadline
                  Container(
                    margin: const EdgeInsets.only(top: 4.3),
                    height: 37,
                    decoration: BoxDecoration(color: const Color.fromRGBO(255, 255, 255, 0.09), borderRadius: BorderRadius.circular(5.37)),
                    child: TextFormField(
                      initialValue: '',
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.5)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Choose deadline time',
                        hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.45)),
                        contentPadding: const EdgeInsets.only(left: 14.5, bottom: 9),
                      ),
                    ),
                  ),
                  //#endregion
                  //#region Register
                  Container(
                    width: width * 0.86,
                    height: 48.37,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.37),
                      color: const Color.fromRGBO(48, 35, 174, 1),
                    ),
                    margin: const EdgeInsets.only(top: 9),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.pushNamed(context, '/signuptwo'),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Next step",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                  //#endregion
                ],
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}

class EventNotePage extends StatefulWidget {
  const EventNotePage({Key? key}) : super(key: key);

  @override
  _EventNotePageState createState() => _EventNotePageState();
}

class _EventNotePageState extends State<EventNotePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(3, 64, 156, 1),
              Color.fromRGBO(1, 0, 54, 1),
            ],
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 2),
            Column(
              children: [
                //#region Logo
                Container(
                  alignment: Alignment.topCenter,
                  width: width * 0.4,
                  child: SvgPicture.asset('assets/image/logo.svg'),
                ),
                //#endregion
                Visibility(
                  visible: height > 350,
                  child: Container(
                    margin: const EdgeInsets.only(top: 23),
                    child: Text(
                      "The best solutions from the best team",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Spacer(flex: 1),
            //#region Note
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.05),
              height: height * 0.3,
              decoration: BoxDecoration(color: const Color.fromRGBO(255, 255, 255, 0.09), borderRadius: BorderRadius.circular(5.37)),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                initialValue: '',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.5)),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note',
                  hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color.fromRGBO(255, 255, 255, 0.45)),
                  contentPadding: const EdgeInsets.all(10),
                ),
              ),
            ),
            //#endregion
            const Spacer(flex: 4),
            //#region Back
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(bottom: 39, left: 26),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  'Save and return',
                  style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            //#endregion
          ],
        ),
      ),
    );
  }
}
