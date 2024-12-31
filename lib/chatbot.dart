// import 'package:flutter/material.dart';
//
// class ChatbotScreen extends StatefulWidget {
//   @override
//   _ChatbotScreenState createState() => _ChatbotScreenState();
// }
//
// class _ChatbotScreenState extends State<ChatbotScreen> {
//   final _controller = TextEditingController();
//   final List<String> _messages = [];
//
//   void _sendMessage() {
//     setState(() {
//       _messages.add(_controller.text);
//       _messages.add('Bot: Response to "${_controller.text}"');
//     });
//     _controller.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Chatbot')),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 return ListTile(title: Text(_messages[index]));
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(controller: _controller, decoration: InputDecoration(hintText: 'Type a message')),
//                 ),
//                 IconButton(onPressed: _sendMessage, icon: Icon(Icons.send)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  final Map<String, String> faq = {
    "hello": "Hi there! How can I assist you?",
    "how are you": "I'm just a bot, but I'm doing great! How can I help?",
    "what is your name": "I'm your friendly chatbot. My name is ZEN.",
    "bye": "Goodbye! Have a great day!",
    "how can I reset my password": "You can reset your password by clicking 'Forgot Password' on the login screen.",
    "what are your working hours": "Our working hours are 9 AM to 5 PM, Monday to Friday.",
  };

  void sendMessage(String query) {
    setState(() {
      messages.add({"user": query});
      if (faq.containsKey(query)) {
        messages.add({"bot": faq[query]!});
      } else {
        messages.add({"bot": "Sorry, I don't understand that question."});
      }
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chatbot")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = message.keys.first == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message.values.first,
                      style: TextStyle(color: isUser ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask a question...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      sendMessage(_controller.text.trim());
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}