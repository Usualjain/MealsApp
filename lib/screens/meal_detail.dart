import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealDetailsScreen extends ConsumerWidget{

  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    final isFavorite = favoriteMeals.contains(meal);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: (){
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded ? 'Added to Favorites' : 'Removed from Favorites')
                ),
              );
            }, 
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: ((child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin:0.6, end:1).animate(animation), 
                  child: child
                );
              }),   
              child: Icon(
                isFavorite ? Icons.star: Icons.star_border, 
                key: ValueKey(isFavorite)),
            ), 
          ),
        ],
      ),
      body: Column(
        children: [
          
          Hero(
            tag: meal.id,
            child: Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          
          const SizedBox(height:12),
          
          Text('Ingredients',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            )
            
            // TextStyle(
            //   fontSize: 22, 
            //   fontWeight: FontWeight.bold, 
            //   color: Color.fromARGB(255, 246, 140, 108)
            // ),
          ),
          
          const SizedBox(height:14),
          
          ListView.builder(
            shrinkWrap: true,
            itemCount: meal.ingredients.length,
            itemBuilder: (context, index) => Center(child: Text(meal.ingredients[index], style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),)),
          ),
  
          const SizedBox(height:14),
          
          Text('Steps',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height:14),
          
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
                itemCount: meal.steps.length,
                itemBuilder: (context, index) => Container(padding: const EdgeInsets.all(10),alignment: Alignment.center, child: Text(meal.steps[index], textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }
}