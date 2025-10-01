part of 'add_rating_page.dart';

class _Form extends StatefulWidget {
  const _Form({required this.isLoading});

  final bool isLoading;

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();
  final _validator = FormValidation();
  final _commentController = TextEditingController();
  double _rating = 1;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          RatingBar(
            minRating: 1,
            maxRating: 10,
            itemCount: 10,
            itemSize: 30,
            initialRating: _rating,
            allowHalfRating: true,
            ratingWidget: RatingWidget(
              full: const Icon(Icons.star, color: Colors.amber),
              half: const Icon(Icons.star_half, color: Colors.amber),
              empty: const Icon(Icons.star, color: Colors.grey),
            ),

            onRatingUpdate: (value) {
              setState(() {
                _rating = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomTextField(
              controller: _commentController,
              hintText: 'Comment',
              validator: _validator.validateComment,
              isLoading: widget.isLoading,
              maxLength: 255,
              maxLines: 3,
            ),
          ),
          const SizedBox(height: 16),
          CustomElevatedButton(
            text: 'Submit',
            onPressed: _submit,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    if (_rating < 1 || _rating > 10) {
      return;
    }

    BlocProvider.of<AddRatingCubit>(
      context,
    ).addRating(_rating, _commentController.text);
  }
}
