import 'package:retrostore/providers/recipe_provider.dart';
import 'package:flutter/material.dart';
import 'package:retrostore/ui/screens/show_recipe_screen.dart';
import 'package:provider/provider.dart';
import '../../models/recipe_model.dart';

class RecipeWidget extends StatelessWidget {
  final RecipeModel recipeModel;
  const RecipeWidget(this.recipeModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) =>
              ShowRecipeScreen(recipeModel: recipeModel))),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5), 
        child: ListTile(
          tileColor: !Provider.of<RecipeClass>(context).isDark
            ? Colors.blue[100]
            : null,
          leading: recipeModel.image == null
            ? Container(
                decoration: BoxDecoration(
                  color: !Provider.of<RecipeClass>(context).isDark
                      ? Colors.blue
                      : null,
                  borderRadius: BorderRadius.circular(8)),
                width: 70,
                height: double.infinity,
                child: const Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('img/logo.png'),
                  )))
                : Image.file(
                recipeModel.image!,
                width: 70,
                height: double.infinity,
              ),
              title: Text(recipeModel.nama),
              subtitle: Text('${recipeModel.durasiMasak} mins'),
              trailing: InkWell(
                onTap: () {
                  Provider.of<RecipeClass>(context, listen: false).updateIsFavorite(recipeModel);
                },
            child: recipeModel.isFavorite
              ? const Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
              : const Icon(
                  Icons.favorite_border,
                  color: Colors.red,
              ),
          ),
        ),
      ),
    );
  }
}