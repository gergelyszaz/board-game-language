# board-game-language
[![Build Status](https://travis-ci.com/gergelyszaz/board-game-language.svg?branch=master)](https://travis-ci.com/gergelyszaz/board-game-language)
[![Build Status](https://dev.azure.com/szazgergely/szazgergely/_apis/build/status/board-game-language?branchName=master)](https://dev.azure.com/szazgergely/szazgergely/_build/latest?definitionId=2)

Board Game Language is a DSL (Domain Specific Language), using which common board game rules can be written and interpreted by a machine.
The syntax is written in Xtext and a parser can be generated from it.

## Getting Started

To generate the parser, run 

```
mvn install
```

### Prerequisites

* JDK8
* [Apache Maven](https://maven.apache.org/)

## Running the tests

No tests as of now.

## The language

A board game consists of a few elements:

* players
* fields
* tokens
* cards
* decks

* rules

* global properties of the game
* variables
* references
* values

### Fields

In a physical board game the board consists of several fields, between which the tokens can move. Many tokens or no tokens can be on a field at a time.

### Tokens

In a physical board game, a token is a piece of plastic/metal/wood, which the player can pick up and move across the board, and placing them on fields. New pieces could be introduced or removed any time depending on the rules of the game. A token can be only on one field at a time.

The token has an owner, initially the player that spawned the token.

### Decks

A stack of any number of cards (including 0). A deck can be anything that can hold cards: upside down deck on the board, the player's hand, the stack of cards which were already played.
A deck may or may not have an owner.

The deck also has visibility that dictates which players can see the cards inside:
Public means it's visible by everybody.
Protected is only visible by the owner of the deck.
Private is not visible, only the number of the cards inside are available.

### Cards

Cards are usually a piece of paper or plastic, which can be stacked together, taken into the hand, placed on the board, given to other players, etc. The number of cards do not change during the game, new ones cannot be created or destroyed. A card can be only in one deck at a time.

### Rules
Rules are a sequence of actions.
The actions loop back, meaning that after the last action, it will restart from the first action.


### Values
A value is an integer number. Generally it's not too common to use floating point numbers in a board game, so for simplicity only integers are considered now, but this could be changed in the future.

### References
The five main elements of the board game can be referenced: 
* players
* fields
* tokens
* cards
* decks

Through the references, the properties of these elements can be accessed. Technically it is an object reference in object oriented programming.

### Variables
Either stores a reference or a value.

There are built-in variables, which may be automatically updated by the game engine:
* TODO

### Actions

An action is a piece of instruction, which has to be processed one at a time.

```
SPAWN [Token] AS [variable] TO [field] 
```

Move a token to a field:
```
MOVE TOKEN [token] TO [field]
```

Move a card to deck:
```
MOVE CARD [card] TO [deck]
```

Remove the token referenced by the [variable] from the game:
```
DESTROY [variable]
```

Make the current player choose an element of the game, which satisfies the given [condition], and store it in the [variable].
If the current player loses by default if he does not respond in time.
```
SELECT AS [variable] WHERE [condition]
```
PROPOSAL:
Make it possible to skip turn if there was no response in time:
```
SELECT AS [variable] WHERE [condition] OTHERWISE [actions]
```

SUBJECT TO CHANGE:
Generate a random number and store it in [variable]. It's value will be [1st number] times [random number between 2nd and 3rd number]:
```
ROLL [number] [number] - [number] AS [variable]
```
PROPOSAL:
The previous method could be replaced with several ROLLs and taking to sum of their results.
Generate a random number and store it in [variable]. It's value can be any integer between the two numbers:
```
ROLL [number] TO [number] AS [variable]
```

Calculate and assign a value or reference to a variable.
```
[valueAssignment]
```

Shuffle the deck referenced by [variable].
```
SHUFFLE [variable]
```

If the condition is true, do the actions:
```
IF [condition] [action]
```

While the condition is true, do the actions:
```
WHILE [condition] [action]
```

End the turn of the current player and start from the beginning for the next player.
```
END TURN
```

Current player wins and is no longer in game.
```
WIN
```

Current player loses and is no longer in game.
```
LOSE
```

## Versioning

No real versioning as of now, but plan to use [SemVer](http://semver.org/) for versioning.
