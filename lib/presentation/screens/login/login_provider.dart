import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  bool verClave = false;
  bool cargando = false;
  String correo='';
  void setCorreo(String value) {
    correo = value;
    notifyListeners();
  }

  void alternarVerClave(){
    verClave = !verClave;
    notifyListeners();
  }

  void setCargando(bool value) {
    cargando = value;
    notifyListeners();
  }
}
