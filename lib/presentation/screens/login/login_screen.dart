import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _correoCtrl=TextEditingController();
  final _claveCtrl=TextEditingController();
  bool _verClave = false ;
  final _formKey = GlobalKey<FormState>();
  @override

  void dispose(){
    _correoCtrl.dispose();
    _claveCtrl.dispose();
    super.dispose();
  }
  void entrar(){
    FocusScope.of(context).unfocus();
    if(!_formKey.currentState!.validate()) return;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _correoCtrl,
                decoration: InputDecoration(
                  labelText: 'Correo',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Ingrese su correo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _claveCtrl,
                obscureText: !_verClave,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_verClave ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _verClave = !_verClave;
                      });
                    },
                  ),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Ingrese su contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: entrar,
                  child: const Text('Entrar'),
                ),
              ),
            ],
          ),
        )
      ),
    ));
  }
}
