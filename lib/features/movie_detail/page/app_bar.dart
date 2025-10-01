part of 'movie_detail_page.dart';

class _AppBar extends StatelessWidget {
  const _AppBar({
    required this.name,
    required this.duration,
    required this.rating,
    required this.id,
  });

  final String name;
  final String duration;
  final String rating;
  final int id;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: false,
      floating: true,
      pinned: true,
      snap: false,
      toolbarHeight: 80,
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(name), Text(duration)],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MovieRatingsPage(id: id)),
            ),
            child: Column(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text(rating),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
