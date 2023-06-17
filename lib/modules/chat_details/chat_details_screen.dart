import 'package:flutter/material.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({Key? key, this.userModel}) : super(key: key);

  final SocialUserModel? userModel;

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context){
        SocialCubit.get(context).getMessages(receiverId: '${widget.userModel!.uId}');
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state){},
          builder: (context, state){
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        '${widget.userModel!.image}',
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      '${widget.userModel!.name}',
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.isNotEmpty,
                builder: (BuildContext context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index){
                              var message = SocialCubit.get(context).messages[index];

                              if(SocialCubit.get(  context).userModel!.uId == message.senderId) {
                                return buildMyMessage(message);
                              }else{
                                return buildMessage(message);
                              }
                            },
                            separatorBuilder: (context, index) => const SizedBox(height: 15.0,),
                            itemCount: SocialCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: defaultColor,
                              width: 1.0
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                ),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here ...',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              color: defaultColor,
                              child: MaterialButton(
                                onPressed: (){
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: '${widget.userModel!.uId}',
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                },
                                minWidth: 1.0,
                                child: const Icon(
                                  IconBroken.Send,
                                  size: 16.0,
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
                fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration:BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          )
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0
      ),
      child: Text(
        '${model.text}',
      ),
    ),
  );

  Widget buildMyMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration:BoxDecoration(
          color: defaultColor.withOpacity(.2),
          borderRadius: const BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          )
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0
      ),
      child: Text(
        '${model.text}',
      ),
    ),
  );
}
