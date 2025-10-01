part of 'sign_in_page.dart';

class _Form extends StatefulWidget {
  const _Form({required this.isLoading});

  final bool isLoading;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();
  final _validator = FormValidation();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(
              hintText: 'Email',
              controller: _emailController,
              validator: _validator.validateEmail,
              isLoading: widget.isLoading,
            ),
            const SizedBox(height: 12),
            PasswordTextField(
              hintText: 'Password',
              controller: _passwordController,
              validator: _validator.validatePasword,
              isLoading: widget.isLoading,
            ),
            const SizedBox(height: 24),
            CustomElevatedButton(onPressed: _signInPressed, text: 'Sign In'),
          ],
        ),
      ),
    );
  }

  void _signInPressed() {
    if (_formKey.currentState?.validate() == false) {
      return;
    }

    BlocProvider.of<SignInBloc>(context).add(
      SignInPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
