import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'ChatMessage.dart';

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();

}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friendly Chat"),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (_, index) => _messages[index],
                )
            ),
            Divider(height: 1.0,),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor
              ),
              child: _buildTextComposer(),
            ),
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.iOS ?
        BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey[200])
          )
        ) : null,
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _textEditingController,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.length > 0;
                    });
                  },
                  onSubmitted: _handleSubmitted,
                  decoration: InputDecoration.collapsed(hintText: "Send a Message"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS ?
                CupertinoButton(                                       //new
                  child: new Text("Send"),                                 //new
                  onPressed: _isComposing ? () =>  _handleSubmitted(_textEditingController.text) : null,
                ) :
                IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _isComposing ? () => _handleSubmitted(_textEditingController.text) : null,
                ),
              )
            ],
          )
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textEditingController.clear();

    setState(() {
      _isComposing = false;
    });

    ChatMessage chatMessage = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, chatMessage);
    });
    chatMessage.animationController.forward();
  }

  @override
  void dispose() {
    for (ChatMessage chatMessage in _messages) {
      chatMessage.animationController.dispose();
    }
    super.dispose();
  }

}