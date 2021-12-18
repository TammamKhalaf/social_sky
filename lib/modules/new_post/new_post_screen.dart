import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_sky/cubit/cubit.dart';
import 'package:social_sky/cubit/states.dart';
import 'package:social_sky/shared/components/component_s.dart';
import 'package:social_sky/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: defaultAppBar(
          context: context,
          title: 'Create Post',
          actions: [
            TextButton(
              child: Text('Post'),
              onPressed: () {
                var now = DateTime.now();

                if (SocialCubit.get(context).postImage.path.length == 0) {
                  SocialCubit.get(context).createPost(
                      text: textController.text, dateTime: now.toString());
                } else {
                  SocialCubit.get(context).uploadPostImage(
                      text: textController.text, dateTime: now.toString());
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              if (state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
              if (state is SocialCreatePostLoadingState)
                SizedBox(
                  height: 10,
                ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                        'https://image.freepik.com/free-photo/portrait-smiling-young-man-eyewear_171337-4842.jpg'),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Text(
                      'Tammam Khalaf',
                      style: TextStyle(height: 1.4),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'what is in your mind ...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (SocialCubit.get(context).postImage.path.length != 0)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(
                            SocialCubit.get(context).postImage,
                          ) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.close,
                          size: 16,
                        ),
                      ),
                      onPressed: () {
                        SocialCubit.get(context).removePostImage();
                      },
                    )
                  ],
                ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: Row(
                        children: [
                          Icon(IconBroken.Image),
                          SizedBox(
                            width: 5,
                          ),
                          Text('add photo')
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      onPressed: () {
                        SocialCubit.get(context).getPostImage();
                      },
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: Text('# tags'),
                      onPressed: () {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
