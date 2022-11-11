import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';

class Screen1 extends StatelessWidget {
  Screen1({Key? key}) : super(key: key);
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/screen2',
                      arguments: Screen2(message: controller.text));
                },
                child: Text('Submit'))
          ],
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  Screen2({Key? key, required this.message}) : super(key: key);
  String message;
  @override
  Widget build(BuildContext context) {
    print(message);

    final args = ModalRoute.of(context)!.settings.arguments as Screen2;
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(args.message),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/screen1');
                },
                child: Text('GetMessage')),
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello'),
      ),
      body: const Center(
        child: Text('Concurrency example'),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Ifo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name:',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  'Pardeep Kumar',
                  style: Theme.of(context).textTheme.headline3,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Roll No.:',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  '19SW37',
                  style: Theme.of(context).textTheme.headline3,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Department:',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  'Software Engineering',
                  style: Theme.of(context).textTheme.headline3,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Batch:',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  '19SW',
                  style: Theme.of(context).textTheme.headline3,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Domicile:',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  'Sanghar',
                  style: Theme.of(context).textTheme.headline3,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FormValidation extends StatefulWidget {
  FormValidation({Key? key}) : super(key: key);

  @override
  State<FormValidation> createState() => _FormValidationState();
}

class _FormValidationState extends State<FormValidation> {
  final _formKey = GlobalKey<FormState>();
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  var name = '';
  var cast = '';
  var city = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Validation'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller1,
                    decoration: InputDecoration(
                      hintText: 'Enter Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: controller2,
                    decoration: InputDecoration(
                      hintText: 'Enter Cast',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: controller3,
                    decoration: InputDecoration(
                      hintText: 'Enter City',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your City';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            name = controller1.text;
                            cast = controller2.text;
                            city = controller3.text;
                          });
                        }
                      },
                      child: Text('Show Data')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name:',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        name,
                        style: Theme.of(context).textTheme.headline3,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cast:',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        cast,
                        style: Theme.of(context).textTheme.headline3,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'City',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        city,
                        style: Theme.of(context).textTheme.headline3,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late FocusNode _focusNode;
  bool passwordVisibility = false;
  bool isValueEmpty = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                SizedBox(height: height * 0.1),
                const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.02),
                const Text(
                  "Sign in to your account",
                  style: TextStyle(
                    fontSize: 16,
                    //fontWeight: FontWeight.w300
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.04),

                //New password input form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: width * 0.13),
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(_focusNode);
                          },
                          controller: emailController,
                          // obscureText: !passwordVisibility,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            alignLabelWithHint: true,
                            labelText: 'Email',
                            hintText: "abc@gmail.com",
                            hintStyle: TextStyle(color: Colors.grey),
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Email';
                            }

                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      //
                      //
                      // password input form
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: width * 0.13),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: !passwordVisibility,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () => setState(
                                () => passwordVisibility = !passwordVisibility,
                              ),
                              child: Icon(
                                passwordVisibility
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 20,
                              ),
                            ),
                            border: const UnderlineInputBorder(),
                            labelText: 'password',
                            focusColor: Colors.blue,
                            labelStyle: const TextStyle(color: Colors.black),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.035),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Forget password?",
                      style: TextStyle(
                        fontSize: 13,
                        //fontWeight: FontWeight.w300
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                //
                //
                //Button
                Center(
                  child: Container(
                    width: 260,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(45)),
                    child: RawMaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserInfo()));
                        }
                        //  }
                      },
                      splashColor: Colors.white.withOpacity(0.2),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            letterSpacing: 1.7),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImageShow extends StatefulWidget {
  ImageShow({Key? key}) : super(key: key);

  @override
  State<ImageShow> createState() => _ImageShowState();
}

