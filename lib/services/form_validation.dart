import 'package:whatodo/services/toast.dart';

class FormValidation {
  static bool isFormValid(String? firstname, String email, String password) {
    if (firstname != null) {
      if (firstname.isEmpty) {
        ToastService.showError("Le prénom ne peut pas être vide");
        return false;
      }
    }

    if (email.isEmpty) {
      ToastService.showError("L'email ne peut pas être vide");
      return false;
    } else if (RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email) ==
        false) {
      ToastService.showError("L'email saisi n'est pas conforme");
      return false;
    } else if (RegExp(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~;]).{8,}$')
            .hasMatch(password) ==
        false) {
      ToastService.showError(
          "Le mot de passe saisi doit faire au moins 8 caractères avec au moins une majuscule, un caractère spécial et un chiffre");
      return false;
    } else if (password != password) {
      ToastService.showError("Les mots de passe ne correspondent pas");
      return false;
    }

    return true;
  }
}
