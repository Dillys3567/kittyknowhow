import 'package:flutter/material.dart';
import 'package:kittyknowhow/components/custom_signup_button.dart';
import 'package:kittyknowhow/components/form_input_field.dart';
import 'package:kittyknowhow/functions_and_apis/pet.dart';
import 'package:kittyknowhow/screens/home/home_container.dart';
import 'package:kittyknowhow/utils/constants.dart';
import 'package:kittyknowhow/models/pet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool tap = false;
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  List<Pet> pets = [];
  bool offstage = true;
  TextEditingController _password = TextEditingController();
  TextEditingController petName = TextEditingController();
  TextEditingController breed = TextEditingController();
  TextEditingController age = TextEditingController();
  final _userFormKey = GlobalKey<FormState>();
  final _petFormKey = GlobalKey<FormState>();

  bool _isLoading = false;

  Future<void> _signUp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final isValid = _userFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else if (pets.isEmpty) {
      context.showErrorSnackBar(message: "You must enter at least one pet");
      return;
    }
    final email = _email.text;
    final password = _password.text;
    final name = _name.text;
    setState(() {
      _isLoading = true;
    });
    try {
      await supabase.auth
          .signUp(email: email, password: password, data: {'name': name});
      final user_id = await supabase.auth.currentUser!.id;
      for (Pet pet in pets) {
        await addPet(user_id, pet.petName, pet.breed, pet.age);
      }
      sharedPreferences.setString('name', name);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomeContainer();
      }));
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: "Unexpected error");
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _validatePetForm() {
    final isValid = _petFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      pets.add(Pet(petName: petName.text, breed: breed.text, age: age.text));
      petName.clear();
      breed.clear();
      age.clear();
      offstage = !offstage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(-1514516),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Text(
                    "Let's get started!",
                    style: signupButtonText,
                  ),
                ),
                Form(
                  key: _userFormKey,
                  child: Column(
                    children: [
                      FormInputField(
                        label: 'Your name',
                        controller: _name,
                        keyboardType: TextInputType.text,
                        showIcon: false,
                        validator: (val) {
                          if (val == null || val!.isEmpty) {
                            return 'Please provide a name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      FormInputField(
                        label: 'Email',
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        showIcon: false,
                        validator: (val) {
                          if (val == null || val!.isEmpty) {
                            return 'Email required';
                          }
                          return null;
                        },
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
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Password required';
                          }
                          if (val.length < 6) {
                            return 'Must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomSignUpButton(
                          buttonText: (_isLoading) ? "...loading" : "Submit",
                          functionCall: _isLoading ? null : _signUp),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Offstage(
                  offstage: offstage,
                  child: Form(
                    key: _petFormKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        FormInputField(
                          label: "Pet's name",
                          controller: petName,
                          keyboardType: TextInputType.text,
                          showIcon: false,
                          validator: (val) {
                            if (val == null || val!.isEmpty) {
                              return 'Please provide a name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FormInputField(
                          label: "Pet's breed",
                          controller: breed,
                          keyboardType: TextInputType.text,
                          showIcon: false,
                          validator: (val) {
                            if (val == null || val!.isEmpty) {
                              return 'Please provide the breed';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FormInputField(
                          label: "Pet's age",
                          controller: age,
                          keyboardType: TextInputType.number,
                          showIcon: false,
                          validator: (val) {
                            if (val == null || val!.isEmpty) {
                              return 'Please provide age';
                            }
                            if (int.parse(val) == null) {
                              return 'Invalid age';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                (offstage)
                    ? CustomSignUpButton(
                        buttonText: "Add a Pet",
                        functionCall: () {
                          setState(() {
                            offstage = !offstage;
                          });
                        })
                    : CustomSignUpButton(
                        buttonText: "Add", functionCall: _validatePetForm),
                Container(
                  child: Column(children: [
                    for (Pet pet in pets)
                      Card(
                        child: ListTile(
                          isThreeLine: true,
                          title: Text(
                            'Name: ${pet.petName}',
                            style: smallSignUpText,
                          ),
                          subtitle: Text(
                            'Breed: ${pet.breed}\nAge: ${pet.age}',
                            style: smallSignUpText,
                          ),
                        ),
                      ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
