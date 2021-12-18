import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_sky/cubit/cubit.dart';
import 'package:social_sky/cubit/states.dart';
import 'package:social_sky/models/message_model.dart';
import 'package:social_sky/models/user_model.dart';
import 'package:social_sky/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  late UserModel userModel;

  ChatDetailsScreen(this.userModel);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).getMessages(receiverId: userModel.uId);

    return Builder(builder: (context) {
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
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).messages.isNotEmpty,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var message = SocialCubit.get(context).messages[index];
                        if (SocialCubit.get(context).user_model!.uId ==
                            message.senderId) return buildMyMessage(message);

                        return buildMessage(message);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15,
                      ),
                      itemCount: SocialCubit.get(context).messages.length,
                    ),
                  ),
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
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    });
  }

  Widget buildMessage(MessageModel model) => Align(
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
          child: Text('${model.text}'),
        ),
      );

  Widget buildMyMessage(MessageModel model) => Align(
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
          child: Text('${model.text}'),
        ),
      );
}
