import 'package:flutter/material.dart';
import 'package:tourism_app/data/model/tourism..dart';

class BodyOfDetailScreenWidget extends StatelessWidget {
  final Tourism tourism;
  const BodyOfDetailScreenWidget({
    super.key,
    required this.tourism,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Hero(
              tag: tourism.image,
              child: Image.network(
                tourism.image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox.square(dimension: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tourism.name,
                        //  style: const TextStyle(fontSize: 18),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        tourism.address,
                        //  style: const TextStyle(
                        //    fontSize: 12,
                        //  ),
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Colors.pink,
                    ),
                    const SizedBox.square(dimension: 4),
                    Text(
                      tourism.like.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox.square(dimension: 16),
            Text(
              tourism.description,
            ),
          ],
        ),
      ),
    );
  }
}
