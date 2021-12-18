import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_sky/cubit/cubit.dart';
import 'package:social_sky/cubit/states.dart';
import 'package:social_sky/models/user_model.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: SocialCubit.get(context).users.isNotEmpty,
        fallback: (context) => Center(child: CircularProgressIndicator()),
        builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildChatItem(SocialCubit.get(context).users[index]),
          separatorBuilder: (context, index) => Divider(),
          itemCount: SocialCubit.get(context).users.length,
        ),
      ),
    );
  }

  Widget buildChatItem(UserModel user) => InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    '${user.image}'),
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
