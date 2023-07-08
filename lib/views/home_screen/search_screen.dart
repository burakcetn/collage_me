import 'package:flutter/material.dart';
import '../../controllers/user_search_controller.dart';
import '../../models/user_search_model.dart';
import 'package:get/get.dart';

import '../components/banner_admob.dart';
import '../components/bottom_navbar.dart';
import '../components/fab_button.dart';
import '../profile_screen/friend_profile_screen.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({super.key});

  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  final UserSearchService _userSearchService = UserSearchService();
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    setState(() {
      searchText = _searchController.text;
    });
    _performSearch(searchText);
  }

  void _performSearch(String query) {
    _userSearchService.searchUsers(query);
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: keyboardIsOpened ? null : const FabButton(),
      bottomNavigationBar: const BottomNavbar(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(
          "WallpaperSnap",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BannerAdmob(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              width: 300,
              child: TextField(
                style: Theme.of(context).textTheme.labelMedium,
                controller: _searchController,
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).textTheme.labelMedium,
                  labelStyle: Theme.of(context).textTheme.labelMedium,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<UserSearchModel>>(
              stream: _userSearchService.userSearchStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<UserSearchModel> searchResults = snapshot.data!;
                  if (searchResults.isEmpty) {
                    return Center(
                      child: Text('No results found.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: searchText.length > 0 ? searchResults.length : 0,
                    itemBuilder: (context, index) {
                      final user = searchResults[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => FriendProfileScreen(),
                              arguments: user.userName);
                        },
                        child: ListTile(
                          title: Text(
                            user.userName,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          // Customize the ListTile as needed
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return Center(child: SizedBox());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
