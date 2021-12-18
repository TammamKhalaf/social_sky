import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_sky/cubit/cubit.dart';
import 'package:social_sky/cubit/states.dart';
import 'package:social_sky/models/user_model.dart';
import 'package:social_sky/modules/chat_details/chat_details_screen.dart';

class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: SocialCubit.get(context).users.isNotEmpty,
        fallback: (context) => Center(child: CircularProgressIndicator()),
        builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildChatItem(SocialCubit.get(context).users[index], context),
          separatorBuilder: (context, index) => Divider(),
          itemCount: SocialCubit.get(context).users.length,
        ),
      ),
    );
  }

  Widget buildChatItem(UserModel user, context) => InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ChatDetailsScreen(user),
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${user.image}'),
              ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                '${user.name}',
                style: TextStyle(height: 1.4),
              ),
            ],
          ),
        ),
      );
}
