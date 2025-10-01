part of 'profile_page.dart';

class _Form extends StatefulWidget {
  const _Form({required this.isLoading, required this.profile});

  final bool isLoading;
  final ProfileEntity profile;

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();
  final _validator = FormValidation();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _aboutMeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _firstNameController.text = widget.profile.firstName;
    _lastNameController.text = widget.profile.lastName;
    _aboutMeController.text = widget.profile.aboutMe;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(
              controller: _firstNameController,
              hintText: 'First Name',
              isLoading: widget.isLoading,
              validator: _validator.validateName,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _lastNameController,
              hintText: 'Last Name',
              isLoading: widget.isLoading,
              validator: _validator.validateName,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _aboutMeController,
              hintText: 'About Me',
              isLoading: widget.isLoading,
              validator: _validator.validateAboutMe,
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: 'Update',
              onPressed: _update,
              isLoading: widget.isLoading,
            ),
          ],
        ),
      ),
    );
  }

  void _update() {
    if (_formKey.currentState?.validate() == false) {
      return;
    }

    BlocProvider.of<ProfileBloc>(context).add(
      ProfileUpdatePressed(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        aboutMe: _aboutMeController.text,
      ),
    );
  }
}
