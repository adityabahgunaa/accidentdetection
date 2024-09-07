import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MeasureDistanceApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MeasureDistanceApp extends StatefulWidget {
  const MeasureDistanceApp({super.key});

  @override
  MeasureDistanceAppState createState() => MeasureDistanceAppState();
}

class MeasureDistanceAppState extends State<MeasureDistanceApp> {
  XFile? _image; // For storing the captured or picked image
  List<Offset> _points = []; // Store tapped points

  // Conversion factor from pixels to centimeters
  final double pixelToCmRatio = 30 / 450; // 30 cm corresponds to 500 pixels

  // Function to capture image from camera or pick from gallery
  Future<void> _getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    setState(() {
      _image = image;
      _points = []; // Clear points when new image is selected
    });
  }

  // Function to show dialog for selecting Camera or Gallery
  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Capture Image'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showPreCaptureNote(context, ImageSource.camera); // Show note before capturing photo
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Pick from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _getImage(ImageSource.gallery); // Pick image from gallery
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Show a note dialog before capturing the photo
  void _showPreCaptureNote(BuildContext context, ImageSource source) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('NOTE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
          content: const Text('For better accuracy, please click the photo from a distance of approximately 15 inches.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop();
                _getImage(source); // Capture the image after note
              },
            ),
          ],
        );
      },
    );
  }

  // Function to calculate distance between two points in pixels
  double _calculateDistanceInPixels(Offset p1, Offset p2) {
    return sqrt(pow(p2.dx - p1.dx, 2) + pow(p2.dy - p1.dy, 2));
  }

  // Function to calculate distance in centimeters
  double _calculateDistanceInCm(double pixelDistance) {
    return pixelDistance * pixelToCmRatio;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent going back from this page
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.add_a_photo, color: Colors.white),
              onPressed: () {
                _showImageSourceActionSheet(context); // Show camera/gallery options
              },
            ),
          ],
        ),
        body: _image == null
            ? const Center(child: Text('No image selected.', style: TextStyle(color: Colors.white),))
            : GestureDetector(
          onTapUp: (details) {
            setState(() {
              if (_points.length < 2) {
                _points.add(details.localPosition); // Add point on tap
              } else {
                _points = [details.localPosition]; // Reset points
              }
            });
          },
          child: Stack(
            children: [
              Image.file(
                File(_image!.path),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              CustomPaint(
                painter: PointPainter(_points),
              ),
              if (_points.length == 2)
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    // Calculate and display the distance in centimeters
                    'Distance: ${_calculateDistanceInCm(_calculateDistanceInPixels(_points[0], _points[1])).toStringAsFixed(2)} cm',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        backgroundColor: Colors.black54),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom painter to draw the points and line
class PointPainter extends CustomPainter {
  final List<Offset> points;

  PointPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill;

    for (var point in points) {
      canvas.drawCircle(point, 8.0, paint);
    }

    if (points.length == 2) {
      final linePaint = Paint()
        ..color = Colors.blue
        ..strokeWidth = 2.0;
      canvas.drawLine(points[0], points[1], linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Redraw on every change
  }
}
