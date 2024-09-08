# meilisearch-region
List standard updated of countries, states and cities for Meilisearch

![Mini Meilisearch](./screenshot/countries.png)

## Features
- List updated of countries, states and cities
- Support `_geo` [search](https://www.meilisearch.com/docs/learn/filtering_and_sorting/geosearch)
- Countries have flags 100px, 250px and 1000px with svg and png format

## Insert countries, states and cities

You can run this command for add countries, states and cities to Meilisearch.

```shell
HOST="your meilisearch host" API_KEY="your meilisearch api key"  git clone https://github.com/Ja7ad/meilisearch-region.git && cd meilisearch-region && bash ./inserter.sh
```