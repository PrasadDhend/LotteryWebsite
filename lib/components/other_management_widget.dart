import 'package:flutter/material.dart';
import 'package:startlottery/Screens/contact_info_screen.dart';
import 'package:startlottery/Screens/login_id_password_screen.dart';
import 'package:startlottery/components/drawer_tile_widget.dart';

class OtherManagementWidget extends StatelessWidget {
  const OtherManagementWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Other Management".toUpperCase(),
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 10,
          ),
          DrawerTileWidget(
            callback: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushNamed(LoginIdAndPasswordScreen.routeName);
            },
            imagePath: "assets/user.png",
            title: "Login ID & Password",
          ),
          DrawerTileWidget(
            callback: () {
              Navigator.of(context).pushNamed(ContactInfoScreen.routeName);
            },
            imagePath: "assets/phone-call.png",
            title: "phone-call",
          ),
        ],
      ),
    );
  }
}
