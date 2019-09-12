# Bird Watcher

This is a web application that allows users to create accounts and save their bird sightings.


### Installing

1. Clone this repo to your local machine with `https://github.com/radville/bird-watcher` 

2. Run `bundle install` to add all gems from the Gemfile

3. If the database has been cleared, populate app with Birds from https://wildlifenorthamerica.com/A-Z/Bird/family.html. To do this, in the terminal run `tux` and then enter `Bird.create_from_scraper(Scraper.scrape_birds)`.

4. Load the development site by entering `shotgun` in the terminal and going to the listed server in your browser.


## Built With

* [Sinatra](http://sinatrarb.com/) - The web framework used


## Contributing

1. Fork this repo

2. Clone the repo to your local machine with `https://github.com/radville/bird-watcher`

3. Make your edits!

4. Create a new pull request


## Authors

* **Laura Radville** - *Initial work* - (https://github.com/radville/)


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
