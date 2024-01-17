import 'package:chat_app_try/constants.dart';
import 'package:chat_app_try/models/message.dart';
import 'package:chat_app_try/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  TextEditingController controller =
      TextEditingController(); //is used to controlle text field

  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;//this is used to access the argument that i passed in login page
    // return FutureBuilder<QuerySnapshot>(
    //futureBuilder is used to build the ui based on the data that will be returned from the respond
    // future: messages.get(), //this is a requist that i use to get the data that i need
    return StreamBuilder<QuerySnapshot>(
      //used in reale time changes
      stream: messages.orderBy(kCreatedAt,descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      KLogo,
                      height: 50,
                    ),
                    const Text('Chat'),
                  ],
                )),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,//reverse the list
                    controller:  _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return messagesList[index].id == email ? ChatBubble(
                        message: messagesList[index],
                      ) : ChatBubbleForFriend(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        kMessage: data,
                        kCreatedAt: DateTime.now(),
                        'id': email,
                      });
                      controller.clear();

                      _controller.animateTo(
                          // _controller.position.maxScrollExtent,//the place where he arrives to
                          0,//the bigen of ListView
                          duration: Duration(seconds: 1),//the time of list to scrolle to the end
                          curve: Curves.fastOutSlowIn,//curve is used to determine how the move shap occures 
                          );
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: const Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('Loading...');
        }
      },
    );
  }
}
