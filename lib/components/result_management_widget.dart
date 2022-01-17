import 'package:flutter/material.dart';
import 'package:startlottery/Screens/admin_panel_screen.dart';
import 'package:startlottery/Screens/change_brand_screen.dart';
import 'package:startlottery/Screens/previous_result_screen.dart';
import 'package:startlottery/components/drawer_tile_widget.dart';

class ResultManagementWidget extends StatelessWidget {
  const ResultManagementWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Result Management".toUpperCase(),
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 10,
          ),
          DrawerTileWidget(
            callback: () {
              Navigator.of(context).pushNamed(AdminPanelScreen.routeName);
            },
            imagePath: "assets/paper-plane.png",
            title: "Publish Result",
          ),
          DrawerTileWidget(
            callback: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(ChangeBrandScreen.routeName);
            },
            imagePath: "assets/flyers.png",
            title: "Change Brands",
          ),
          DrawerTileWidget(
            callback: () {
              Navigator.of(context).pushNamed(PreviousResultScreen.routeName);
            },
            imagePath: "assets/previous.png",
            title: "Previous Result",
          ),
          const Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
