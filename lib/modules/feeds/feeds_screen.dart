import 'package:flutter/material.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import '../../layout/cubit/cubit.dart';
import '../../models/post_model.dart';
import '../../shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty && SocialCubit.get(context).userModel != null,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: const EdgeInsets.all(8.0),
                    elevation: 5.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        const Image(
                          image: NetworkImage(
                            'https://img.freepik.com/free-photo/young-woman-cardigan-skirt-showing-welcoming-gesture-looking-puzzled-front-view_176474-50903.jpg?w=1060&t=st=1676422965~exp=1676423565~hmac=d7c6c4c6f57860337a9c745b8688d6670b781d2c058bf6ba7c3336d584aa470a',
                          ),
                          fit: BoxFit.cover,
                          height: 200.0,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'communicate with friends',
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index], context, index),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8.0,
                    ),
                    itemCount: SocialCubit.get(context).posts.length,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            );
          },
          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context, index)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: const EdgeInsets.symmetric(horizontal: 8.0,),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children:[
                      Text(
                        '${model.name}',
                        style: const TextStyle(
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const Icon(
                        Icons.check_circle,
                        color: defaultColor,
                        size: 16.0,
                      ),
                    ],
                  ),
                  Text(
                    '${model.dateTime}',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                      height: 1.4,
                    ),
                  ),
                ],
              ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              IconButton(
                onPressed: (){},
                icon: const Icon(
                  Icons.more_horiz,
                  size: 16.0,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0,),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     bottom: 10.0,
          //     top: 5.0,
          //   ),
          //   child: SizedBox(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding:  const EdgeInsetsDirectional.only(
          //             end: 6.0,
          //           ),
          //           child: SizedBox(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#software',
          //                 style: Theme.of(context).textTheme.caption!.copyWith(
          //                   color: defaultColor,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding:  const EdgeInsetsDirectional.only(
          //             end: 6.0,
          //           ),
          //           child: SizedBox(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#flutter',
          //                 style: Theme.of(context).textTheme.caption!.copyWith(
          //                   color: defaultColor,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if(model.postImage != '')
            Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
            ),
            child: Container(
              height: 140.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0,),
                image: DecorationImage(
                  image:NetworkImage(
                    '${model.postImage}'
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0,),
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            size: 16.0,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            IconBroken.Chat,
                            size: 16.0,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '0 comment',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel!.image}'
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'write a comment ...',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                        ),
                      ),
                    ],
                  ),
                  onTap: (){},
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    const Icon(
                      IconBroken.Heart,
                      size: 16.0,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap: (){
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                },
              )
            ],
          ),
        ],
      ),
    ),
  );
}
