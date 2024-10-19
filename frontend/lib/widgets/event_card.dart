import 'package:flutter/material.dart';
import 'package:frontend/models/event.dart';
import 'package:intl/intl.dart';

class EventCard extends StatefulWidget {
  final Event event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _getRoundedText(BuildContext context, String text) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(
            int.parse(widget.event.backgroundColor.replaceFirst('#', '0xff'))),
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(widget.event.imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              widget.event.isHotelOrganized
                  ? Icons.hotel // Hotel icon
                  : Icons.person, // Person icon
              color: Colors.white,
              size: 24,
            ),
            Text(
              widget.event.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Transform.translate(
              offset: const Offset(-4, 0),
              child: SizedBox(
                height: 30,
                child: Wrap(
                  spacing: 8,
                  children: [
                    _getRoundedText(context,
                        DateFormat('EEEE, MMM d').format(widget.event.date)),
                    _getRoundedText(context, widget.event.localization),
                    _getRoundedText(context, widget.event.hotel.name),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}