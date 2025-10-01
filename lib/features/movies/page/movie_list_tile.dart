part of 'movies_page.dart';

class _MovieListTile extends StatelessWidget {
  const _MovieListTile({required this.movie, required this.onTap});

  final MovieEntity movie;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(movie.name),
      trailing: Text(movie.durationString),
      subtitle: Row(
        children: [
          const Icon(Icons.star, color: Colors.amber),
          Text(movie.ratingString),
        ],
      ),
      leading: Image.network(movie.poster),
    );
  }
}
