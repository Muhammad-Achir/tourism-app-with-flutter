import 'package:flutter/material.dart';
import 'package:tourism_app/model/tourism..dart';

class TourismCard extends StatelessWidget {
  final Tourism tourism;
  final Function() onTap;

  const TourismCard({
    super.key,
    required this.tourism,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 120,
                maxWidth: 120,
                minWidth: 80,
                minHeight: 80,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Hero(
                  tag: tourism.image,
                  child: Image.network(
                    tourism.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox.square(dimension: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tourism.name,
                    // style: const TextStyle(
                    //   fontSize: 16,
                    // ),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox.square(
                    dimension: 6,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.pin_drop),
                      SizedBox.square(
                        dimension: 4,
                      ),
                      Expanded(
                        child: Text(
                          tourism.address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox.square(
                    dimension: 6,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.pink,
                      ),
                      SizedBox.square(
                        dimension: 4,
                      ),
                      Expanded(
                        child: Text(
                          tourism.like.toString(),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
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
