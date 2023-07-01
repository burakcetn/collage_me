import 'package:collage_me/views/collage_screen/collage_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';



class FabButton extends StatelessWidget {
  const FabButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 9.h,
      width: 9.h,
      child: Transform(
        transform: Matrix4.translationValues(0, 25, 0),
        child: FittedBox(
          child: Transform.rotate(
            angle: math.pi/4,
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                Get.to(()=>CollageScreen());
              },
              child:  Transform.rotate(
                angle: -math.pi/4,
                child: Icon(
                  Icons.format_paint_rounded,
                  size: 36,
                  color: Theme.of(context).colorScheme.onPrimary,

                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}