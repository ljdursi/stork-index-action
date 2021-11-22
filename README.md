# stork-index-action

A GitHub action for generating [stork](https://stork-search.net) indexes for a repo, e.g. for use in indexing a Jekyll webpage.

## Inputs

## `input_toml`

**Required** The path to the [toml file](https://stork-search.net/docs/build) specifying the configuration and manifest of files to index

## `index_loc`

**Required** Path to the resulting output index file.

## Outputs

## `index_file`

Relative path to index file if successfully created

## Example usage

An example of use in a job, from [this Jekyll site](https://github.com/ljdursi/new-newsletter-page) -
the repo is checked out, and a table of contents generated using a custom action.   Then stork-index-action
is used to generate the stork index, which is then committed to the repo:

```yaml
on: [push]

jobs:
  index-markdowns:
    runs-on: ubuntu-latest
    name: Index newsletter issues
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Generate table of contents
        uses: ./.github/actions/toc
        id: toc
        with:
          search_path: _newsletter_issues/
          output_toml: output.toml
      - name: Index files
        uses: ljdursi/stork-index-action@v0.15
        id: index
        with:
          input_toml: output.toml
          index_loc: assets/index/index.st
      - name: Commit changes
        uses: EndBug/add-and-commit@v4
        with:
          author_name: ljdursi
          message: "update index"
          add: "assets/index/index.st"
          ref: ${{env.GITHUB_REF}}
```
