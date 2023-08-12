import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../models/note.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class AddOrEditNoteScreen extends StatefulWidget {
  const AddOrEditNoteScreen({
    super.key,
    this.note,
  });

  final Note? note;

  @override
  State<AddOrEditNoteScreen> createState() => _AddOrEditNoteScreenState();
}

class _AddOrEditNoteScreenState extends State<AddOrEditNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note?.title ?? '';
    _contentController.text = widget.note?.content ?? '';

    if (widget.note != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<NotesProvider>(context, listen: false).noteColor =
            widget.note!.color;
      });
    }

    _titleController.addListener(() {
      setState(() {});
    });
    _contentController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(
        builder: (context, NotesProvider provider, _) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton.filled(
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(Icons.arrow_back_ios_new),
              style: Constant.buttonStyle,
            ),
            actions: [
              IconButton(
                onPressed: () => showColorPalleteDialog(provider),
                icon: const SizedBox.shrink(),
                style: IconButton.styleFrom(
                  backgroundColor: Color(provider.noteColor).withOpacity(1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              IconButton(
                onPressed:
                    isNothingChanged(provider) ? null : () => save(context),
                icon: const Icon(Icons.save),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey,
                  disabledForegroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  cursorColor: Colors.white,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.grey,
                    filled: true,
                    enabledBorder: Constant.textFieldBorder,
                    focusedBorder: Constant.textFieldBorder,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _contentController,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 1,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Type something',
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.grey,
                    filled: true,
                    enabledBorder: Constant.textFieldBorder,
                    focusedBorder: Constant.textFieldBorder,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void save(BuildContext context) {
    final NotesProvider provider = Provider.of(context, listen: false);
    int now = DateTime.now().microsecondsSinceEpoch;
    if (widget.note == null) {
      final Note note = Note(
        title: _titleController.text,
        content: _contentController.text,
        color: provider.noteColor,
        createdAt: now,
        updatedAt: now,
      );
      provider.addNote(note);
    } else {
      final Note editedNote = Note(
        title: _titleController.text,
        content: _contentController.text,
        color: provider.noteColor,
        updatedAt: now,
        createdAt: widget.note!.createdAt,
      );
      provider.editNote(editedNote);
    }
    Navigator.maybePop(context);
  }

  bool isNothingChanged(NotesProvider provider) {
    return widget.note == null
        ? _titleController.text.isEmpty && _contentController.text.isEmpty
        : _titleController.text == widget.note?.title &&
            _contentController.text == widget.note?.content &&
            provider.noteColor == widget.note!.color;
  }

  void showColorPalleteDialog(NotesProvider provider) async {
    int? chosenColor = await showDialog<int?>(
      context: context,
      builder: (_) => const ColorPallete(),
    );
    if (chosenColor != null) {
      provider.noteColor = chosenColor;
    }
  }
}
