part of 'profile_page.dart';

class _RatingsBottomSheet extends StatelessWidget {
  const _RatingsBottomSheet({required this.ratings});

  final List<UserMovieRatingEntity> ratings;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      maxChildSize: 1,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return ListView.builder(
          controller: scrollController,
          itemCount: ratings.length,
          itemBuilder: (context, index) {
            final data = ratings[index];

            return ListTile(
              title: Text(data.movieName),
              subtitle: Text(data.comment),
              trailing: Text(data.rating.toStringAsFixed(2)),
            );
          },
        );
      },
    );
  }
}
