<h1 align="center">GMCue</h1>

<h4 align="center">A system to add structs/instances(actors) with a callback function to a list(Stage ID).</h4>

## Basic setup
- Create a script in GameMaker
	- Copy everything from [GMCue.gml](https://github.com/maklore/GMCue/blob/main/GMCue.gml)
  - Paste to script file

- Add an actor and callback function to a list(Stage ID).
  ```gml
  GMCue.add(_id, _actor, function(_value) {
  	self.hello = _value.hello;
  });
  ```
- Perform all added callback functions on actors within set Stage ID, with or without extra properties.
  ```gml
  GMCue.perform(_id, { hello : "world" });
  ```
- Enjoy!


#### Other functions
- List Stage IDs - Returns an array of each Stage ID.
  ```gml
  GMCue.list_stages();
  ```
- List actors - Returns an array of each actor from an Stage ID.
  ```gml
  GMCue.list_actors(_id);
  ```
- Remove stage - Removes Stage ID and all included actors, and callback functions.
  ```gml
  GMCue.remove_stage(_id);
  ```
- Remove actor - Removes the actor and it's callback function from the Stage ID.
  ```gml
  GMCue.remove_actor(0, _actor);
  ```
