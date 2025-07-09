import 'package:retrostore/ui/widgets/drawer.dart';
import 'package:retrostore/ui/widgets/popup_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrostore/providers/recipe_provider.dart';
import 'package:retrostore/ui/screens/search_recipe_screen.dart';
import '../widgets/recipe_widget.dart';
class MainRecipeScreen extends StatelessWidget {
  const MainRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
      builder: (BuildContext context, myProvider, Widget? child) => Scaffold(
        appBar: AppBar(
          title: const Text('Resep'),
          actions: [
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => SearchRecipeScreen(
                        recipes: myProvider.allRecipes,
                      )),
                ),
              ),
              child: const Icon(Icons.search),
            ),
            MyPopupMenuButton(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, '/new_recipe_screen');
            if (!context.mounted) return;
            Navigator.pushReplacementNamed(context, '/main_recipe_screen');
          },
          child: const Icon(Icons.add),
        ),
        drawer: Drawer(
          backgroundColor: !myProvider.isDark ? Colors.blue[200] : null,
          child: DrawerList(),
        ),
        body: ListView.builder(
          itemCount: myProvider.allRecipes.length,
          itemBuilder: (context, index) {
            return RecipeWidget(myProvider.allRecipes[index]);
          },
        ),
      ),
    );
  }
}