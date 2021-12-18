import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_sky/cubit/cubit.dart';
import 'package:social_sky/cubit/states.dart';
import 'package:social_sky/shared/components/component_s.dart';
import 'package:social_sky/shared/styles/icon_broken.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userModel = SocialCubit.get(context).user_model;

    nameController.text = userModel?.name ?? '';
    bioController.text = userModel?.bio ?? '';
    phoneController.text = userModel?.phone ?? '';

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) => {},
      builder: (context, state) => Scaffold(
        appBar: defaultAppBar(
          context: context,
          title: 'Edit Profile',
          actions: [
            TextButton(
              onPressed: () {
                SocialCubit.get(context).updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text);
              },
              child: Text('Update'),
            ),
            SizedBox(
              width: 15,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if(state is SocialUpdateLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialUpdateLoadingState)
                  SizedBox(
                  height: 10,
                ),
                Container(
                  height: 190,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10)),
                                image: DecorationImage(
                                  image: SocialCubit.get(context)
                                              .coverImage
                                              .path
                                              .length ==
                                          0
                                      ? NetworkImage('${userModel?.cover ?? ''}')
                                      : FileImage(
                                              SocialCubit.get(context).coverImage)
                                          as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 16,
                                ),
                              ),
                              onPressed: () {
                                SocialCubit.get(context).getCoverImage();
                              },
                            )
                          ],
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 60.0,
                              backgroundImage: SocialCubit.get(context)
                                          .profileImage
                                          .path
                                          .length ==
                                      0
                                  ? NetworkImage(userModel?.image ?? '')
                                  : FileImage(
                                          SocialCubit.get(context).profileImage)
                                      as ImageProvider,
                            ),
                            IconButton(
                              icon: CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 16,
                                ),
                              ),
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if(SocialCubit.get(context).profileImage.path.length != 0 || SocialCubit.get(context).coverImage.path.length != 0)
                  Row(
                  children: [
                    if(SocialCubit.get(context).profileImage.path.length != 0)
                      Expanded(
                        child: Column(
                          children: [
                            RaisedButton(
                              onPressed: () {
                              SocialCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text,);
                            },child: Text('upload profile'),),
                            if(state is SocialUpdateLoadingState)
                              SizedBox(height: 5,),
                            if(state is SocialUpdateLoadingState)
                              LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    SizedBox(
                      width:5,
                    ),
                    if(SocialCubit.get(context).coverImage.path.length != 0)
                      Expanded(
                        child: Column(
                          children: [
                             RaisedButton(onPressed: () {
                               SocialCubit.get(context).uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text,);
                             },child: Text('upload cover'),),
                            if(state is SocialUpdateLoadingState)
                            SizedBox(height: 5,),
                            if(state is SocialUpdateLoadingState)
                            LinearProgressIndicator(),
                          ],
                        ),
                      )
                  ],
                ),
                if(SocialCubit.get(context).profileImage.path.length != 0 || SocialCubit.get(context).coverImage.path.length != 0)
                SizedBox(
                  height: 20,
                ),
                defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Name must not be empty';
                      }
                    },
                    label: 'Name',
                    prefix: IconBroken.User),
                SizedBox(
                  height: 10,
                ),
                defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Bio must not be empty';
                      }
                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle),
                SizedBox(
                  height: 10,
                ),
                defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Phone number must not be empty';
                      }
                    },
                    label: 'Phone',
                    prefix: IconBroken.Call),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
