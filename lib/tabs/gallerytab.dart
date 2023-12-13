import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

import '../models/Gallerymdl/convoimgmodel.dart';
import '../widgets/SocialMediawgt/convotab.dart';

class gallerytab extends StatelessWidget {
  const gallerytab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        child: Scaffold(
          body: Column(
            children: [
              ButtonsTabBar(
                unselectedDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                backgroundColor: Colors.orange,
                borderWidth: 1,
                borderColor: Colors.black,
                labelStyle: const TextStyle(
                  color: Colors.white,
                ),
                unselectedLabelStyle: const TextStyle(
                  color: Colors.black87,
                ),
                // Add your tabs here
                tabs: const [
                  Tab(
                    text: '1st Convo.\n1998',
                  ),
                  Tab(
                    text: '2nd Convo.\n1999',
                  ),
                  Tab(
                    text: '4th Convo.\n2002',
                  ),
                  Tab(
                    text: '5th Convo.\n2004',
                  ),
                  Tab(
                    text: '6th Convo.\n2007',
                  ),
                  Tab(
                    text: '7th Convo.\n2009',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  convotab(title: '1998 Las Vegas', piclist: convo1998),
                  convotab(title: '1999 Dallas,Texas', piclist: convo1999),
                  convotab(title: '2002 Toronto', piclist: convo2002),
                  convotab(title: '2004 Orlando,Florida', piclist: convo2004),
                  convotab(title: '2007 Edison, New Jersey', piclist: convo2007),
                  convotab(title: '2009 Atlanta,Georgia', piclist: convo2009),
                ]),
              )
            ],
          ),
        ));
  }
}
