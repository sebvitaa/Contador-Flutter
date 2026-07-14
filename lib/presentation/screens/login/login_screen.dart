import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contador_app/presentation/screens/login/login_provider.dart';
import 'package:contador_app/presentation/screens/counter/counter_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _correoCtrl = TextEditingController();
  final _claveCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  // Fíjate: aquí YA NO están _verClave ni _cargando.

  @override
  void dispose() {
    _correoCtrl.dispose();
    _claveCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _entrar() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final login = context.read<LoginProvider>();   // read: solo para llamar métodos
    login.setCargando(true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    login.setCargando(false);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const CounterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final login = context.watch<LoginProvider>();  // watch: lee Y redibuja
    final puedeEntrar = _correoCtrl.text.isNotEmpty && _claveCtrl.text.isNotEmpty;
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
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
                  enabled: !login.cargando,
                  decoration: const InputDecoration(
                    labelText: 'Correo',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Introduce tu correo';
                    if (!v.contains('@')) return 'Correo no válido';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _claveCtrl,
                  enabled: !login.cargando,
                  obscureText: !login.verClave,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(login.verClave
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () =>
                          context.read<LoginProvider>().alternarVerClave(),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Introduce tu contraseña';
                    if (v.length < 6) return 'Mínimo 6 caracteres';
                    return null;
                            },
                          ),
                const SizedBox(height: 16),          // NUEVO: separador
                TextFormField(                        // NUEVO: campo de confirmación
                  controller: _confirmCtrl,
                  onChanged: (_) => setState(() {}),  // para que se redibuje el botón de Entrar
                  enabled: !login.cargando,
                  obscureText: !login.verClave,
                  decoration: const InputDecoration(
                    labelText: 'Repite la contraseña',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v != _claveCtrl.text) return 'Las contraseñas no coinciden';
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: (!puedeEntrar || login.cargando) ? null : _entrar,
                    child: login.cargando
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Entrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}