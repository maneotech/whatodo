import 'package:flutter/material.dart';
import 'package:whatodo/components/app_bar.dart';
import 'package:whatodo/services/toast.dart';

import '../components/action_button.dart';
import '../components/signup_textinput.dart';
import '../constants/constant.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  TextEditingController controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Gagnez un jeton gratuit!",
                style: Constants.signupTitle),
            const Text("C'est facile!"),
            const Text("1. Saisissez l'adresse email de votre ami"),
            const Text("2. Cliquez sur 'Inviter cet ami'"),
            const Text(
                "3. Une fois votre ami inscrit avec cette adresse email, vous êtes notifié et vous gagnez un jeton!"),
            SignupTextInput(
                title: "Email",
                label: "Entrez l'email de votre ami",
                isPassword: false,
                controller: controllerEmail),
            ActionButton(
              title: "Inviter cet ami",
              onTap: () => invitUser(),
            )
          ],
        ),
      ),
    );
  }

  invitUser() {
    String email = controllerEmail.text;
    if (email.isEmpty) {
      ToastService.showError("Veuillez saisir l'email de votre ami");
      return;
    } else if (RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email) ==
        false) {
      ToastService.showError("L'email saisi n'est pas conforme");
      return;
    } else {
      ToastService.showSuccess(
          "Inscription de votre ami en attente. Vous serez notifié lorsque votre ami sera inscrit.");
    }
  }
}
