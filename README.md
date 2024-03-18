# Spiritual Tarot Guide APP - for Apple iOS
(Final Project: Mobile Developer IHK - Syntax-Institute-Berlin 
- Module 4. : SwiftUI )

## The Idea
Those who know Tarot also know that you can use the cards everytime and everywhere, in the train or on a party with other people. 
But also for your own spiritual needs and personal development. 
It can be not only a lot of fun, but also it can help you to heal or consolidate mentally in hard times or when facing big decisions.
## The Problem
A lot of Tarot potential gets lost simply because you cannot always have your cards with you. 
BUT, you most probably do have a smartphone with you. 
This enables me to solve your Tarot deficit problem.
## The Solution
My Spiritual Tarot Guide App can really solve this problem by providing you not only several kinds of idividual readings, but also a little Tarot school for those who want to learn more about Tarot. 
This offer is rounded off by a very personal special service: 
* "Express Card of the Day" 
* "Express Quote of the Day"
  (Here you can get a randomly generated quote by a famous person which you can even save in your favorite quotes list. 
(Maybe you even want to shere this quote? Well this function is not implemented, yet.)

--------------------------------------------------------------------

# Technical Features

### Minimum Deployments: iOS 17.2

### Pattern: MVVM

### Persistent Storages: 
- Core Data (Tarot Cards)
- Firebase / Firestore
  * Favorite Quotes
  * Saved Tarot Sessions
  * User Management
- Swift Data (API Cashing)
- AppStorage


### Complex, nested & responsive Animations 
For the 'flying, rotating and twisting' Cards
- .withAnimation
- .rotation3Deffect
- .matchedGeometryEffect using @Namespace 
- MaterialEffect


### Other (required) Features
- API Request
- TabBar
- Sheets
- (Nested) List
- (Nested) ScrollViews
- NavigationStacks
- Enums
- Toolbar
- Alerts 
- Gradient Colors

--------------------------------------------------------------------

# Navigation - Architecture
<img width="4508" alt="NAvigation_Tarot_iOS" src="https://github.com/drAgon-235/TAROT/assets/81158877/ae7e0b90-d254-4baf-9012-6f5430ec8237">



--------------------------------------------------------------------

# Disclaymer
(despite this being just a project for my own learning purposes, I have to observe the legal aspects)

## Quotes API
The free API for random quotes - no key, unlimited requests :smiley: : [zenquotes.io](https://zenquotes.io/)
  ( *very good for basic educational purposes!!!*)

## Design of card backside
The 'backside of the card deck' is designed by me : many ZStacks with symbols and geographic figures
( File: SpiritualTarot/Tarotcards/Views/Components/FlippingCard/Design_Test/CardBackTestView.swift )

## Design of Tarot Deck - Rider Waite Deck

The "Rider-Waite" Tarot Deck is the most popular one since over 100 years.
It is no more protected by any copyrights, which usually expire after 70 years.
That means, all the attributes & images of each card are worldwide known & the same & free to use for anybody.

In order NOT to type the texts from one of my books, I copied & combined them from two online sources and put them into a static database:

* Source 1: API [JSON]

Very slow & badly performing API with poor database (see: cards/cardModel/cards.JSON): [tarot-api-3hv5](https://tarot-api-3hv5.onrender.com/api/v1/cards) 

* Source 2: DATABASE

Very good free "Rider-Waite" Tarot Deck Database - Texts & Pictures on:  [kaggle.com](https://www.kaggle.com/datasets/lsind18/tarot-json?resource=)

## Copyrights
(c) 2023 Slawomir Z. Dragon. All rights reserved.

Code snippets that have been copied and adapted are marked accordingly, within the code as a comment. Same with boiler-plate-code, for educational purposes.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
