import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_events.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/pages/upcoming_events_page.dart';
import 'package:frontend/pages/your_events_page.dart';
import 'package:frontend/widgets/event_card.dart';
import 'package:frontend/widgets/events_header.dart';
import 'package:frontend/widgets/ignore_padding_widget.dart';
import 'package:frontend/widgets/profile_header.dart';
import 'package:frontend/widgets/upcoming_events_card.dart';
import 'package:frontend/widgets/your_events_card.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),
          // Main Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 37),
                  const ProfileHeader(hasNotification: true),
                  const SizedBox(height: 37),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UpcomingEventsPage()),
                      );
                    },
                    child: const UpcomingEventsCard(),
                      ),
                  const SizedBox(width: 16),
                      GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => YourEventsPage()),
                      );
                    },
                    child: const YourEventsCard(),
                  ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const EventsHeader(title: 'Events on\nThis month'),
                  const SizedBox(height: 16),
                  IgnorePaddingWidget(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: PageView.builder(
                        controller: PageController(viewportFraction: 0.80),
                        itemCount: AppEventsSingleton().events.length,
                        itemBuilder: (context, index) {
                          return _buildEventCard(
                              AppEventsSingleton().events[index]);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const EventsHeader(title: 'Events\nAround you'),
                  IgnorePaddingWidget(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: PageView.builder(
                        controller: PageController(viewportFraction: 0.80),
                        itemCount: AppEventsSingleton().events.length,
                        itemBuilder: (context, index) {
                          return _buildEventCard(
                              AppEventsSingleton().events[index]);
                        },
                      ),
                    ),
                  ),
                  // CustomBottomNavigationBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Event event) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: EventCard(event: event),
      ),
    );
  }
}
