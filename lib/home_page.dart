import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();
  bool pinnedSliverAppBar = false; // true ? show app bar : hide app bar
  bool showBottomNavigationBar = true;

  @override
  void initState() {
    scrollController.addListener(() {
      final userScrollDirection = scrollController.position.userScrollDirection;
      log('userScrollDirection: $userScrollDirection');

      pinnedSliverAppBar = userScrollDirection == ScrollDirection.forward;
      showBottomNavigationBar = userScrollDirection == ScrollDirection.reverse;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text('Scrolling Visibility'),
              backgroundColor: Colors.blue,
              floating: true,
              pinned: pinnedSliverAppBar,
            ),
          ];
        },
        body: buildListView(),
      ),
      bottomNavigationBar:
          showBottomNavigationBar ? buildBottomNavigationBar() : null,
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: 30,
      padding: EdgeInsets.all(0),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item ${index + 1}'),
        );
      },
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.blue.shade100,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
