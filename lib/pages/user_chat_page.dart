import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class UserChatPage extends StatefulWidget {
 final Map profile;


 const UserChatPage({super.key, required this.profile});


 @override
 State<UserChatPage> createState() => _UserChatPageState();
}


class _UserChatPageState extends State<UserChatPage> {
 bool get isLinux => !kIsWeb && Platform.isLinux;
 bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);


 final supabase = Supabase.instance.client;


 final TextEditingController _controller = TextEditingController();
 final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
 final AudioPlayer _player = AudioPlayer();


 List<Map<String, dynamic>> messages = [];


 late final String myUserId;
 late final String otherUserId;


 bool hasText = false;
 bool isRecording = false;
 String? currentlyPlayingUrl;


 Duration recordDuration = Duration.zero;
 Timer? _recordTimer;


 late final RealtimeChannel _channel;


 @override
void initState() {
 super.initState();


 myUserId = supabase.auth.currentUser!.id;
 otherUserId = widget.profile['userId'];


 _controller.addListener(() {
   final textNow = _controller.text.trim().isNotEmpty;
   if (textNow != hasText) {
     setState(() => hasText = textNow);
   }
 });


 if (isMobile) {
   _initRecorder();
 }


 _loadMessages();
 _subscribeRealtime();
}




 Future<void> _initRecorder() async {
   await Permission.microphone.request();
   await _recorder.openRecorder();
 }


 /// LOAD HISTORY
 Future<void> _loadMessages() async {
   final data = await supabase
       .from('messages')
       .select()
       .or(
         'and(sender_id.eq.$myUserId,receiver_id.eq.$otherUserId),'
         'and(sender_id.eq.$otherUserId,receiver_id.eq.$myUserId)',
       )
       .order('created_at');


   setState(() {
     messages = List<Map<String, dynamic>>.from(data);
   });
 }


 /// REALTIME
 void _subscribeRealtime() {
   _channel = supabase
       .channel('chat:$myUserId:$otherUserId')
       .onPostgresChanges(
         event: PostgresChangeEvent.insert,
         schema: 'public',
         table: 'messages',
         callback: (payload) {
           final m = payload.newRecord;
           if ((m['sender_id'] == myUserId &&
                   m['receiver_id'] == otherUserId) ||
               (m['sender_id'] == otherUserId &&
                   m['receiver_id'] == myUserId)) {
             setState(() => messages.add(m));
           }
         },
       )
       .subscribe();
 }


 /// SEND TEXT
 Future<void> _sendText() async {
   final text = _controller.text.trim();
   if (text.isEmpty || isRecording) return;


   _controller.clear();
   setState(() => hasText = false);


   await supabase.from('messages').insert({
     'sender_id': myUserId,
     'receiver_id': otherUserId,
     'message_text': text,
     'voice_url': null,
   });
 }


 /// START RECORD
 Future<void> _startRecording() async {
 if (!isMobile) return;


 final dir = await getTemporaryDirectory();
 final path = '${dir.path}/voice.aac';


 recordDuration = Duration.zero;
 _recordTimer?.cancel();
 _recordTimer = Timer.periodic(const Duration(seconds: 1), (_) {
   setState(() => recordDuration += const Duration(seconds: 1));
 });


 await _recorder.startRecorder(
   toFile: path,
   codec: Codec.aacADTS,
 );


 setState(() => isRecording = true);
}




 /// STOP RECORD + SEND
 Future<void> _stopRecording() async {
 if (!isMobile) return;


 final path = await _recorder.stopRecorder();
 _recordTimer?.cancel();


 setState(() => isRecording = false);


 if (path == null) return;


 final fileName =
     '$myUserId-${DateTime.now().millisecondsSinceEpoch}.aac';


 final bytes = await File(path).readAsBytes();


 await supabase.storage
     .from('voice_messages')
     .uploadBinary(fileName, bytes);


 final voiceUrl = supabase.storage
     .from('voice_messages')
     .getPublicUrl(fileName);


 await supabase.from('messages').insert({
   'sender_id': myUserId,
   'receiver_id': otherUserId,
   'message_text': null,
   'voice_url': voiceUrl,
 });
}




 /// PLAY / PAUSE VOICE
 Future<void> _togglePlay(String url) async {
   if (currentlyPlayingUrl == url && _player.playing) {
     await _player.pause();
     setState(() => currentlyPlayingUrl = null);
   } else {
     await _player.stop();
     await _player.setUrl(url);
     await _player.play();
     setState(() => currentlyPlayingUrl = url);
   }
 }


 String _formatDuration(Duration d) {
   final m = d.inMinutes.toString().padLeft(2, '0');
   final s = (d.inSeconds % 60).toString().padLeft(2, '0');
   return '$m:$s';
 }


 @override
