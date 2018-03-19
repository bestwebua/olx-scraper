# OLX web-data scraper
Simple Ruby web-data scraper for OLX by Vladislav Trotsenko.

## Description
This tool help to find and grab web-data from olx.ua.

### Requirements
```
>= ruby 2.3.1
>= gem selenium-webdriver 3.10.0
>= gem capybara 2.18.0
>= gem nokogiri 1.8.2
>= geckodriver 0.20.0
```

#### Using
Please note, I have used Mozilla FireFox as browser for Capybara. Just run run_scaper.rb from the terminal. All grab data will save in JSON to data.txt in the script's root folder.
```
ruby run_scaper.rb
```