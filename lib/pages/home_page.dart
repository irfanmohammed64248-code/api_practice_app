import 'package:api_post_three/providers/review_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final review = ref.watch(reviewProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Home page")),
      body: review.when(
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          return Center(child: Text("Error: $error"));
        },
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final reviews = data[index];

              return Card(
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(reviews.id),
                      Text(reviews.userId),
                      Text(reviews.mentorName),
                      Text(reviews.internName),
                      Text(reviews.reviewDate),
                      Text(reviews.reviewTopic),
                      Text("Score: ${reviews.reviewScore}"),
                      Text(reviews.createdAt),
                      Text(reviews.updatedAt),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
