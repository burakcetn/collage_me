import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../profile_screen/friend_profile_screen.dart';
import 'package:get/get.dart';

class HomeScreenUserContainer extends StatelessWidget {
  HomeScreenUserContainer({
    super.key,
  });

  final List friendRequest = [
    'Kullanıcı 1',
    'Kullanıcı 2',
    'Kullanıcı 3',
    'Kullanıcı 4',
    'Kullanıcı 5',
    'Kullanıcı 6',
  ].obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(const FriendProfileScreen(), arguments: friendRequest[0]);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 20.h,
          width: 20.w,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 13.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Placeholder(),
                ),
                Container(
                  height: 5.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    friendRequest[0],
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.black,
                        ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
