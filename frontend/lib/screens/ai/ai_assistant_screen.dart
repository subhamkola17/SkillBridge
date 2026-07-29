import 'package:flutter/material.dart';

import '../../models/ai_message_model.dart';
import '../../services/ai_service.dart';
import '../../widgets/ai/ai_chat_bubble.dart';
import '../../widgets/ai/ai_input_bar.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  State<AIAssistantScreen> createState() =>
      _AIAssistantScreenState();
}

class _AIAssistantScreenState
    extends State<AIAssistantScreen> {

final AIService _aiService = AIService();

final TextEditingController _controller =
TextEditingController();

final ScrollController _scrollController =
ScrollController();

final List<AIMessage> _messages = [];

bool _isTyping = false;

@override
void initState() {
super.initState();

_messages.add(
AIMessage(
message:
"👋 Welcome to SkillBridge AI\n\n"
"I can help you with:\n\n"
"• Career Roadmaps\n"
"• Internship Guidance\n"
"• Job Recommendations\n"
"• Skill Improvement\n"
"• Mentor Suggestions\n"
"• Course Recommendations\n\n"
"Just describe your current skills and your career goal.",
isUser: false,
time: DateTime.now(),
),
);
}

@override
void dispose() {
_controller.dispose();
_scrollController.dispose();
super.dispose();
}

void _scrollToBottom() {
Future.delayed(
const Duration(milliseconds: 250),
() {
if (!_scrollController.hasClients) return;

_scrollController.animateTo(
_scrollController.position.maxScrollExtent,
duration: const Duration(milliseconds: 350),
curve: Curves.easeOut,
);
},
);
}

Future<void> _sendMessage() async {

final text = _controller.text.trim();

if (text.isEmpty) return;

setState(() {

_messages.add(
AIMessage(
message: text,
isUser: true,
time: DateTime.now(),
),
);

_isTyping = true;

_controller.clear();
});

_scrollToBottom();

try {

final response =
await _aiService.getRecommendation(
skills: "",
interests: "",
goal: text,
);



final recommendation = response["recommendation"];

final String aiReply =
    recommendation["answer"] ?? "No response generated.";

setState(() {

_messages.add(
AIMessage(
message: aiReply,
isUser: false,
time: DateTime.now(),
),
);

_isTyping = false;
});
} catch (e) {

setState(() {

_messages.add(
AIMessage(
message:
"❌ Sorry, I couldn't generate a recommendation.\n\n${e.toString()}",
isUser: false,
time: DateTime.now(),
),
);

_isTyping = false;
});
}

_scrollToBottom();
}

Widget _typingIndicator() {
return const Padding(
padding: EdgeInsets.symmetric(
horizontal: 20,
vertical: 10,
),
child: Row(
children: [
CircleAvatar(
radius: 18,
backgroundColor: Color(0xFF2563EB),
child: Icon(
Icons.smart_toy_rounded,
color: Colors.white,
size: 18,
),
),
SizedBox(width: 12),
Text(
"SkillBridge AI is thinking...",
style: TextStyle(
color: Colors.white70,
),
),
],
),
);
}

Widget _suggestionChip(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: ActionChip(
      backgroundColor: const Color(0xFF1E293B),
      label: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      onPressed: () {
        _controller.text = text;
        _sendMessage();
      },
    ),
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFF0F172A),

    appBar: AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF0F172A),
      centerTitle: true,
      title: const Text(
        "SkillBridge AI",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),

    body: Column(
      children: [

        Container(
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _suggestionChip("🚀 Flutter Internship"),
              _suggestionChip("💼 Best Jobs"),
              _suggestionChip("📚 AI Courses"),
              _suggestionChip("🏆 Hackathons"),
              _suggestionChip("🎤 Interview Prep"),
              _suggestionChip("📝 Resume Review"),
            ],
          ),
        ),

        const Divider(
          color: Colors.white12,
          height: 1,
        ),

        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            itemCount:
            _messages.length + (_isTyping ? 1 : 0),
            itemBuilder: (context, index) {

              if (_isTyping &&
                  index == _messages.length) {
                return _typingIndicator();
              }

              return AIChatBubble(
                message: _messages[index],
              );
            },
          ),
        ),

        AIInputBar(
          controller: _controller,
          onSend: _sendMessage,
        ),
      ],
    ),
  );
}
}