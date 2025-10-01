part of 'movie_detail_page.dart';

class _VideoPlayer extends StatefulWidget {
  const _VideoPlayer({required this.url});

  final String? url;

  @override
  State<_VideoPlayer> createState() => __VideoPlayerState();
}

class __VideoPlayerState extends State<_VideoPlayer> {
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 1500));
  late VideoPlayerController _controller;
  bool _isButtonVisible = true;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url ?? ""))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url == null) {
      return Container();
    }

    if (_controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(_controller),
            GestureDetector(onTap: _toggleButtonVisibility),
            _PlayPauseButton(isPlaying: _controller.value.isPlaying, onTap: _playOrPause, isVisible: _isButtonVisible),
          ],
        ),
      );
    }

    return Container();
  }

  void _playOrPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      _changeButtonVisibility(false);
    } else {
      _controller.play();
      _changeButtonVisibility(false);
    }
  }

  void _changeButtonVisibility(bool value) {
    if (_isButtonVisible == value) {
      return;
    }

    _debouncer.run(() {
      setState(() {
        _isButtonVisible = value;
      });
    });
  }

  void _toggleButtonVisibility() {
    setState(() {
      _isButtonVisible = !_isButtonVisible;
    });

    if (_isButtonVisible) {
      _debouncer.run(() {
        setState(() {
          _isButtonVisible = false;
        });
      });
    }
  }
}

class _PlayPauseButton extends StatelessWidget {
  const _PlayPauseButton({required this.isPlaying, required this.onTap, required this.isVisible});

  final bool isPlaying;
  final VoidCallback onTap;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) {
      return const SizedBox();
    }

    return IconButton(
      onPressed: onTap,
      color: Colors.white,
      iconSize: 50,
      icon: isPlaying ? const Icon(Icons.pause_circle_filled) : const Icon(Icons.play_circle_filled),
    );
  }
}
