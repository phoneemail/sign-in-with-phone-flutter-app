import 'package:flutter/material.dart';
import 'package:phone_email/screens/auth_screen.dart';
import 'package:phone_email/screens/email_list_screen.dart';
import 'package:phone_email/utils/app_services.dart';
import 'package:phone_email/widgets/sign_in_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phone Email',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 4, 201, 135),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? jwtToken;
  bool isUserLoggedIn = false;
  String totalEmailCount = '';
  String phoneNumner = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Phone Email'),
      ),
      body: Center(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : isUserLoggedIn
                ? Center(
                    child: Container(
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                        color:
                            Color.fromARGB(255, 4, 201, 135).withOpacity(0.2),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'You are logged in with',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            phoneNumner,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isUserLoggedIn = false;
                              });
                            },
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SignInButton(
                    onPressed: () {
                      /*
                  * Navigate to the authentication webview
                  * */
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return AuthScreen();
                          },
                        ),
                      ).then((value) {
                        /*
                        * Check if user perform login and get token
                        * OR only close the screen
                        * Also check data pop back from screen
                        * */
                        if (value != null && (value is Map)) {
                          jwtToken = value['jwtToken'];

                          /// Check token is not expired and valid
                          if (AppService.isValidJwtToken(jwtToken!)) {
                            setState(() {
                              isLoading = true;
                            });
                            AppService.getLoginUserEmailCount(
                              jwtToken!,
                              onEmailCount: (phoneNumber, count) {
                                isUserLoggedIn = true;
                                phoneNumner = phoneNumber;
                                totalEmailCount = count;
                                isLoading = false;
                                setState(() {});
                              },
                            );
                          } else {
                            setState(() {
                              isUserLoggedIn = false;
                            });
                          }
                        }
                      });
                    },
                  ),
      ),
      floatingActionButton: isUserLoggedIn
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return EmailListScreen();
                    },
                  ),
                );
              },
              child: Stack(
                children: [
                  Icon(
                    Icons.mail_outline_rounded,
                    color: Colors.black,
                    size: 40,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Center(
                        child: Text(
                          '$totalEmailCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Offstage(),
    );
  }
}
