# Caching Historical Embeddings in Conversational Search

This repository contains the code accompanying the paper:

> Ophir Frieder, Ida Mele, Cristina Ioana Muntean, Franco Maria Nardini, Raffaele Perego, and Nicola Tonellotto.
> **Caching Historical Embeddings in Conversational Search.**
> *ACM Transactions on the Web*, 18(4), Article 42, November 2024.
> https://doi.org/10.1145/3578519

## Overview

Conversational search systems typically rely on dense retrieval over large document
collections, where each user utterance is encoded and matched against pre-computed
document embeddings via approximate nearest-neighbour (ANN) search. This is
expensive at query time.

The paper explores **caching historical embeddings** — reusing previously retrieved
document embeddings across the turns of a conversation (and across users) to
reduce the cost of dense retrieval without hurting effectiveness. The repository
provides the experimental pipeline used in the paper on the TREC CAsT 2019, 2020,
and 2021 collections.

## Repository layout

```
.
├── data/                          # Datasets, qrels, rankings used in the experiments
│   ├── CAST-2019/                 # TREC CAsT 2019 topics/utterances
│   ├── CAST-2020/                 # TREC CAsT 2020 topics/utterances
│   ├── CAST-2021/                 # TREC CAsT 2021 topics/utterances
│   ├── CAST_qrels/                # Relevance judgements
│   ├── star-ranking/              # STAR dense retrieval rankings
│   ├── adore-star-ranking/        # ADORE+STAR rankings
│   └── BERT-reranking/            # BERT reranker outputs
│
├── notebooks/                     # Experimental pipeline (Jupyter)
│   ├── Index CAST collections.ipynb
│   ├── Relevant docs Star embeddings.ipynb
│   ├── Distances.ipynb
│   ├── 0.Pyterrier - Upperbound.ipynb
│   ├── 1.Star sim search - Upperbound.ipynb
│   ├── 2.a Star faiss - cache.ipynb
│   ├── 2.b Star faiss - cache with dist.ipynb
│   ├── 2.c. Star faiss - cache with UPDATE.ipynb
│   ├── 3. Evaluation-by-distances.ipynb
│   └── 3. Evaluation-trec-eval.ipynb
│
├── src/
│   └── pyterrier_index_search.py  # PyTerrier / Terrier helpers
│
├── scripts/
│   └── trec_eval_CAST_6m_reranking.sh   # trec_eval wrapper for CAST runs
│
├── LICENSE
└── README.md
```

### Notebooks at a glance

| Notebook | Purpose |
|---|---|
| `Index CAST collections.ipynb` | Build the Terrier sparse indexes for the CAsT collections. |
| `Relevant docs Star embeddings.ipynb` | Extract STAR embeddings for relevant documents. |
| `Distances.ipynb` | Analyse embedding distances between turns/queries. |
| `0.Pyterrier - Upperbound.ipynb` | Sparse-retrieval upper-bound baseline. |
| `1.Star sim search - Upperbound.ipynb` | Dense-retrieval (STAR) upper-bound baseline. |
| `2.a Star faiss - cache.ipynb` | Caching strategy over a FAISS index of STAR embeddings. |
| `2.b Star faiss - cache with dist.ipynb` | Cache variant using inter-turn embedding distances. |
| `2.c. Star faiss - cache with UPDATE.ipynb` | Cache variant with online cache updates. |
| `3. Evaluation-by-distances.ipynb` | Distance-based effectiveness analysis. |
| `3. Evaluation-trec-eval.ipynb` | TREC-style effectiveness evaluation. |

## Dependencies

The experiments rely on:

- Python 3.8+
- [PyTerrier](https://github.com/terrier-org/pyterrier) and Terrier (via `pyjnius`)
- [FAISS](https://github.com/facebookresearch/faiss)
- `numpy`, `pandas`, `jupyter`
- [`trec_eval`](https://github.com/usnistgov/trec_eval) on the `PATH` for evaluation
- A Java runtime (required by Terrier)

## How to run

1. Install the dependencies above.
2. Build the sparse indexes with `notebooks/Index CAST collections.ipynb`. The
   helper in `src/pyterrier_index_search.py` expects an index at
   `indexes/CAST2020-stemmed/`.
3. Place the STAR / ADORE+STAR rankings and embeddings under `data/` (the
   expected sub-directories are already present).
4. Run the upper-bound baselines (`0.*`, `1.*`) and then the caching experiments
   (`2.a`, `2.b`, `2.c`).
5. Evaluate with the notebooks in `3.*` or via the trec_eval wrapper in
   `scripts/trec_eval_CAST_6m_reranking.sh` (fill in `CURR_DIR` and `DATA_DIR`
   before running).

## Citation

If you use this code or build upon this work, please cite:

```bibtex
@article{10.1145/3578519,
  author    = {Frieder, Ophir and Mele, Ida and Muntean, Cristina Ioana and
               Nardini, Franco Maria and Perego, Raffaele and Tonellotto, Nicola},
  title     = {Caching Historical Embeddings in Conversational Search},
  journal   = {ACM Transactions on the Web},
  volume    = {18},
  number    = {4},
  articleno = {42},
  numpages  = {19},
  month     = nov,
  year      = {2024},
  publisher = {Association for Computing Machinery},
  address   = {New York, NY, USA},
  issn      = {1559-1131},
  doi       = {10.1145/3578519},
  url       = {https://doi.org/10.1145/3578519}
}
```

## Contact

For questions about the code or the paper, please contact:

**Cristina Ioana Muntean** — [cristina.muntean@isti.cnr.it](mailto:cristina.muntean@isti.cnr.it)
HPC Laboratory, ISTI-CNR, Pisa, Italy

## License

This code is released under the [MIT License](LICENSE).
Copyright © 2022 HPC Laboratory @ ISTI-CNR.
