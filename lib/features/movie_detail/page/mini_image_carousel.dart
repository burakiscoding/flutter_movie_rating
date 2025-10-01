part of 'movie_detail_page.dart';

class _MiniImageCarousel extends StatelessWidget {
  const _MiniImageCarousel({required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: CarouselView.weighted(
        itemSnapping: true,
        scrollDirection: Axis.horizontal,
        flexWeights: const <int>[1, 1],
        children: List<Widget>.generate(images.length, (int index) {
          return Image.network(images[index], fit: BoxFit.cover);
        }),
      ),
    );
  }
}
