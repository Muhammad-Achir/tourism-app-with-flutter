import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/data/model/tourism..dart';
import 'package:tourism_app/provider/bookmark/local_database_provider.dart';
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

    // final bookmarkListProvider = context.read<BookmarkListProvider>();
    final localDatabaseProvider = context.read<LocalDatabaseProvider>();

    final bookmarkIconProvider = context.read<BookmarkIconProvider>();

    Future.microtask(() async {
      // final tourimInList =
      // bookmarkListProvider.checkItemBookmark(widget.tourism);
      await localDatabaseProvider.loadTourismById(widget.tourism.id);
      // final value = localDatabaseProvider.checkItemBookmark(widget.tourism.id);

      // bookmarkIconProvider.isBookmarked = tourimInList;

      final value = localDatabaseProvider.tourism == null
          ? false
          : localDatabaseProvider.tourism!.id == widget.tourism.id;
      bookmarkIconProvider.isBookmarked = value;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        // setState(() {
        //   if (_isBookmarked) {
        //     bookmarkTourismList
        //         .removeWhere((element) => element.id == widget.tourism.id);
        //   } else {
        //     bookmarkTourismList.add(widget.tourism);
        //   }
        //   _isBookmarked = !_isBookmarked;
        // });

        // final bookmarkListProvider = context.read<BookmarkListProvider>();
        final localDatabaseProvider = context.read<LocalDatabaseProvider>();

        final bookmarkIconProvider = context.read<BookmarkIconProvider>();
        final isBookmarked = bookmarkIconProvider.isBookmarked;

        if (!isBookmarked) {
          // bookmarkListProvider.addBookmark(widget.tourism);
          await localDatabaseProvider.saveTourism(widget.tourism);
        } else {
          // bookmarkListProvider.removeBookmark(widget.tourism);
          await localDatabaseProvider.removeTourismById(widget.tourism.id);
        }

        bookmarkIconProvider.isBookmarked = !isBookmarked;
        localDatabaseProvider.loadAllTourism();
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
