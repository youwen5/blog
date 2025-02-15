---
author: "Youwen Wu"
authorTwitter: "@youwen"
image: "https://wallpapercave.com/wp/wp12329537.png"
keywords: "linear algebra, algebra, math"
lang: "en"
title: "An assortment of preliminaries on linear algebra"
desc: "and also a test for pandoc"
---

This entire document was written entirely in [Typst](https://typst.app/) and
directly translated to this file by Pandoc. It serves as a proof of concept of
a way to do static site generation from Typst files instead of Markdown.

---

I figured I should write this stuff down before I forgot it.

# Basic Notions

## Vector spaces

Before we can understand vectors, we need to first discuss *vector
spaces*. Thus far, you have likely encountered vectors primarily in
physics classes, generally in the two-dimensional plane. You may
conceptualize them as arrows in space. For vectors of size $> 3$, a hand
waving argument is made that they are essentially just arrows in higher
dimensional spaces.

It is helpful to take a step back from this primitive geometric
understanding of the vector. Let us build up a rigorous idea of vectors
from first principles.

### Vector axioms

The so-called *axioms* of a *vector space* (which we'll call the vector
space $V$) are as follows:

1.  Commutativity: $u + v = v + u,\text{   }\forall u,v \in V$

2.  Associativity:
    $(u + v) + w = u + (v + w),\text{   }\forall u,v,w \in V$

3.  Zero vector: $\exists$ a special vector, denoted $0$, such that
    $v + 0 = v,\text{   }\forall v \in V$

4.  Additive inverse:
    $\forall v \in V,\text{   }\exists w \in V\text{ such that }v + w = 0$.
    Such an additive inverse is generally denoted $- v$

5.  Multiplicative identity: $1v = v,\text{   }\forall v \in V$

6.  Multiplicative associativity:
    $(\alpha\beta)v = \alpha(\beta v)\text{   }\forall v \in V,\text{ scalars }\alpha,\beta$

7.  Distributive property for vectors:
    $\alpha(u + v) = \alpha u + \alpha v\text{   }\forall u,v \in V,\text{ scalars }\alpha$

8.  Distributive property for scalars:
    $(\alpha + \beta)v = \alpha v + \beta v\text{   }\forall v \in V,\text{  scalars }\alpha,\beta$

It is easy to show that the zero vector $0$ and the additive inverse
$- v$ are *unique*. We leave the proof of this fact as an exercise.

These may seem difficult to memorize, but they are essentially the same
familiar algebraic properties of numbers you know from high school. The
important thing to remember is which operations are valid for what
objects. For example, you cannot add a vector and scalar, as it does not
make sense.

*Remark*. For those of you versed in computer science, you may recognize
this as essentially saying that you must ensure your operations are
*type-safe*. Adding a vector and scalar is not just "wrong" in the same
sense that $1 + 1 = 3$ is wrong, it is an *invalid question* entirely
because vectors and scalars and different types of mathematical objects.
See [@chen2024digression] for more.

### Vectors big and small

In order to begin your descent into what mathematicians colloquially
recognize as *abstract vapid nonsense*, let's discuss which fields
constitute a vector space. We have the familiar field of $\mathbb{R}$
where all scalars are real numbers, with corresponding vector spaces
${\mathbb{R}}^{n}$, where $n$ is the length of the vector. We generally
discuss 2D or 3D vectors, corresponding to vectors of length 2 or 3; in
our case, ${\mathbb{R}}^{2}$ and ${\mathbb{R}}^{3}$.

However, vectors in ${\mathbb{R}}^{n}$ can really be of any length.
Vectors can be viewed as arbitrary length lists of numbers (for the
computer science folk: think C++ `std::vector`).

*Example*. $$\begin{pmatrix}
1 \\
2 \\
3 \\
4 \\
5 \\
6 \\
7 \\
8 \\
9
\end{pmatrix} \in {\mathbb{R}}^{9}$$

Keep in mind that vectors need not be in ${\mathbb{R}}^{n}$ at all.
Recall that a vector space need only satisfy the aforementioned *axioms
of a vector space*.

*Example*. The vector space ${\mathbb{C}}^{n}$ is similar to
${\mathbb{R}}^{n}$, except it includes complex numbers. All complex
vector spaces are real vector spaces (as you can simply restrict them to
only use the real numbers), but not the other way around.

From now on, let us refer to vector spaces ${\mathbb{R}}^{n}$ and
${\mathbb{C}}^{n}$ as ${\mathbb{F}}^{n}$.

In general, we can have a vector space where the scalars are in an
arbitrary field, as long as the axioms are satisfied.

*Example*. The vector space of all polynomials of at most degree 3, or
${\mathbb{P}}^{3}$. It is not yet clear what this vector may look like.
We shall return to this example once we discuss *basis*.

## Vector addition. Multiplication

Vector addition, represented by $+$ can be done entrywise.

*Example.*

$$\begin{pmatrix}
1 \\
2 \\
3
\end{pmatrix} + \begin{pmatrix}
4 \\
5 \\
6
\end{pmatrix} = \begin{pmatrix}
1 + 4 \\
2 + 5 \\
3 + 6
\end{pmatrix} = \begin{pmatrix}
5 \\
7 \\
9
\end{pmatrix}$$ $$\begin{pmatrix}
1 \\
2 \\
3
\end{pmatrix} \cdot \begin{pmatrix}
4 \\
5 \\
6
\end{pmatrix} = \begin{pmatrix}
1 \cdot 4 \\
2 \cdot 5 \\
3 \cdot 6
\end{pmatrix} = \begin{pmatrix}
4 \\
10 \\
18
\end{pmatrix}$$

This is simple enough to understand. Again, the difficulty is simply
ensuring that you always perform operations with the correct *types*.
For example, once we introduce matrices, it doesn't make sense to
multiply or add vectors and matrices in this fashion.

## Vector-scalar multiplication

Multiplying a vector by a scalar simply results in each entry of the
vector being multiplied by the scalar.

*Example*.

$$\beta\begin{pmatrix}
a \\
b \\
c
\end{pmatrix} = \begin{pmatrix}
\beta \cdot a \\
\beta \cdot b \\
\beta \cdot c
\end{pmatrix}$$

## Linear combinations

Given vector spaces $V$ and $W$ and vectors $v \in V$ and $w \in W$,
$v + w$ is the *linear combination* of $v$ and $w$.

### Spanning systems

We say that a set of vectors $v_{1},v_{2},\ldots,v_{n} \in V$ *span* $V$
if the linear combination of the vectors can represent any arbitrary
vector $v \in V$.

Precisely, given scalars $\alpha_{1},\alpha_{2},\ldots,\alpha_{n}$,

$$\alpha_{1}v_{1} + \alpha_{2}v_{2} + \ldots + \alpha_{n}v_{n} = v,\forall v \in V$$

Note that any scalar $\alpha_{k}$ could be 0. Therefore, it is possible
for a subset of a spanning system to also be a spanning system. The
proof of this fact is left as an exercise.

### Intuition for linear independence and dependence

We say that $v$ and $w$ are linearly independent if $v$ cannot be
represented by the scaling of $w$, and $w$ cannot be represented by the
scaling of $v$. Otherwise, they are *linearly dependent*.

You may intuitively visualize linear dependence in the 2D plane as two
vectors both pointing in the same direction. Clearly, scaling one vector
will allow us to reach the other vector. Linear independence is
therefore two vectors pointing in different directions.

Of course, this definition applies to vectors in any ${\mathbb{F}}^{n}$.

### Formal definition of linear dependence and independence

Let us formally define linear independence for arbitrary vectors in
${\mathbb{F}}^{n}$. Given a set of vectors

$$v_{1},v_{2},\ldots,v_{n} \in V$$

we say they are linearly independent iff. the equation

$$\alpha_{1}v_{1} + \alpha_{2}v_{2} + \ldots + \alpha_{n}v_{n} = 0$$

has only a unique set of solutions
$\alpha_{1},\alpha_{2},\ldots,\alpha_{n}$ such that all $\alpha_{n}$ are
zero.

Equivalently,

$$\left| \alpha_{1} \right| + \left| \alpha_{2} \right| + \ldots + \left| \alpha_{n} \right| = 0$$

More precisely,

$$\sum_{i = 1}^{k}\left| \alpha_{i} \right| = 0$$

Therefore, a set of vectors $v_{1},v_{2},\ldots,v_{m}$ is linearly
dependent if the opposite is true, that is there exists solution
$\alpha_{1},\alpha_{2},\ldots,\alpha_{m}$ to the equation

$$\alpha_{1}v_{1} + \alpha_{2}v_{2} + \ldots + \alpha_{m}v_{m} = 0$$

such that

$$\sum_{i = 1}^{k}\left| \alpha_{i} \right| \neq 0$$

### Basis

We say a system of vectors $v_{1},v_{2},\ldots,v_{n} \in V$ is a *basis*
in $V$ if the system is both linearly independent and spanning. That is,
the system must be able to represent any vector in $V$ as well as
satisfy our requirements for linear independence.

Equivalently, we may say that a system of vectors in $V$ is a basis in
$V$ if any vector $v \in V$ admits a *unique representation* as a linear
combination of vectors in the system. This is equivalent to our previous
statement, that the system must be spanning and linearly independent.

### Standard basis

We may define a *standard basis* for a vector space. By convention, the
standard basis in ${\mathbb{R}}^{2}$ is

$$\begin{pmatrix}
1 \\
0
\end{pmatrix}\begin{pmatrix}
0 \\
1
\end{pmatrix}$$

Verify that the above is in fact a basis (that is, linearly independent
and generating).

Recalling the definition of the basis, we can represent any vector in
${\mathbb{R}}^{2}$ as the linear combination of the standard basis.

Therefore, for any arbitrary vector $v \in {\mathbb{R}}^{2}$, we can
represent it as

$$v = \alpha_{1}\begin{pmatrix}
1 \\
0
\end{pmatrix} + \alpha_{2}\begin{pmatrix}
0 \\
1
\end{pmatrix}$$

Let us call $\alpha_{1}$ and $\alpha_{2}$ the *coordinates* of the
vector. Then, we can write $v$ as

$$v = \begin{pmatrix}
\alpha_{1} \\
\alpha_{2}
\end{pmatrix}$$

For example, the vector

$$\begin{pmatrix}
1 \\
2
\end{pmatrix}$$

represents

$$1 \cdot \begin{pmatrix}
1 \\
0
\end{pmatrix} + 2 \cdot \begin{pmatrix}
0 \\
1
\end{pmatrix}$$

Verify that this aligns with your previous intuition of vectors.

You may recognize the standard basis in ${\mathbb{R}}^{2}$ as the
familiar unit vectors

$$\hat{i},\hat{j}$$

This aligns with the fact that

$$\begin{pmatrix}
\alpha \\
\beta
\end{pmatrix} = \alpha\hat{i} + \beta\hat{j}$$

However, we may define a standard basis in any arbitrary vector space.
So, let

$$e_{1},e_{2},\ldots,e_{n}$$

be a standard basis in ${\mathbb{F}}^{n}$. Then, the coordinates
$\alpha_{1},\alpha_{2},\ldots,\alpha_{n}$ of a vector
$v \in {\mathbb{F}}^{n}$ represent the following

$$\begin{pmatrix}
\alpha_{1} \\
\alpha_{2} \\
 \vdots \\
\alpha_{n}
\end{pmatrix} = \alpha_{1}e_{1} + \alpha_{2} + e_{2} + \alpha_{n}e_{n}$$

Using our new notation, the standard basis in ${\mathbb{R}}^{2}$ is

$$e_{1} = \begin{pmatrix}
1 \\
0
\end{pmatrix},e_{2} = \begin{pmatrix}
0 \\
1
\end{pmatrix}$$

## Matrices

Before discussing any properties of matrices, let's simply reiterate
what we learned in class about their notation. We say a matrix with rows
of length $m$, and columns of size $n$ (in less precise terms, a matrix
with length $m$ and height $n$) is a $m \times n$ matrix.

Given a matrix

$$A = \begin{pmatrix}
1 & 2 & 3 \\
4 & 5 & 6 \\
7 & 8 & 9
\end{pmatrix}$$

we refer to the entry in row $j$ and column $k$ as $A_{j,k}$ .

### Matrix transpose

A formalism that is useful later on is called the *transpose*, and we
obtain it from a matrix $A$ by switching all the rows and columns. More
precisely, each row becomes a column instead. We use the notation
$A^{T}$ to represent the transpose of $A$.

$$\begin{pmatrix}
1 & 2 & 3 \\
4 & 5 & 6
\end{pmatrix}^{T} = \begin{pmatrix}
1 & 4 \\
2 & 5 \\
3 & 6
\end{pmatrix}$$

Formally, we can say $\left( A^{T} \right)_{j,k} = A_{k,j}$

## Linear transformations

A linear transformation $T:V \rightarrow W$ is a mapping between two
vector spaces $V \rightarrow W$, such that the following axioms are
satisfied:

1.  $T(v + w) = T(v) + T(w),\forall v \in V,\forall w \in W$

2.  $T(\alpha v) + T(\beta w) = \alpha T(v) + \beta T(w),\forall v \in V,\forall w \in W$,
    for all scalars $\alpha,\beta$

*Definition*. $T$ is a linear transformation iff.

$$T(\alpha v + \beta w) = \alpha T(v) + \beta T(w)$$

*Abuse of notation*. From now on, we may elide the parentheses and say
that $$T(v) = Tv,\forall v \in V$$

*Remark*. A phrase that you may commonly hear is that linear
transformations preserve *linearity*. Essentially, straight lines remain
straight, parallel lines remain parallel, and the origin remains fixed
at 0. Take a moment to think about why this is true (at least, in lower
dimensional spaces you can visualize).

*Examples*.

1.  Rotation for $V = W = {\mathbb{R}}^{2}$ (i.e. rotation in 2
    dimensions). Given $v,w \in {\mathbb{R}}^{2}$, and their linear
    combination $v + w$, a rotation of $\gamma$ radians of $v + w$ is
    equivalent to first rotating $v$ and $w$ individually by $\gamma$
    and then taking their linear combination.

2.  Differentiation of polynomials. In this case $V = {\mathbb{P}}^{n}$
    and $W = {\mathbb{P}}^{n - 1}$, where ${\mathbb{P}}^{n}$ is the
    field of all polynomials of degree at most $n$.

    $$\frac{d}{dx}(\alpha v + \beta w) = \alpha\frac{d}{dx}v + \beta\frac{d}{dx}w,\forall v \in V,w \in W,\forall\text{ scalars }\alpha,\beta$$

## Matrices represent linear transformations

Suppose we wanted to represent a linear transformation
$T:{\mathbb{F}}^{n} \rightarrow {\mathbb{F}}^{m}$. I propose that we
need encode how $T$ acts on the standard basis of ${\mathbb{F}}^{n}$.

Using our intuition from lower dimensional vector spaces, we know that
the standard basis in ${\mathbb{R}}^{2}$ is the unit vectors $\hat{i}$
and $\hat{j}$. Because linear transformations preserve linearity (i.e.
all straight lines remain straight and parallel lines remain parallel),
we can encode any transformation as simply changing $\hat{i}$ and
$\hat{j}$. And indeed, if any vector $v \in {\mathbb{R}}^{2}$ can be
represented as the linear combination of $\hat{i}$ and $\hat{j}$ (this
is the definition of a basis), it makes sense both symbolically and
geometrically that we can represent all linear transformations as the
transformations of the basis vectors.

*Example*. To reflect all vectors $v \in {\mathbb{R}}^{2}$ across the
$y$-axis, we can simply change the standard basis to

$$\begin{pmatrix}
 - 1 \\
0
\end{pmatrix}\begin{pmatrix}
0 \\
1
\end{pmatrix}$$

Then, any vector in ${\mathbb{R}}^{2}$ using this new basis will be
reflected across the $y$-axis. Take a moment to justify this
geometrically.

### Writing a linear transformation as matrix

For any linear transformation
$T:{\mathbb{F}}^{m} \rightarrow {\mathbb{F}}^{n}$, we can write it as an
$n \times m$ matrix $A$. That is, there is a matrix $A$ with $n$ rows
and $m$ columns that can represent any linear transformation from
${\mathbb{F}}^{m} \rightarrow {\mathbb{F}}^{n}$.

How should we write this matrix? Naturally, from our previous
discussion, we should write a matrix with each *column* being one of our
new transformed *basis* vectors.

*Example*. Our $y$-axis reflection transformation from earlier. We write
the bases in a matrix

$$\begin{pmatrix}
 - 1 & 0 \\
0 & 1
\end{pmatrix}$$

### Matrix-vector multiplication

Perhaps you now see why the so-called matrix-vector multiplication is
defined the way it is. Recalling our definition of a basis, given a
basis in $V$, any vector $v \in V$ can be written as the linear
combination of the vectors in the basis. Then, given a linear
transformation represented by the matrix containing the new basis, we
simply write the linear combination with the new basis instead.

*Example*. Let us first write a vector in the standard basis in
${\mathbb{R}}^{2}$ and then show how our matrix-vector multiplication
naturally corresponds to the definition of the linear transformation.

$$\begin{pmatrix}
1 \\
2
\end{pmatrix} \in {\mathbb{R}}^{2}$$

is the same as

$$1 \cdot \begin{pmatrix}
1 \\
0
\end{pmatrix} + 2 \cdot \begin{pmatrix}
0 \\
1
\end{pmatrix}$$

Then, to perform our reflection, we need only replace the basis vector
$\begin{pmatrix}
1 \\
0
\end{pmatrix}$ with $\begin{pmatrix}
 - 1 \\
0
\end{pmatrix}$.

Then, the reflected vector is given by

$$1 \cdot \begin{pmatrix}
 - 1 \\
0
\end{pmatrix} + 2 \cdot \begin{pmatrix}
0 \\
1
\end{pmatrix} = \begin{pmatrix}
 - 1 \\
2
\end{pmatrix}$$

We can clearly see that this is exactly how the matrix multiplication

$$\begin{pmatrix}
 - 1 & 0 \\
0 & 1
\end{pmatrix} \cdot \begin{pmatrix}
1 \\
2
\end{pmatrix}$$ is defined! The *column-by-coordinate* rule for
matrix-vector multiplication says that we multiply the $n^{\text{th}}$
entry of the vector by the corresponding $n^{\text{th}}$ column of the
matrix and sum them all up (take their linear combination). This
algorithm intuitively follows from our definition of matrices.

### Matrix-matrix multiplication

As you may have noticed, a very similar natural definition arises for
the *matrix-matrix* multiplication. Multiplying two matrices $A \cdot B$
is essentially just taking each column of $B$, and applying the linear
transformation defined by the matrix $A$!
