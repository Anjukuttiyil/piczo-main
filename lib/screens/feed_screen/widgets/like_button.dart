import 'package:flutter/material.dart';
import 'package:piczo/resources/firestore_method.dart';
import 'package:piczo/utils/colors.dart';

class LikeButton extends StatefulWidget {
  final dynamic snap;
  const LikeButton({Key? key,required this.snap}) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

  bool _isFavorite = false;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          _isFavorite = !_isFavorite;
        });
        await FirestoreMethods().likePost(
            widget.snap['postId'], widget.snap['uid'], widget.snap['likes']);
        _controller.reverse().then((value) => _controller.forward());
      
      },
      child: ScaleTransition(
        scale: Tween(begin: 0.7, end: 1.0).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
        child: _isFavorite
            ? const Icon(
                Icons.favorite,
                size: 30,
                color: Colors.red,
              )
            : const Icon(
                Icons.favorite_border,
                color: kWhite,
                size: 30,
              ),
      ),
    );
  }
}
