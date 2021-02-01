# RDF misc
`spang2` can obtain results from *Virtuoso* by **automatic pagenation**.

## Examples
Example SPARQL query:
```
# @endpoint https://www.orpha.net/sparql

PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

SELECT ?s ?o
WHERE {
    ?s oboInOwl:hasDbXref ?o
}
```

Obtain data from SPARQL endpoint.
```
$ spang2 orphanet.rq > orphanet.tsv
Querying for the next page (OFFSET 10000 LIMIT 10000)...
Querying for the next page (OFFSET 20000 LIMIT 10000)...
Querying for the next page (OFFSET 30000 LIMIT 10000)...
Querying for the next page (OFFSET 40000 LIMIT 10000)...
$ wc orphanet.tsv
  42571   85142 3791019 orphanet.tsv
```

You can also execute the query file as follows, if the
file includes shebang line.
```
$ orphanet.rq > orphanet.tsv
```

Even without the query file, you can execute spang comand-line shortcuts equivalent to the query file.
```
$ spang2 -e orphanet -P oboInOwl:hasDbXref > orphanet.tsv
```

### Example usecae of the resulting tsv
Extract subset of tsv to make Turtle.
```
$ ./orphanet-ensembl.sh > orphanet-ensembl.ttl
$ grep -c ensembl orphanet-ensembl.ttl
3213
```

You can also use FILTER at the SPARQL level to extract the subset (see
`orphanet_filter.rq`).

## Installation
`spang2` requires `node` (version >= 12).
```
node -v
```
### Using node on Mac
If you do not have `brew`, install it.
```
brew -v
```
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Install `nodebrew` using `brew`.
```
brew install nodebrew
mkdir -p ~/.nodebrew/src
export PATH=$HOME/.nodebrew/current/bin:$PATH
```
Now you can use `node`. Check the version.
```
node -v
```

### Install spang
Download from GitHub.
```
git clone https://github.com/hchiba1/spang.git
```

Install.
```
cd spang
npm install
npm link
spang2
```

### node on Ubuntu
If you do not have `npm`, you need `npm`.
```
sudo apt install -y npm
```
The defualt directory for modules is `/usr/local/`, which requires `sudo`.
Configure the directory.
```
npm set prefix ~/.npm-global
```
The configuration is saved in `~/.npmrc`, so you can also configure by editing it.

Install `n` to manage `node` version.
```
npm install -g n
n stable
node -v
```
