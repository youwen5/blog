---
author: "Youwen Wu"
authorTwitter: "@youwen"
desc: "a purely functional...blog?"
image: "./images/waiheke-stony-batter.jpg"
keywords: "haskell, blog, functional programming"
lang: "en"
title: "Why I made my blog in haskell"
updated: "2024-05-25T12:00:00Z"
---

Welcome! This is the first post on _gradient ascent_ and also one that tests all
of the features.

<img
  alt="Grapevines among rolling hills leading to the sea"
  src="./images/waiheke-stony-batter.jpg"
  height="200"
/>

```haskell
toSlug :: T.Text -> T.Text
toSlug =
  T.intercalate (T.singleton '-') . T.words . T.toLower . clean
```

We can also try some math. Here is a simple theorem:

$$
a^2 + b^2 \ne c^2 \, \forall\,\left\{ a,\,b,\,c \right\} \in \mathbb{Z} \land a,\,b,\,c \ge 3
$$

Seems like it doesn't quite work yet.
