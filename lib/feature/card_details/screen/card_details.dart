import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guven_a/core/global_widegts/app_appbar.dart';
import 'package:flutter/material.dart';

class CardDetails extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl; // This is a network URL

  const CardDetails({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(
                title: "Details",
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                // --- FIX IS HERE: Changed Image.asset to Image.network ---
                child:
                    imageUrl
                        .isNotEmpty // Add a check to ensure URL is not empty
                    ? Image.network(
                        imageUrl,
                        width: MediaQuery.of(context).size.width,
                        height: 600, // Give it a fixed height for better layout
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          // Calculate progress for the CircularProgressIndicator
                          double? progressValue;
                          if (loadingProgress.expectedTotalBytes != null) {
                            progressValue =
                                loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: progressValue,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          // Display a placeholder or error icon if image fails to load
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                              size: 50,
                            ),
                            alignment: Alignment.center,
                          );
                        },
                      )
                    : Container(
                        // Placeholder if imageUrl is empty
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                          size: 50,
                        ),
                        alignment: Alignment.center,
                      ),
              ),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              // Subtitle text
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
