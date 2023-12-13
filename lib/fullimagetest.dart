import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'models/Gallerymdl/convoimgmodel.dart';

class ImageFullScreen extends StatefulWidget {
  final List<convoimgclass> images;
  final int initialIndex;

  ImageFullScreen(this.images, this.initialIndex);

  @override
  _ImageFullScreenState createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: widget.images.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(widget.images[index].link),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration:  const BoxDecoration(
              color: Colors.black54
            ),
            pageController: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });// Handle page change if needed
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 2 - 24,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible:_currentIndex > 0,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios,color: Colors.blue,size: 30),
                      onPressed: () {
                         _changeImage(-1);
                      },
                    ),
                  ),
                  const Spacer(),
                  Visibility(
                    visible: _currentIndex < widget.images.length - 1,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 30),
                      onPressed: () {
                            _changeImage(1);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _changeImage(int delta) {
    final int currentIndex = _pageController.page?.toInt() ?? widget.initialIndex;
    final int newIndex = currentIndex + delta;

    if (newIndex >= 0 && newIndex < widget.images.length) {
      _pageController.animateToPage(
        newIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
