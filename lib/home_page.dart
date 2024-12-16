import 'package:auto_open/input_decoration.dart';
import 'package:auto_start_permission/auto_start_permission.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _keyForm = GlobalKey<FormState>();
  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final TextEditingController _passTextEditingController =
      TextEditingController();

  bool _isAutoStartPermissionAvailable = false;

  var _autoStartPermissionState = AutoStartPermissionState.noInfo;

  void onSubmit() {
    if (_keyForm.currentState!.validate()) {}
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passTextEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    AutoStartPermission.instance.isAutoStartPermissionAvailable().then((val) {
      if (val) {
        _checkPermissionStatus();
      }
    });
  }

  void _checkPermissionStatus() {
    AutoStartPermission.instance.checkAutoStartState().then(
      (value) {
        if (value == AutoStartPermissionState.disabled) {}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: null,
      body: Form(
        key: _keyForm,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 20,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    boxShadow: kElevationToShadow[2],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.person_outline_sharp,
                    size: 45,
                    color: Colors.grey,
                  ),
                ),
              ),
              TextFormField(
                  controller: _emailTextEditingController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email.';
                    }
                    return null;
                  },
                  decoration: inputDecoration('Email')),
              TextFormField(
                  controller: _passTextEditingController,
                  obscureText: true,
                  obscuringCharacter: '*',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password.';
                    }
                    return null;
                  },
                  decoration: inputDecoration('Password')),
              SizedBox(
                  width: size.width,
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 2,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurple),
                      onPressed: () => onSubmit(),
                      child: Text('Login')))
            ],
          ),
        ),
      ),
    );
  }
}
