import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/bottom_navbar.dart';
import '../components/collages.dart';
import '../components/fab_button.dart';

class CollageSelection extends StatelessWidget {
  const CollageSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FabButton(),
      bottomNavigationBar: const BottomNavbar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  "Choose your Layout",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Divider(
                endIndent: 100,
                indent: 100,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              GestureDetector(
                  onTap: () {
                    print("collage 0 seçildi");
                  },
                  child: const Collage0()),
              Divider(
                endIndent: 100,
                indent: 100,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              GestureDetector(
                  onTap: () {
                    print("collage 1 seçildi");
                  },
                  child: const Collage1()),
              Divider(
                endIndent: 100,
                indent: 100,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              GestureDetector(
                  onTap: () {
                    print("collage 2 seçildi");
                  },
                  child: const Collage2()),
              Divider(
                endIndent: 100,
                indent: 100,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              GestureDetector(
                  onTap: () {
                    print("collage 1 seçildi");
                  },
                  child: const Collage3()),
              Divider(
                endIndent: 100,
                indent: 100,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              GestureDetector(
                  onTap: () {
                    print("collage 1 seçildi");
                  },
                  child: const Collage4()),
              Divider(
                endIndent: 100,
                indent: 100,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              GestureDetector(
                  onTap: () {
                    print("collage 1 seçildi");
                  },
                  child: const Collage5()),
              Divider(
                endIndent: 100,
                indent: 100,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              GestureDetector(
                  onTap: () {
                    print("collage 1 seçildi");
                  },
                  child: const Collage6()),
              Divider(
                endIndent: 100,
                indent: 100,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              GestureDetector(
                  onTap: () {
                    print("collage 7 seçildi");
                    Get.back();
                  },
                  child: const Collage7()),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
