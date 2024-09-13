// ignore_for_file: file_names, avoid_print

import '../constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';

class GoogleTTS {
  final String apiKey = Google_API_key;

  Future<void> speakWithGoogleTTS(String text) async {
    final url = Uri.parse(
        'https://texttospeech.googleapis.com/v1/text:synthesize?key=$apiKey');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'input': {'text': text},
        'voice': {
          'languageCode': 'ko-KR', // Korean language code
          'name': 'ko-KR-Wavenet-A' // Wavenet voice (high-quality voice)
        },
        'audioConfig': {
          'audioEncoding': 'MP3', // Audio format
        }
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final audioContent = jsonResponse['audioContent'];
      await playAudioFromBase64(audioContent);
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> playAudioFromBase64(String base64Audio) async {
    final audioBytes =
        base64Decode(base64Audio); // Decode the base64 audio content
    final audioPlayer = AudioPlayer();
    await audioPlayer.play(BytesSource(audioBytes)); // Play the audio
  }
}
