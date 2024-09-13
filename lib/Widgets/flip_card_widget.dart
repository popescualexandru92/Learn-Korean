// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../providers/flash_card_provider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../services/googleTTS.dart';

class FlipCard extends StatefulWidget {
  final FlashCardItem flashCard;

  const FlipCard({
    super.key,
    required this.flashCard,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  bool _isFlipped = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _isFlipped = false;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  @override
  void didUpdateWidget(covariant FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.flashCard != oldWidget.flashCard) {
      setState(() {
        _isFlipped = false;
        _controller.value = 0;
      });
    }
  }

  void _flipCard() {
    setState(() {
      _isFlipped = !_isFlipped;
      if (_isFlipped) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final isUnder = _animation.value > 0.5;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(_animation.value * 3.1415926535897932),
            child: isUnder
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.1415926535897932),
                    child: _buildBackSide(context),
                  )
                : _buildFrontSide(context),
          );
        },
      ),
    );
  }

  Widget _buildFrontSide(BuildContext context) {
    return FlipFace(
      text: widget.flashCard.eng,
      language: "en-US",
    );
  }

  Widget _buildBackSide(BuildContext context) {
    return FlipFace(
      text: widget.flashCard.kor,
      language: 'ko-KR',
    );
  }
}

Future<void> _speak(text, language) async {
  FlutterTts flutterTts = FlutterTts();
  if (language == "ko-KR") {
    GoogleTTS().speakWithGoogleTTS(text);
  } else {
    await flutterTts.setLanguage(language);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }
}

class FlipFace extends StatelessWidget {
  final String text;
  final String language;
  const FlipFace({super.key, required this.text, required this.language});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(238, 231, 215, 0.9),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    text.replaceAll("/", "/\n"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _speak(text, language),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.2,
                  width: double.infinity,
                  color: Color.fromRGBO(34, 123, 148, 0.9),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.volume_up,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Listen",
                        style: TextStyle(
                            color: Color.fromRGBO(255, 220, 127, 0.9),
                            fontSize: 25),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
