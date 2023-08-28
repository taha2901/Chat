import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/model/message.dart';
import '../components/chat_buble.dart';
import '../constants.dart';

class ChatPage extends StatelessWidget {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KmessageCollection);
  static String id = 'ChatPage';
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    TextEditingController Controller = TextEditingController();
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(KcreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        List<Message> messageList = [];
        for (int i = 0; i < snapshot.data!.docs.length; i++) {
          messageList.add(Message.fromJson(snapshot.data!.docs[i]));
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: KprimaryColor,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  KprimaryImage,
                  height: 50,
                ),
                Text('Chat'),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemBuilder: (context, index) {
                    return messageList[index].id == email? ChatBuble(
                      message: messageList[index],
                    ) : ChatBubleMyFriend(message: messageList[index]);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: Controller,
                  onFieldSubmitted: (data) {
                    messages.add({
                      Kmessage: data,
                      KcreatedAt: DateTime.now(),
                      'id': email,
                    });
                    Controller.clear();
                    _controller.animateTo(
                      0,
                      // _controller.position.maxScrollExtent,
                      duration: Duration(microseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Send Message',
                    suffixIcon: const Icon(
                      Icons.send,
                      color: KprimaryColor,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: KprimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
