import 'package:flutter/material.dart';

class DrawerTileWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback callback;
  const DrawerTileWidget({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: callback,
      title: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      leading: Image.asset(
        imagePath,
        height: 20,
        width: 20,
      ),
    );
  }
}
