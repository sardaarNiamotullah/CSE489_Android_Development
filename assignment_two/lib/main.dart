import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:audioplayers/audioplayers.dart' as audio;
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/services.dart'; // For method channel communication

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment Two'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.broadcast_on_personal),
              title: Text('Broadcast Receiver'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BroadcastReceiverScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Image Scale'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImageScaleScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.video_library),
              title: Text('Video'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.audiotrack),
              title: Text('Audio'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AudioScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          '',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

// Custom Broadcast Receiver Screen
class BroadcastReceiverScreen extends StatefulWidget {
  @override
  _BroadcastReceiverScreenState createState() =>
      _BroadcastReceiverScreenState();
}

class _BroadcastReceiverScreenState extends State<BroadcastReceiverScreen> {
  // Dropdown related variables
  String? _selectedBroadcastType;
  final List<String> _broadcastTypes = [
    'Custom Broadcast Receiver',
    'System Battery Notification Receiver',
  ];

  // Text editing controller for custom message
  TextEditingController _messageController = TextEditingController();

  // Battery-related variables
  final Battery _battery = Battery();
  int? _batteryLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Broadcast Receiver'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select the Broadcast Type:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedBroadcastType,
              isExpanded: true,
              hint: Text('Select Broadcast Type'),
              items: _broadcastTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedBroadcastType = newValue;

                  // Perform actions based on the selected option
                  if (_selectedBroadcastType ==
                      'System Battery Notification Receiver') {
                    _getBatteryLevel(); // Get battery level when selected
                  }
                });
              },
            ),
            SizedBox(height: 20),

            // Display content based on the selected broadcast type
            if (_selectedBroadcastType == 'System Battery Notification Receiver')
              _buildBatteryNotificationWidget(),
            if (_selectedBroadcastType == 'Custom Broadcast Receiver')
              Column(
                children: [
                  TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Enter custom message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _sendCustomBroadcast,
                    child: Text('Send Broadcast'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Method to fetch the battery level
  Future<void> _getBatteryLevel() async {
    try {
      final level = await _battery.batteryLevel; // Fetch the battery level
      setState(() {
        _batteryLevel = level; // Update the UI
      });
    } catch (e) {
      print('Error fetching battery level: $e');
    }
  }

  // Widget to display battery level
  Widget _buildBatteryNotificationWidget() {
    if (_batteryLevel == null) {
      return Text(
        'Fetching battery level...',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      );
    } else {
      return Text(
        'Battery Level: $_batteryLevel%',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      );
    }
  }

  // Method to send custom broadcast message
  void _sendCustomBroadcast() {
    String message = _messageController.text;

    if (message.isNotEmpty) {
      // Navigate to the next screen to display the received message
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomBroadcastReceiverScreen(message: message),
        ),
      );
    } else {
      // Show error if no message entered
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a message to broadcast.'),
      ));
    }
  }
}

// Custom Broadcast Receiver Screen (Receiver Screen)
class CustomBroadcastReceiverScreen extends StatelessWidget {
  final String message;

  CustomBroadcastReceiverScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Received Broadcast'),
      ),
      body: Center(
        child: Text(
          'Received broadcast message: "$message"',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}


// image part
class ImageScaleScreen extends StatefulWidget {
  @override
  _ImageScaleScreenState createState() => _ImageScaleScreenState();
}
class _ImageScaleScreenState extends State<ImageScaleScreen> {
  final String imageUrl = "https://upload.wikimedia.org/wikipedia/en/6/68/WALL-E_%28character%29.png"; // Replace with your image URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Scale')),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true, // Enables panning
          minScale: 0.5,    // Minimum zoom scale
          maxScale: 4.0,    // Maximum zoom scale
          child: Image.network(
            imageUrl,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Text("Failed to load image", style: TextStyle(color: Colors.red)),
              );
            },
          ),
        ),

      ),
    );
  }
}
// video part
class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}
class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Replace this with your desired YouTube video URL
    String videoUrl = "https://youtu.be/RrNMf71I7LI?si=1ToZIL4zpEA94XUC";

    // Initialize the controller
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!, // Get video ID from URL
      flags: YoutubePlayerFlags(
        autoPlay: true, // Auto-play the video
        mute: false, // Mute the video
      ),
    );
  }

  @override
  void dispose() {
    // Don't forget to dispose of the controller to release resources
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true, // Show progress bar
              onReady: () {
                print("Player is ready.");
              },
              onEnded: (data) {
                print("Video ended.");
              },
            ),
          ],
        ),
      ),
    );
  }
}
// audio part
class AudioScreen extends StatefulWidget {
  @override
  _AudioScreenState createState() => _AudioScreenState();
}
class _AudioScreenState extends State<AudioScreen> {
  late audio.AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  bool _isLoading = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = audio.AudioPlayer();

    // Listen for changes in the audio playback
    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });

    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
      });
    });

    // Listen for player state changes
    _audioPlayer.onPlayerStateChanged.listen((audio.PlayerState state) {
      setState(() {
        if (state == audio.PlayerState.playing) {
          _isPlaying = true;
          _isLoading = false;
        } else if (state == audio.PlayerState.paused || state == audio.PlayerState.stopped) {
          _isPlaying = false;
          _isLoading = false;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  Future<void> _playPauseAudio() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      setState(() {
        _isLoading = true; // Set loading when starting the audio
      });
      // Play the local audio file
      await _audioPlayer.play(audio.AssetSource('ThunderSound.mp3')); // Use AssetSource for local files
    }
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Audio')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              CircularProgressIndicator(), // Show loading indicator when buffering
            if (!_isLoading)
              IconButton(
                icon: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 50,
                ),
                onPressed: _playPauseAudio,
              ),
            SizedBox(height: 20),
            IconButton(
              icon: Icon(
                Icons.stop,
                size: 50,
              ),
              onPressed: _stopAudio,
            ),
            SizedBox(height: 20),
            Text(
              "${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')} / ${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
