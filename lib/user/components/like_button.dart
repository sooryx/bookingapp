import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  void Function()onTap;
   LikeButton({super.key,required this.onTap, required this.isLiked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border_rounded,
        color: isLiked ? Colors.red : Colors.white,
      ),
    );
  }
}
