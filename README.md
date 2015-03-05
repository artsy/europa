Europa
===

[Europa](https://github.com/artsy/europa) is an admin app and API for our Artsy [Monoliths](https://github.com/artsy/monolith) (columns).

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

API
---
Right now the only interesting endpoint is `/api/entries` (see sample output: [https://europa-production.herokuapp.com/api/entries?size=1](https://europa-production.herokuapp.com/api/entries?size=1)). These are all social media items approved by an Artsy admin. There are three attributes: 
- `id` - the internal mongo assigned id
- `external_id` - the id assigned by the social media provider
- `provider` - (string) the social media provider (e.g. instagram)
- `payload` - (json) raw api output of the saved social media item

Administering a monolith
---
Monoliths can be managed remotely in a limited capacity via [https://europa-production.herokuapp.com/monoliths](https://europa-production.herokuapp.com/monoliths). The login is available through 1Pass.

