import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_sky/cubit/cubit.dart';
import 'package:social_sky/cubit/states.dart';
import 'package:social_sky/modules/new_post/new_post_screen.dart';
import 'package:social_sky/shared/components/component_s.dart';
import 'package:social_sky/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  //const SocialLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) => {
        if (state is SocialNewPostState)
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => NewPostScreen()),
            ),
          }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(cubit.titles[cubit.currentIndex]),
          actions: [
            IconButton(
              icon: Icon(IconBroken.Notification),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(IconBroken.Search),
              onPressed: () {},
            ),
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            cubit.changeBottomNav(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                IconBroken.Home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconBroken.Chat,
              ),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconBroken.Paper_Upload,
              ),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconBroken.Location,
              ),
              label: 'Users',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconBroken.Setting,
              ),
              label: 'Settings',
            ),
          ],
          currentIndex: cubit.currentIndex,
        ),
      ),
    );
  }
}
