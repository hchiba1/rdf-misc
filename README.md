# Virtuoso misc

VALUESの要素数が4095以上になるとエラーになる.
```
Error: 400
Virtuoso 37000 Error SP030: SPARQL compiler, line 0: Too many arguments of a standard built-in function in operator()
```
`libsrc/Wi/sparql_core.c`で`if (argcount > sbd->sbd_maxargs)`という要素数のチェックをスルーするように変更すると、1万要素とかでも普通に渡せるようになる.
数万以上になるとどんどん遅くなる。5万は結果が返ってくるが、10万は返ってこない。5万から10万のどこかで、以下のエラーに遭遇するようになる。

```
Error: 400 Bad Request
Virtuoso 37000 Error SP031: SPARQL: Internal error: The length of generated SQL text has exceeded 10000 lines of code
```
`libsrc/Wi/sparql2sql.h`の`if (SSG_MAX_ALLOWED_LINE_COUNT == ssg->ssg_line_count++)`というチェックをスルーするように変更すると、さらに以下のエラーにひっかかる.
```
Error: 500 Internal Server Error
Virtuoso ..... Error SQ200: Query too large, variables in state over the limit
```
`libsrc/Wi/wi.h`内で、`#define MAX_STATE_SLOTS 0xfffe`でなく`#define MAX_STATE_SLOTS 0xffffe`になるようにすれば、state lotsの限界が16倍になるが、それでもまだ以下のエラーが出る.
```
Error: 500 Internal Server Error
Virtuoso 42000 Error SQ199: Maximum size (32767) of a code vector exceeded by 3967441 bytes. Please split the code in smaller units.
```
`libsrc/Wi/sqlexp.c`の`if (BOFS_TO_OFS (byte_len) > SHRT_MAX)`というチェックをスルーするように変更すると、10万要素でも答えが返ってくるようになる. ただし遅い.

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
