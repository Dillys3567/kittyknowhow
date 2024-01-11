import 'package:flutter/material.dart';
import 'package:kittyknowhow/screens/home/home_container.dart';
import 'package:kittyknowhow/screens/signup_signin/signup_signin.dart';
import 'package:kittyknowhow/utils/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    final session = supabase.auth.currentSession;
    if (session == null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SignUpSignInPage();
      }));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomeContainer();
      }));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Color(-6656375),
        ),
      ),
    );
  }
}
