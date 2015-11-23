# WC Wizard

A small app to work with an array of [Particle](https://www.particle.io/) devices to 
determine if a room is occupied. The app will register for Particle events and for each 
room event (i.e. a room is no longer occupied), display the room and occupied status.

## Usage

You will need to run `pod update` on cloning the repo, and define the following keys for [cocoapods-keys](https://github.com/orta/cocoapods-keys) plugin:
* OAuthClientId
* OAuthSecret
* ParticleUser
* ParticlePassword
