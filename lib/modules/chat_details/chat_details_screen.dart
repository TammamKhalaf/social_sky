import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_sky/cubit/cubit.dart';
import 'package:social_sky/cubit/states.dart';
import 'package:social_sky/models/user_model.dart';
import 'package:social_sky/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  late UserModel userModel;

  ChatDetailsScreen(this.userModel);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('${userModel.image}'),
              ),
              SizedBox(
                width: 15,
              ),
              Text('${userModel.name}'),
            ],
          ),
          titleSpacing: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              buildMessage(),
              buildMyMessage(),
              Spacer(),
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'type your messsage here ...',
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      color: Colors.deepOrange,
                      child: MaterialButton(
                        onPressed: () {
                          SocialCubit.get(context).sendMessage(
                            receiverId: userModel.uId,
                            dateTime: DateTime.now().toString(),
                            text: messageController.text,
                          );
                        },
                        minWidth: 1,
                        child: Icon(
                          IconBroken.Send,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMessage() => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          child: Text('Hello World'),
        ),
      );

  Widget buildMyMessage() => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.deepOrange.withOpacity(0.2),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          child: Text('Hello World'),
        ),
      );
}
