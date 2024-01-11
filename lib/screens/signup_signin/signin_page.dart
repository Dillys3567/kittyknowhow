import 'package:flutter/material.dart';
import 'package:kittyknowhow/components/custom_signup_button.dart';
import 'package:kittyknowhow/components/form_input_field.dart';
import 'package:kittyknowhow/functions_and_apis/user_info.dart';
import 'package:kittyknowhow/screens/home/home_container.dart';
import 'package:kittyknowhow/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;
  bool tap = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  Future<void> _signIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = true;
    });
    try {
      await supabase.auth
          .signInWithPassword(email: _email.text, password: _password.text);
      sharedPreferences.setString('name', await getUsername());
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomeContainer();
      }));
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (e) {
      context.showErrorSnackBar(message: "Unexpected error occurred");
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(-1514516),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Time to learn and share!",
                style: signupButtonText,
              ),
              SizedBox(
                height: 25,
              ),
              FormInputField(
                label: 'Email',
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                showIcon: false,
                validator: (val) {},
              ),
              SizedBox(
                height: 15,
              ),
              FormInputField(
                obscureText: tap,
                label: 'Password',
                controller: _password,
                keyboardType: TextInputType.text,
                showIcon: true,
                suffixIcon: IconButton(
                    color: Color(-6656375),
                    onPressed: () {
                      setState(() {
                        tap = !tap;
                      });
                    },
                    icon: (tap)
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off)),
                validator: (val) {},
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
              ),
              CustomSignUpButton(
                  buttonText: _isLoading ? "...loading" : "Submit",
                  functionCall: _isLoading ? null : _signIn)
            ],
          )),
        ),
      ),
    );
  }
}
