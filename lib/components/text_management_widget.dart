import 'package:flutter/material.dart';
import 'package:startlottery/Screens/main_head_screen.dart';
import 'package:startlottery/Screens/scroll_banner.dart';
import 'package:startlottery/components/drawer_tile_widget.dart';

class TextManagementWidget extends StatelessWidget {
  const TextManagementWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Text Management".toUpperCase(),
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 10,
          ),
          DrawerTileWidget(
            callback: () {
              Navigator.of(context).pushNamed(ScrollBannerScreen.routeName);
            },
            imagePath: "assets/scroll.png",
            title: "Scroll Banner",
          ),
          DrawerTileWidget(
            callback: () {
              Navigator.of(context).pushNamed(MainHeadScreen.routeName);
            },
            imagePath: "assets/font.png",
            title: "Main Head",
          ),
          const Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
