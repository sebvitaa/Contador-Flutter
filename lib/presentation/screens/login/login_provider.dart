import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  bool verClave = false;
  bool cargando = false;

  void alternarVerClave(){
    verClave = !verClave;
    notifyListeners();
  }

  void setCargando(bool value) {
    cargando = value;
    notifyListeners();
  }
}
