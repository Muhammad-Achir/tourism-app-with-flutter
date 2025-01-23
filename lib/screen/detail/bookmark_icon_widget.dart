import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/data/model/tourism..dart';
import 'package:tourism_app/provider/detail/bookmark_icon_provider.dart';
import 'package:tourism_app/provider/detail/bookmark_list_provider.dart';

class BookmarkIconWidget extends StatefulWidget {
  final Tourism tourism;
  const BookmarkIconWidget({
    super.key,
    required this.tourism,
  });

  @override
  State<BookmarkIconWidget> createState() => _BookmarkIconWidgetState();
}

class _BookmarkIconWidgetState extends State<BookmarkIconWidget> {
  late bool _isBookmarked;

  @override
  void initState() {
    // final tourismInList =
    //     bookmarkTourismList.where((element) => element.id == widget.tourism.id);

    // setState(() {
    //   if (tourismInList.isNotEmpty) {
    //     _isBookmarked = true;
    //   } else {
    //     _isBookmarked = false;
    //   }
    // });

    final bookmarkListProvider = context.read<BookmarkListProvider>();
    final bookmarkIconProvider = context.read<BookmarkIconProvider>();

    Future.microtask(() {
      final tourimInList =
          bookmarkListProvider.checkItemBookmark(widget.tourism);

      bookmarkIconProvider.isBookmarked = tourimInList;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // setState(() {
        //   if (_isBookmarked) {
        //     bookmarkTourismList
        //         .removeWhere((element) => element.id == widget.tourism.id);
        //   } else {
        //     bookmarkTourismList.add(widget.tourism);
        //   }
        //   _isBookmarked = !_isBookmarked;
        // });

        final bookmarkListProvider = context.read<BookmarkListProvider>();
        final bookmarkIconProvider = context.read<BookmarkIconProvider>();
        final isBookmarked = bookmarkIconProvider.isBookmarked;

        if (!isBookmarked) {
          bookmarkListProvider.addBookmark(widget.tourism);
        } else {
          bookmarkListProvider.removeBookmark(widget.tourism);
        }

        bookmarkIconProvider.isBookmarked = !isBookmarked;
      },
      icon: Icon(
        // _isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
        context.watch<BookmarkIconProvider>().isBookmarked
            ? Icons.bookmark
            : Icons.bookmark_outline,
      ),
    );
  }
}
