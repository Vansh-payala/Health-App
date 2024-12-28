import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  Future<void> sendMessage(String userMessage) async {
    setState(() {
      _isLoading = true;
      _messages.insert(0, {"sender": "user", "message": userMessage});
    });

    try {
      final response = await http.post(
        Uri.parse('http://192.168.184.1:7000/chat'), // Update to your server
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"message": userMessage}),
      );

      if (response.statusCode == 200) {
        final botMessage = jsonDecode(response.body)["response"];
        setState(() {
          _messages.insert(0, {"sender": "bot", "message": botMessage});
        });
      } else {
        setState(() {
          _messages.insert(
              0, {"sender": "bot", "message": "Error fetching response."});
        });
      }
    } catch (e) {
      setState(() {
        _messages.insert(
            0, {"sender": "bot", "message": "Could not connect to server."});
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildMessageBubble(String message, bool isUser) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isUser)
          CircleAvatar(
            backgroundColor: Colors.greenAccent,
            child: Icon(Icons.smart_toy, color: Colors.white),
          ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
            decoration: BoxDecoration(
              color: isUser ? Colors.lightBlueAccent : Colors.grey.shade200,
              borderRadius: BorderRadius.all(
                  Radius.circular(30.0)), // Fully rounded corners
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
        ),
        if (isUser)
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, color: Colors.white),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("AI Chatbot"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.teal,
                          child: Icon(Icons.smart_toy,
                              color: Colors.white, size: 40),
                        ),
                        SizedBox(height: 20),
                        Text("Hello! 👋", style: TextStyle(fontSize: 20)),
                        Text("How can I help?", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  )
                : ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(10.0),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return _buildMessageBubble(
                        message["message"]!,
                        message["sender"] == "user",
                      );
                    },
                  ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        sendMessage(value);
                        _controller.clear();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                GestureDetector(
                  onTap: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
