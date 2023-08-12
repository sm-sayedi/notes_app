import 'package:flutter/material.dart';
import 'package:notes_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../screens/screens.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
  });
  final Note note;

  @override
  Widget build(BuildContext context) {
    double luminance = Color(note.color).withOpacity(1).computeLuminance();
    final Color foregroundColor = luminance > 0.5 ? Colors.black : Colors.white;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AddOrEditNoteScreen(note: note),
        ),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(note.color).withOpacity(1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: foregroundColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                Flexible(
                  child: Text(
                    note.content,
                    overflow: TextOverflow.fade,
                    style: TextStyle(color: foregroundColor),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 4,
            child: IconButton(
              onPressed: () async {
                final bool? shouldDelete = await showDialog<bool?>(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: const Text('Do you want to delete this note?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
                if (shouldDelete ?? false) {
                  if (context.mounted) {
                    Provider.of<NotesProvider>(context, listen: false)
                        .deleteNote(note);
                  }
                }
              },
              icon: Icon(
                Icons.delete,
                color: foregroundColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
