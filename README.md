Europa
===

[Europa](https://github.com/artsy/europa) is an admin app and API for our Artsy [Monoliths](https://github.com/artsy/monolith).

Meta
---

* __State:__ production(ish)
* __Production:__ [https://europa-production.herokuapp.com](https://europa-production.herokuapp.com)
* __Github:__ [https://github.com/artsy/europa](https://github.com/artsy/europa)
* __Point People:__ [@broskoski](https://github.com/broskoski)

Dependencies
---

Components: Node, Express, [Ezel](https://github.com/artsy/ezel), MongoDB

Set-Up
---

- Install Mongo
```
brew install monogo
```
- Fork Europa to your Github account in the Github UI.
- Clone your repo locally (substitute your Github username).
```
git clone git@github.com:broskoski/europa.git
```
- Install Node modules
```
npm install
```
- Run Mongo
```
monogod
```
- Start Europa
```
make s
```
- Europa should now be running at http://localhost:2001/

Docs
---

