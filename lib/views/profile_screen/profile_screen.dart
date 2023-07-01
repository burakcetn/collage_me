import 'package:collage_me/views/components/fab_button.dart';
import 'package:collage_me/views/profile_screen/follower_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math'as math;
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../resources/color_schemes.dart';
import '../../resources/theme_manager.dart';
import '../components/bottom_navbar.dart';
import 'follow_screen.dart';
import 'friend_profile_screen.dart';


class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);

  final List friendRequest = [
    'Kullanıcı 1',
    'Kullanıcı 2',
    'Kullanıcı 3',
    'Kullanıcı 4',
    'Kullanıcı 5',
    'Kullanıcı 6'
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FabButton(),
      bottomNavigationBar:  BottomNavbar(),
      appBar: PreferredSize(
        preferredSize: Size(100.w,22.h),
        child: Stack(
          children: [
            Container(
              height: 24.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceTint,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Kullanıcı Adı",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.format_paint),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(radius: 22.sp,),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.changeTheme(Get.isDarkMode? ThemeData(useMaterial3: true, colorScheme: lightColorScheme, textTheme: textTheme) :ThemeData(useMaterial3: true, colorScheme: darkColorScheme, textTheme: textTheme));
                        },
                        child: CircleAvatar(
                          child: Get.isDarkMode ? Icon(Icons.dark_mode):Icon(Icons.light_mode),
                        ),
                      ),
                    ],
                  ),
                  Spacer()
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 8.h,
                width: 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Column(
                          children: [
                            Spacer(),
                            Text("453",style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.surfaceTint),),
                            Text("Katılımcı",style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.surfaceTint),),
                            Spacer(),
                          ],
                        ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Get.to(()=>FollowerScreen());
                        },
                        child: Column(
                          children: [
                            Spacer(),
                            Text("453",style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.surfaceTint),),
                            Text("Takipçi",style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.surfaceTint),),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Get.to(()=>FollowScreen());
                        },
                        child: Column(
                          children: [
                            Spacer(),
                            Text("453",style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.surfaceTint),),
                            Text("Takip",style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.surfaceTint),),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              crossAxisCount: 2,
              childAspectRatio: 0.85
          ),
          itemCount: 6,
          itemBuilder: (context,itemNumber){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 20.h,
                width: 20.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(FriendProfileScreen(),arguments: friendRequest[itemNumber]);
                        },
                        child: Container(
                          height: 12.h,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child:  Center(child: Text("Profil foto", textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge,)),
                        ),
                      ),
                      Container(
                        height: 10.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                friendRequest[itemNumber],style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.black,), textAlign: TextAlign.center,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 4.h,
                                  width: 8.h,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Icon(Icons.done_rounded,color: Theme.of(context).colorScheme.onPrimary,),
                                ),
                                Container(
                                  height: 4.h,
                                  width: 8.h,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child:Icon(Icons.close_rounded, color: Theme.of(context).colorScheme.onPrimary,) ,
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      )
    );
  }
}


