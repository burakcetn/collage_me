import 'package:collage_me/controllers/friend_controller.dart';
import 'package:collage_me/views/profile_screen/friend_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../models/friend_model.dart';
import '../components/bottom_navbar.dart';
import '../components/fab_button.dart';
import 'package:get/get.dart';

class FollowerScreen extends StatefulWidget {
  const FollowerScreen({Key? key}) : super(key: key);

  @override
  State<FollowerScreen> createState() => _FollowerScreenState();
}

class _FollowerScreenState extends State<FollowerScreen> {
  final FriendController _friendController = Get.put(FriendController());

  @override
  void initState() {
    _friendController.getFriend();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FabButton(),
      bottomNavigationBar: const BottomNavbar(),
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        title: Text(
          Get.arguments,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<FriendModel>>(
        future: _friendController.getFriend(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final List<FriendModel> friends = snapshot.data!;
            return friends.length == 0
                ? Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      "Aktif arkadaşınız yok biraz keşfe çıkın",
                      textAlign: TextAlign.center,
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          itemCount: friends.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            final FriendModel friend = friends[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 100,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    /* Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        child: Icon(
                                          Icons.person,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        radius: 32,
                                      ),
                                    ),*/
                                    GestureDetector(
                                      onTap: () => Get.to(FriendProfileScreen(),
                                          arguments: friend.userId),
                                      child: Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 50.w),
                                        child: Text(
                                          '${friend.userId?.toLowerCase()}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  );
          }
        },
      ),
    );
  }
}
