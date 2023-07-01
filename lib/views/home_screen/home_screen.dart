import 'package:collage_me/views/components/bottom_navbar.dart';
import 'package:collage_me/views/components/fab_button.dart';
import 'package:collage_me/views/profile_screen/friend_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';


class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

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
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FabButton(),
      bottomNavigationBar:  BottomNavbar(),
      appBar: PreferredSize(
        preferredSize: Size(100.w,17.h),
        child: Stack(
          children: [
            Container(
              height: 16.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceTint,
              ),
              child: Center(
                child: Text(
                  "CollageMe",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
            Align(
             alignment: Alignment.bottomCenter,
             child: Container(
               height: 8.h,
               width: 80.w,
               constraints: BoxConstraints(
                 maxHeight: 55,
               ),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(15),
                 color: Theme.of(context).colorScheme.onInverseSurface,
               ),
               child: Center(
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                     children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Icon(Icons.search),
                       ),
                       Expanded(
                         child: TextField(
                           decoration: InputDecoration(
                               hintText: "Search",
                               border: InputBorder.none,
                               hintStyle: TextStyle(color: Colors.grey)
                           ),
                         ),
                       ),

                     ],
                   ),
                 ),
               ),
             ),
           ),

          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Arkadaş Önerileri",style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),),
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    crossAxisCount: 2,
                    childAspectRatio: 0.85
                ),
                itemCount: 6,
                itemBuilder: (context,itemNumber){
                  return GestureDetector(
                    onTap: (){
                      Get.to(FriendProfileScreen(),arguments: friendRequest[itemNumber]);
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
                          padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 15.h,
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
                                  friendRequest[itemNumber],style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.black,), textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
            ),
          ),
        ],
      ),
    );
  }
}
