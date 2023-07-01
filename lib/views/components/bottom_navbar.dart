import 'package:collage_me/views/home_screen/home_screen.dart';
import 'package:collage_me/views/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';



class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15)
      ),
      child: BottomAppBar(
        height: 65,
        clipBehavior: Clip.antiAlias,
        color: Theme.of(context).colorScheme.surfaceTint.withAlpha(255),
        child: Padding(
          padding:  EdgeInsets.only(left:6.h,right: 6.h,),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              IconButton(onPressed: (){
                Get.off(()=>HomeScreen());
              }, icon: Icon(Icons.home,size: 32,color: Theme.of(context).colorScheme.onPrimary,),),
              IconButton(onPressed: (){
                Get.off(()=>ProfileScreen());
              }, icon: Icon(Icons.person,size: 32,color: Theme.of(context).colorScheme.onPrimary),),

            ],
          ),
        ),
      ),
    );
  }
}