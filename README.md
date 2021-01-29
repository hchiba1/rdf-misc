# RDF misc
`spang2` can obtain results from Virtuoso by automatic pagenation (including lines > 10000).

## Examples
Obtain data from SPARQL endpoint.
```
$ ./orphanet.rq > orphanet.tsv
Querying for the next page (OFFSET 10000 LIMIT 10000)...
Querying for the next page (OFFSET 20000 LIMIT 10000)...
Querying for the next page (OFFSET 30000 LIMIT 10000)...
Querying for the next page (OFFSET 40000 LIMIT 10000)...
```
Extract subset of tsv to make ttl
```
./orphanet-ensembl.sh > orphanet-ensembl.ttl
```

## Installation
`spang2` requires `node` (version >= 12).
```
node -v
```
### Using node on Mac
If you not have `brew`, install `brew`.
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew -v
```
Using `brew`, install `nodebrew`.
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
Download spang from GitHub.
```
git clone https://github.com/hchiba1/spang.git
```

Install spang.
```
cd spang
npm install
npm link
spang2
```

### node on Ubuntu
If you do not have `npm`, you need `npm`.
```
audo apt install -y npm
```
The defualt directory for modules is `/usr/local/`, which requires `sodo`.
Configure the directory.
```
npm set prefix ~/.npm-global
```
The configuration is saved in `~/npmrc`, so you can also configure by editing it.

Install `n` to manage `node` version.
```
npm install -g n
n stable
node -v
```
