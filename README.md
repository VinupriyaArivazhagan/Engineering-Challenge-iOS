# iOS-Developer-Challenge

`version 1.6`
`challenge status: open`

Welcome! We've been expecting you. Holmusk is a big data based high tech company specializing in healthcare in Singapore. 

If you're someone who bleeds code and aches to make a difference in the world, then you are at the right place. You will be part of a world‑class team working on the most exciting ground‑breaking technology in an inspiring and collaborative environment.

## Basics

This is the Holmusk iOS developer challenge. The rules of the challenge are very simple and are as follows

* You are required to code in Swift.
* You will be able to submit the challenge anytime you are ready provided the challenge is still open.
* Your code should be commented.
* You should implement **Autolayout** and **Size Classes** to support *all* iPhone sizes. Only one orientation is enough - we're not too fiesty on that
* Because we, at Holmusk, take code organization seriously, please do ensure your source files are organized when you submit.
* You should ensure proper use of version control. Progress should be visible through subsequent commits.
* You are required to fork this repo and submit a pull request.
* If you wish to not make public, your submission, please complete the code in your local repository and email a patch file to careers@holmusk.com.
* Please note that you will also be judged on the elegance of your code, level of abstraction and technical skills presented in the implementation. For more details, refer to the Judging Criteria section below.

## The Challenge 

### What You'll need to build
You'll need to build an app that is able to retrieve nutrition information for different food types, persist it locally and display it to the user in a very interesting manner. 


### Bits and Pieces to take note of
* Use `http://test.holmusk.com/food/search?q=food_search_query`, where the `food_search_query` parameter should be replaced by a food name, to search for food items.
* Present the data in your app. How you present will be a direct reflection of your creativity and motivation so we encourage you to spend as much time on this part as possible. You are **not** limited to TableViews or CollectionViews, feel free to create your own representations. One of our favorites is the parallax based scrollview.
* You will need to implement **autocomplete with a search view** [With a maximum of 10 results so that the interface does not look cluttered] so that users are able to easily enter food items they have had. 
* You will need to store all of your results into CoreData/Realm(http://realm.io) /FMDB/SQlite in the most efficient way possible. Please do log the time taken for data storage and retrieval in the console. 
* You will also need to allow users to enter new food items which should then be synced with your *local dataStore* (CoreData/Realm).
* With that said we wish you good luck and look forward to receiving your submission!

## Judging Criteria 
* What you have produced will determine your final outcome. 60% of your product, from our point of view, depends on your **User Experience** and **User Interfaces** for this challenge thus we would encourage you to make the best use of the CoreAnimation, QuartzCore and CoreGraphics libraries. Because we love people who have a passion for expanding their horizons, your background with these libraries do not matter so much provided you are able to demonstrate your learning ability! 

### Bonus Points

At Holmusk we do our best to go the extra mile and as such you would receive brownie points if 
* your app provides simple analytics such as keeping track of a user's diet for the day and relevant graphs, animations etc.
* you use Realm instead of core data.
* you create at least one custom control that uses `IBInspectable` and `IBDesignable`.
* you use Kimono's API builder (https://www.kimonolabs.com) to extract food related data from MyfitnessPal (https://www.myfitnesspal.com), FatSecrets (http://www.fatsecret.com.sg) or other food websites such as CalorieKing (http://www.calorieking.com).
