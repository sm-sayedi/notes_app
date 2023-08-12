import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NotesProvider>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutScreen()),
              );
            },
            icon: const Icon(Icons.info_outlined),
            style: Constant.buttonStyle,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddOrEditNoteScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<NotesProvider>(
        builder: (_, NotesProvider provider, __) => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: provider.loadingStatus == LoadingStatus.loading
                ? const CircularProgressIndicator.adaptive()
                : provider.notes.isEmpty
                    ? const Text(
                        'No notes yet! Start adding one!',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: provider.notes.length,
                        itemBuilder: (_, int index) =>
                            NoteCard(note: provider.notes[index]),
                      ),
          ),
        ),
      ),
    );
  }
}
