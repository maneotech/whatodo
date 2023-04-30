import 'package:flutter/material.dart';
import 'package:whatodo/constants/constant.dart';

class SignupTextInput extends StatefulWidget {
  final String title;
  final String label;
  final bool isPassword;
  final TextEditingController controller;

  const SignupTextInput(
      {super.key,
      required this.title,
      required this.label,
      required this.isPassword,
      required this.controller});

  @override
  State<SignupTextInput> createState() => _SignupTextInputState();
}

class _SignupTextInputState extends State<SignupTextInput> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword ? true: false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: Constants.signupTitle),
          TextFormField(
            controller: widget.controller,
            obscureText: _obscureText,
            decoration: InputDecoration(
              suffixIcon: getSuffixIcon(),
              labelText: widget.label,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: const OutlineInputBorder(),
            ),
          )
        ],
      ),
    );
  }

  IconButton getSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: const Icon(Icons.visibility, color: Colors.grey,),
        onPressed: () => onClickVisibility(),
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => onDelete(),
      );
    }
  }

  onClickVisibility(){
    setState(() {
      _obscureText = !_obscureText;
    }); 
  }

  onDelete() {
    widget.controller.text = "";
  }
}
