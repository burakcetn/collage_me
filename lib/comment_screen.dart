import 'package:collage_me/resources/color_manager.dart';
import 'package:collage_me/views/collage_screen/collage_screen.dart';
import 'package:collage_me/views/collage_screen/onboard_collage.dart';
import 'package:collage_me/views/components/bottom_navbar.dart';
import 'package:collage_me/views/components/fab_button.dart';
import 'package:collage_me/views/profile_screen/friend_profile_screen.dart';
import 'package:collage_me/views/profile_screen/onboard_friend_collage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/comment_controller.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _commentTextController =
        TextEditingController();
    CommentController _commentController = Get.put(CommentController());

    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FabButton(),
      bottomNavigationBar: const BottomNavbar(),
      body: GestureDetector(
        onTap: () {
          // Unfocus the text field when tapping outside of it
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32.0, vertical: 60),
                child: GestureDetector(
                  onTap: () {
                    // Unfocus the text field when tapping outside of it
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    height: 100,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          style: Theme.of(context).textTheme.labelMedium,
                          controller: _commentTextController,
                          decoration: InputDecoration(
                            hintText: 'Enter your comment',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _commentController.sendComment(
                      _commentTextController.text, Get.arguments[0]);
                  if (Get.arguments[1] == 1) {
                    Get.off(() => OnboardFriendProfile(),
                        arguments: Get.arguments[0]);
                  }
                  if (Get.arguments[1] == 0) {
                    Get.off(() => OnboardCollage());
                  }
                },
                child: Icon(Icons.comment_rounded),
              )
            ],
          ),
        ),
      ),
    );
  }
}