class _ImageShowState extends State<ImageShow> {
  double _scale = 1.0;
  double _previousScale = 0;
  int value = 0;
  List<String> list = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/330px-Image_created_with_a_mobile_phone.png',
    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
    'https://cdn.searchenginejournal.com/wp-content/uploads/2022/06/image-search-1600-x-840-px-62c6dc4ff1eee-sej-1520x800.png'
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxXnC3fwMwkbIt3ejGRIw3NmbDyUtgS5g2jA&usqp=CAU',
    'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ImageViewer'),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (MediaQuery.of(context).orientation == Orientation.portrait) {
          if (value < 4) {
            value = value + 1;
          }
          return Image.network(
            list[value],
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          );
        } else {
          if (value > 0) {
            value = value - 1;
          }
          print('hello');
          return Image.network(
            list[value],
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          );
        }
      }),
      // GestureDetector(
      //   onScaleStart: (ScaleStartDetails details) {
      //     print(details);
      //     // Does this need to go into setState, too?
      //     // We are only saving the scale from before the zooming started
      //     // for later - this does not affect the rendering...
      //     _previousScale = _scale;
      //   },
      //   onScaleUpdate: (ScaleUpdateDetails details) {
      //     print(details);
      //     setState(() => _scale = _previousScale * details.scale);
      //   },
      //   onScaleEnd: (ScaleEndDetails details) {
      //     print(details);
      //     // See comment above
      //     _previousScale = 0;
      //   },
      //   onPanUpdate: (DragUpdateDetails details) {
      //     if (details.delta.dx > 0) {
      //       print('swip right');
      //       setState(() {
      //         if (value < 2) {
      //           value = value + 1;
      //         }
      //         print(value);
      //       });
      //     } else if (details.delta.dx < 0) {
      //       print('swip left');
      //       setState(() {
      //         if (value > 0) {
      //           value = value - 1;
      //         }
      //         print(value);
      //       });
      //     }
      //   },
      //   child: Transform(
      //     transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
      //     alignment: FractionalOffset.center,
      //     child: Image.network(
      //       list[value],
      //       width: MediaQuery.of(context).size.width,
      //       height: MediaQuery.of(context).size.height,
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      // ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late FocusNode _focusNode1;
  late FocusNode _focusNode2;
  late FocusNode _focusNode3;

  bool passwordVisibility = false;
  bool cpasswordVisibility = false;
  bool isValuesEmpty = false;
  bool isPasswordMatch = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _focusNode1 = FocusNode();
    _focusNode2 = FocusNode();
    _focusNode3 = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return _isLoading
        ? Scaffold(
            body: Center(
              child: Image.asset('assets/loading1.gif'),
            ),
          )
        : Scaffold(
            // resizeToAvoidBottomInset: false,
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Colors.grey.shade100,
              elevation: 0,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: height * 0.1),
                    const Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * 0.02),
                    const Text(
                      "Sign up for a new funotel account",
                      style: TextStyle(
                        fontSize: 14,
                        //  fontWeight: FontWeight.w300
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * 0.04),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: width * 0.13),
                            child: TextFormField(
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_focusNode1);
                              },
                              controller: _nameController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                alignLabelWithHint: true,
                                labelText: 'Name',
                                hintText: "ABC",
                                hintStyle: TextStyle(color: Colors.grey),
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Name';
                                } else if (!value.contains(RegExp(
                                    '^[a-zA-Z0-9_]+( [a-zA-Z0-9_]+)*\$'))) {
                                  return 'Please Enter a Valid Name';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          //New password input form
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: width * 0.13),
                            child: TextFormField(
                              focusNode: _focusNode1,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_focusNode2);
                              },
                              controller: emailController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                alignLabelWithHint: true,
                                labelText: 'Email',
                                hintText: "abc@gmail.com",
                                hintStyle: TextStyle(color: Colors.grey),
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Email';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          //
                          //
                          // password input form
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: width * 0.13),
                            child: TextFormField(
                              focusNode: _focusNode2,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_focusNode3);
                              },
                              controller: passwordController,
                              obscureText: !passwordVisibility,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => passwordVisibility =
                                        !passwordVisibility,
                                  ),
                                  child: Icon(
                                    passwordVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: 20,
                                  ),
                                ),
                                border: const UnderlineInputBorder(),
                                labelText: 'Password',
                                focusColor: Colors.blue,
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Password';
                                }
                                return null;
                              },
                            ),
                          ),

                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: width * 0.13),
                              child: TextFormField(
                                focusNode: _focusNode3,
                                // onFieldSubmitted: (value){
                                //   FocusScope.of(context).requestFocus(_focusNode);
                                // },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter password to confirm';
                                  } else if (!(value ==
                                      passwordController.text)) {
                                    return 'Password does not match';
                                  }
                                  return null;
                                },
                                controller: cpasswordController,
                                obscureText: !cpasswordVisibility,
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => cpasswordVisibility =
                                          !cpasswordVisibility,
                                    ),
                                    child: Icon(
                                      cpasswordVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      size: 20,
                                    ),
                                  ),
                                  border: const UnderlineInputBorder(),
                                  labelText: 'Confirm Password',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Center(
                      child: Container(
                        width: 260,
                        height: height * 0.06,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(45)),
                        child: RawMaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            }
                          },
                          splashColor: Colors.white.withOpacity(0.2),
                          child: const Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                letterSpacing: 1.7),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                  ],
                ),
              ),
            ),
          );
  }
}