void dispose() {
 supabase.removeChannel(_channel);
 _controller.dispose();


 if (isMobile) {
   _recorder.closeRecorder();
 }


 _player.dispose();
 _recordTimer?.cancel();
 super.dispose();
}




 @override
 Widget build(BuildContext context) {
   final name = widget.profile['name'] ?? "Chat";


   return Scaffold(
     appBar: AppBar(title: Text(name)),
     body: Column(
       children: [
         /// CHAT LIST
         Expanded(
           child: ListView.builder(
             padding: const EdgeInsets.all(12),
             itemCount: messages.length,
             itemBuilder: (_, i) {
               final m = messages[i];
               final mine = m['sender_id'] == myUserId;
               final isVoice = m['voice_url'] != null;


               return Align(
                 alignment:
                     mine ? Alignment.centerRight : Alignment.centerLeft,
                 child: Container(
                   margin: const EdgeInsets.symmetric(vertical: 4),
                   padding: const EdgeInsets.all(10),
                   decoration: BoxDecoration(
                     color: mine ? Colors.blue : Colors.grey.shade300,
                     borderRadius: BorderRadius.circular(10),
                   ),
                   child: isVoice
                       ? InkWell(
                           onTap: () =>
                               _togglePlay(m['voice_url']),
                           child: Row(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               Icon(
                                 currentlyPlayingUrl ==
                                             m['voice_url'] &&
                                         _player.playing
                                     ? Icons.pause
                                     : Icons.play_arrow,
                                 color:
                                     mine ? Colors.white : Colors.black,
                               ),
                               const SizedBox(width: 6),
                               Text(
                                 "Voice message",
                                 style: TextStyle(
                                   color: mine
                                       ? Colors.white
                                       : Colors.black,
                                 ),
                               ),
                             ],
                           ),
                         )
                       : Text(
                           m['message_text'],
                           style: TextStyle(
                             color: mine ? Colors.white : Colors.black,
                           ),
                         ),
                 ),
               );
             },
           ),
         ),


         /// RECORDING UI
         if (isRecording)
           Container(
             padding: const EdgeInsets.symmetric(horizontal: 16),
             height: 60,
             child: Row(
               children: [
                 Text(
                   _formatDuration(recordDuration),
                   style: const TextStyle(fontWeight: FontWeight.bold),
                 ),
                 const SizedBox(width: 10),
                 Expanded(child: _Waveform()),
               ],
             ),
           ),


         /// INPUT
         SafeArea(
           child: Row(
             children: [
               Expanded(
                 child: TextField(
                   controller: _controller,
                   enabled: !isRecording,
                   decoration: const InputDecoration(
                     hintText: "Type a message...",
                     border: InputBorder.none,
                     contentPadding: EdgeInsets.all(16),
                   ),
                 ),
               ),
               if (isRecording)
 IconButton(
   icon: const Icon(Icons.stop, color: Colors.red),
   onPressed: _stopRecording,
 )
else if (hasText)
 IconButton(
   icon: const Icon(Icons.send, color: Colors.blue),
   onPressed: _sendText,
 )
else if (isMobile)
 IconButton(
   icon: const Icon(Icons.mic, color: Colors.blue),
   onPressed: _startRecording,
 )
else
 const SizedBox(width: 48), // Linux: no mic


             ],
           ),
         ),
       ],
     ),
   );
 }
}


/// SIMPLE ANIMATED WAVEFORM
class _Waveform extends StatefulWidget {
 @override
 State<_Waveform> createState() => _WaveformState();
}


class _WaveformState extends State<_Waveform>
   with SingleTickerProviderStateMixin {
 late AnimationController _controller;
 final Random _random = Random();


 @override
 void initState() {
   super.initState();
   _controller =
       AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
         ..repeat();
 }


 @override
 void dispose() {
   _controller.dispose();
   super.dispose();
 }


 @override
 Widget build(BuildContext context) {
   return AnimatedBuilder(
     animation: _controller,
     builder: (_, __) {
       return Row(
         children: List.generate(
           20,
           (_) => Padding(
             padding: const EdgeInsets.symmetric(horizontal: 1),
             child: Container(
               width: 3,
               height: 10 + _random.nextInt(30).toDouble(),
               color: Colors.blue,
             ),
           ),
         ),
       );
     },
   );
 }
}

