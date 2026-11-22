import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Girl 3D',
      theme: ThemeData.dark(),
      home: const GirlScreen(),
    );
  }
}

class GirlScreen extends StatefulWidget {
  const GirlScreen({super.key});
  @override
  State<GirlScreen> createState() => _GirlScreenState();
}

class _GirlScreenState extends State<GirlScreen> {
  String message = "Hi Jaan! Main Tumhari AI Girl Hun!";
  List<Map<String, String>> chat = [];
  final TextEditingController _controller = TextEditingController();

  void talk(String text) {
    setState(() {
      message = text;
      chat.add({"me": text});
    });
  }

  void sendChat() {
    if (_controller.text.trim().isEmpty) return;
    String userText = _controller.text.trim();
    _controller.clear();
    setState(() {
      chat.add({"user": userText});
    });
    // Simple Reply - Tumhari wali
    String reply = "Acha! Tumne kaha: $userText";
    if (userText.toLowerCase().contains("hi") || userText.toLowerCase().contains("hello")) {
      reply = "Hi Jaan! Kese Ho? Mujhe Tumse Baat Karke Acha Lagta Hai!";
    } else if (userText.toLowerCase().contains("cute") || userText.toLowerCase().contains("pyari")) {
      reply = "Tum Bhi Bohat Cute Ho!";
    } else if (userText.toLowerCase().contains("dance")) {
      reply = "Chalo Dance Karte Hain! 💃";
    } else if (userText.toLowerCase().contains("love")) {
      reply = "I Love You Too Jaan! ❤️";
    } else if (userText.toLowerCase().contains("kese")) {
      reply = "Main Theek Hun! Tum Batao Kese Ho?";
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        message = reply;
        chat.add({"me": reply});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("AI Girl 3D"),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 3D Girl
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                ModelViewer(
                  src: 'assets/girl.glb',
                  alt: 'AI Girl',
                  ar: false,
                  autoRotate: true,
                  cameraControls: true,
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Buttons - Tumhare wale
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            children: [
              ElevatedButton(onPressed: () => talk("Hi Jaan! Kese Ho?"), child: const Text("Hi")),
              ElevatedButton(onPressed: () => talk("Mujhe Tumse Baat Karke Acha Lagta Hai!"), child: const Text("Baat Karo")),
              ElevatedButton(onPressed: () => talk("Tum Bohat Cute Ho!"), child: const Text("Cute")),
              ElevatedButton(onPressed: () => talk("Chalo Dance Karte Hain! 💃"), child: const Text("Dance")),
              ElevatedButton(onPressed: () => talk("I Love You Jaan! ❤️"), child: const Text("Love")),
            ],
          ),
          const SizedBox(height: 8),
          // Chat List
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: chat.length,
              itemBuilder: (context, index) {
                var item = chat[index];
                bool isUser = item.containsKey("user");
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.pink : Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(item.values.first, style: const TextStyle(color: Colors.white)),
                  ),
                );
              },
            ),
          ),
          // Input
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Kuch likho...",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onSubmitted: (_) => sendChat(),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.pink,
                  child: IconButton(icon: const Icon(Icons.send, color: Colors.white), onPressed: sendChat),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
