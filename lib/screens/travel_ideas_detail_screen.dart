import 'package:flutter/material.dart';

class TravelIdeasDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String location;
  final String bestTimeToVisit;
  final double estimatedCost;
  final List<String> activities;

  TravelIdeasDetailScreen({
    required this.imageUrl,
    required this.description,
    required this.location,
    required this.bestTimeToVisit,
    required this.estimatedCost,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Destination Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[ 
            Image.network(imageUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    location,
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text('Best Time to Visit: $bestTimeToVisit'),
                  SizedBox(height: 10.0),
                  Text('Estimated Cost: \\$${estimatedCost.toStringAsFixed(2)}'),
                  SizedBox(height: 10.0),
                  Text('Description: $description'),
                  SizedBox(height: 10.0),
                  Text('Activities: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  ...activities.map((activity) => Text('- $activity')).toList(),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          // Save action
                        },
                        child: Text('Save'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Share action
                        },
                        child: Text('Share'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}