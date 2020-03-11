# SugoiFridge

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Ever open your refridgerator and wonder what you can make? **SugoiFridge** can help you with that! </br>
**SugoiFridge** keeps track of what food ingredients are in your fridge. Whenever you don't know what to make, **SugoiFridge** will suggest recipes based off of the food you have.

### App Evaluation
- **Category:** Food & Drink, Utility
- **Mobile:** This app would be primarily developed as a mobile app, since the user won't usually be using a computer while in the kitchen.
- **Story:** User buys food ingredients from the groceries store, inputs what they bought into the app. When they want to cook, they can open the app, and the app will suggest recipes based on ingredients. 
- **Market:** Any individual that likes and needs to cook can use this app. For example, college students who have leftover ingredients and are wondering what they can make. 
- **Habit:** The app can be used in many ways, such as when the user wants to use up all the leftover ingredients in the fridge, save money, or just find new recipes. 
- **Scope:** The app first just recommends recipes based on the user's ingredients. Eventually, the app could integrate with smart fridges to automate the process. If the app grows bigger, it could also partner with nearby groceries store for better pricing and available ingredients.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**
* Sign-Up & Login accounts
* Scan and input groceries the user bought 
* Display current ingredients in the fridge 
* Suggest recipes based on current ingredients

**Optional Nice-to-have Stories**
* Distinguish personal or family accounts
* Filter recipes based on user preferences (e.g. cuisine, include/exclude ingredient, pricing... etc.)
* User can change password
* Partner with nearby groceries store and suggest optimal pricing and available ingredients
* Add an expiration reminder for ingredients that are about to go bad
* Have an automatic ingredient scanner (e.g. using the receipt or Google's image object recognition API)
* Also suggest recipes if the user is only missing a few ingredients
  * Either suggest substitutes, or where the ingredients can be obtained at nearby groceries

### 2. Screen Archetypes

* Sign-in Screen
  * The app will remember the user's login information after exiting the app
* Register Screen
  * User enters name, email, and password
* Scanning Screen
  * User can manually enter the ingredients they bought
* Ingredients Screen 
  * Lists out all the ingredients that are in the fridge
  * User can manually remove ingredients 
* Suggestions Screen
  * Suggests multiple recipes based on the ingredients the user have in their fridge
* Recipes Screen
  * Show the steps and ingredients to make the recipe
* Settings Screen
  * Options to clear your fridge, change password

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Scanning
* Settings

**Flow Navigation** (Screen to Screen)

* Sign-in Screen
   * -> Register Screen
   * -> Ingredients Screen
* Register Screen
   * -> Sign-in Screen
* Scanning Screen
  * -> Ingredients Screen
* Ingredients Screen 
  * -> Scanning Screen
  * -> Suggestions Screen
* Suggestions Screen
  * -> Recipes Screen
* Recipes Screen
  * -> Ingredients Screen

## Wireframes
<img src="https://imgur.com/Lszpqqv.png" width=600>

### Digital Wireframes & Mockups
<img src="https://i.imgur.com/tOGrKi5.png" width=600>

## Schema 

### Models
#### FoodItem
|   Property    |      Type     |  Description |
| ------------- | ------------- | ------------- |
|  objectID   | String | Unique ID of each FoodItem (required). |
|  createdAt  |  Date  | Date that FoodItem was added to the table (automatic). |
|  updatedAt  |  Date  | Latest date that the FoodItem info was updated (automatic). |
|  foodName   | String | Market name of the FoodItem, e.g. "potato" (required). |
| compartment | String | Which compartment of the fridge the FoodItem is stored in, i.e. "fridge", "freezer", "drawer" (required). | 
|   quantity  | Number | Amount of the FoodItem the user stored (required). | 
|     unit    | String | Unit of measurement for the quantity of the FoodItem (required). |

### Networking
#### List of network requests by screen
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
* Home Feed Screen  
 * -> (Read/Get) All of a User's ingredients
 * -> (Create/Post) Add an ingredient to a User's fridge
 * -> (Delete) Delete an ingredient in a User's fridge
* Recipe Screen
 * -> (Read/Get) Get recipes based on ingredients in User's fridge
 * -> (Read/Get) Get specific recipe based on what User clicks on

#### Existing API Endpoints
##### TabScanner
- Base URL: https://api.tabscanner.com/api

|   HTTP Verb   |    Endpoint   |  Description |
| ------------- | ------------- | ------------- |
|     POST      | /2/process?file=file | Submit an image of a receipt to be processed, returns a token representing the processed text from the receipt. |
|      GET      | /result/{token} | Retrieve processed text from a receipt based on a unique token. |

##### Spoonacular
- Base URL: https://api.spoonacular.com/

|   HTTP Verb   |    Endpoint   |  Description |
| ------------- | ------------- | -------------|
|  GET   | recipes/findByIngredients | Find a list of recipes based on ingredients passed in |
|  GET     | recipes/{id}/information       | Get specific information about selected recipe     |
|  GET      | recipes/{id}/analyzedInstructions       | Get recipe steps for specific recipe     |
|      GET      | /food/ingredients/{id}/information | Get basic information about a particular ingredient, e.g. name, price, unit... etc. |
