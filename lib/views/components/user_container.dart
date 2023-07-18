import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../profile_screen/friend_profile_screen.dart';
import 'package:get/get.dart';

class HomeScreenUserContainer extends StatefulWidget {
  HomeScreenUserContainer({super.key, required this.userName, this.imgUrl});

  String? userName;
  String? imgUrl;

  @override
  State<HomeScreenUserContainer> createState() =>
      _HomeScreenUserContainerState();
}

class _HomeScreenUserContainerState extends State<HomeScreenUserContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //await _userController.getFriendProfile();
        Get.to(FriendProfileScreen(), arguments: widget.userName);
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
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                      child: widget.imgUrl == null
                          ? Center(
                              child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image(
                                  image: NetworkImage(widget.imgUrl!),
                                  fit: BoxFit.fill)),
                    ),
                  ),
                ),
                Container(
                  height: 5.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    widget.userName != null
                        ? widget.userName!
                        : "Kullanıcı Adı",
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
