import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/form_validators.dart';

class ResetPasswordPage extends StatefulWidget {
  final AuthController controller;

  const ResetPasswordPage({super.key, required this.controller});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitReset() async {
    if (_formKey.currentState!.validate()) {
      final success = await widget.controller.resetPassword(
        otp: _otpController.text.trim(),
        newPassword: _newPasswordController.text,
      );

      if (mounted && success) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('تم بنجاح'),
            content: const Text('تم تحديث كلمة المرور بنجاح. يمكنك الآن تسجيل الدخول باستخدام كلمة المرور الجديدة.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // إغلاق النافذة
                  Navigator.pop(context); // العودة لشاشة الدخول الرئيسية
                },
                child: const Text('موافق'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('تعيين كلمة المرور الجديدة')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: const InputDecoration(
                        labelText: 'رمز التحقق (OTP)',
                        prefixIcon: Icon(Icons.pin),
                        border: OutlineInputBorder(),
                      ),
                      validator: FormValidators.validateOtp,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _newPasswordController,
                      obscureText: widget.controller.isObscuredRegister,
                      decoration: InputDecoration(
                        labelText: 'كلمة المرور الجديدة',
                        prefixIcon: const Icon(Icons.lock_reset),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            widget.controller.isObscuredRegister
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: widget.controller.toggleObscureRegister,
                        ),
                      ),
                      validator: FormValidators.validateStrongPassword,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: widget.controller.isObscuredConfirm,
                      decoration: InputDecoration(
                        labelText: 'تأكيد كلمة المرور الجديدة',
                        prefixIcon: const Icon(Icons.check_circle_outline),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            widget.controller.isObscuredConfirm
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: widget.controller.toggleObscureConfirm,
                        ),
                      ),
                      validator: (value) => FormValidators.validateConfirmPassword(
                        value,
                        _newPasswordController.text,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: widget.controller.isLoading ? null : _submitReset,
                      child: widget.controller.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('تحديث كلمة المرور'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}