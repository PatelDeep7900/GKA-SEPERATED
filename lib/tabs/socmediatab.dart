import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/SocialMediamdl/socialmediamodel.dart';
import '../widgets/SocialMediawgt/socmedia.dart';
import '../widgets/SocialMediawgt/wwMandals.dart';

class socmediatab extends StatelessWidget {
  const socmediatab({super.key});

  @override
  Widget build(BuildContext context) {
    void openlink(link) async {
      final Uri url = Uri.parse(link);
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return DefaultTabController(
        length: 4,
        child: Scaffold(
          body: Column(
            children: [
              Row(
                children: [
                  InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.link),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              'Hitechchhoo',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => openlink(
                          'http://parishad1925.org/viewall_event.php')),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.link),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              'Gujarati Calendar',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => openlink(
                          'https://www.drikpanchang.com/gujarati/calendar/gujarati-calendar.html')),
                ],
              ),
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
                    text: 'Newsletters',
                  ),
                  Tab(
                    text: 'ManavSeva',
                  ),
                  Tab(
                    text: 'Mochi Time',
                  ),
                  Tab(
                    text: 'Wold wide Mandals',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  socmedia(heading: 'GKA News Letter', list: newsletterlist),
                  socmedia(heading: 'Manavseva', list: manavsevalist),
                  socmedia(heading: 'Mochi Times', list: mochitimeslist),
                  const wwMandals(),
                ]),
              )
            ],
          ),
        ));
  }
}
