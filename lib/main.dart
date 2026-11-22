import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'groq_service.dart';

void main() => runApp(AiGirlApp());

class AiGirlApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0A0A0A),
        primaryColor: Color(0xFFFF2E7E),
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Color(0xFFFF2E7E), Color(0xFFFF6EB4)]),
                boxShadow: [BoxShadow(color: Color(0xFFFF2E7E).withOpacity(0.6), blurRadius: 40)],
              ),
              child: Icon(Icons.favorite, size: 70, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text("AI GIRL", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, letterSpacing: 5, color: Colors.white)),
            Text("YOUR CUTE AI COMPANION", style: TextStyle(color: Color(0xFFFF6EB4), letterSpacing: 3, fontSize: 11)),
            SizedBox(height: 30),
            CircularProgressIndicator(color: Color(0xFFFF2E7E)),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WebViewController _webController;
  final GroqService _groq = GroqService();
  String _lastReply = "Hi! Main tumhari AI Girl hun 💖 Bolo kya baat karni hai?";
  bool _isThinking = false;

  @override
  void initState() {
    super.initState();
    _webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..loadFlutterAsset('assets/index.html');
  }

  void _ask() async {
    setState(() => _isThinking = true);
    final reply = await _groq.ask("Hello, tum kaun ho? Cute style me jawab do");
    setState(() { _lastReply = reply; _isThinking = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // TOP BAR - PROFESSIONAL
          Container(
            padding: EdgeInsets.only(top: 45, left: 20, right: 20, bottom: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.black, Color(0xFF1A0A12)]),
              border: Border(bottom: BorderSide(color: Color(0xFFFF2E7E).withOpacity(0.3))),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Color(0xFFFF2E7E), borderRadius: BorderRadius.circular(12)),
                  child: Icon(Icons.favorite, color: Colors.white, size: 20),
                ),
                SizedBox(width: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("AI GIRL", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: 2)),
                  Row(children: [
                    Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                    SizedBox(width: 5),
                    Text("Online • Premium", style: TextStyle(color: Colors.green, fontSize: 11)),
                  ]),
                ]),
                Spacer(),
                Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: Color(0xFFFF2E7E).withOpacity(0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: Color(0xFFFF2E7E))), child: Text("PRO ✨", style: TextStyle(color: Color(0xFFFF6EB4), fontWeight: FontWeight.bold, fontSize: 12))),
              ],
            ),
          ),
          // 3D GIRL
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), border: Border.all(color: Color(0xFFFF2E7E).withOpacity(0.4)), boxShadow: [BoxShadow(color: Color(0xFFFF2E7E).withOpacity(0.2), blurRadius: 20)]),
              child: ClipRRect(borderRadius: BorderRadius.circular(25), child: WebViewWidget(controller: _webController)),
            ),
          ),
          // CHAT CARD - GLASS
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.08))),
            child: Row(
              children: [
                CircleAvatar(backgroundColor: Color(0xFFFF2E7E), child: Text("💖", style: TextStyle(fontSize: 18))),
                SizedBox(width: 10),
                Expanded(child: Text(_isThinking ? "Soch rahi hun... 💭" : _lastReply, style: TextStyle(fontSize: 14, color: Colors.white70))),
              ],
            ),
          ),
          SizedBox(height: 12),
          // MIC BUTTON - GLOWING
          GestureDetector(
            onTap: _ask,
            child: Container(
              width: 70, height: 70,
              decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [Color(0xFFFF2E7E), Color(0xFFFF6EB4)]), boxShadow: [BoxShadow(color: Color(0xFFFF2E7E).withOpacity(0.7), blurRadius: 25)]),
              child: Icon(_isThinking ? Icons.hourglass_top : Icons.mic, color: Colors.white, size: 30),
            ),
          ),
          SizedBox(height: 8),
          Text("Tap to Talk", style: TextStyle(color: Color(0xFFFF6EB4), fontSize: 12, letterSpacing: 1)),
          SizedBox(height: 18),
        ],
      ),
    );
  }
}
