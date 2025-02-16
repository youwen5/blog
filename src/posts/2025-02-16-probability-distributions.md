---
author: "Youwen Wu"
authorTwitter: "@youwen"
keywords: "probability, counting, math, expected value, distributions"
lang: "en"
title: "Random variables, distributions, and probability theory"
desc: "An overview of discrete and continuous random variables and their distributions and moment generating functions"
---

These are some notes I've been collecting on random variables, their
distributions, expected values, and moment generating functions. I
thought I'd write them down somewhere useful.

These are almost extracted verbatim from my in-class notes, which I take
in real time using Typst. I simply wrote a tiny compatibility shim to
allow Pandoc to render them to the web.

---

## Random variables

First, some brief exposition on random variables. Quixotically, a random
variable is actually a function.

Standard notation, $\Omega$ is sample space, $\omega$ is an event.

*Definition. *

A **random variable** $X$ is a function
$X:\Omega \rightarrow {\mathbb{R}}$ that gives the probability of an
event $\omega \in \Omega$.

*Definition. *

The **state space** of a random variable $X$ is all of the values $X$
can take.

*Example. *

Let $X$ be a random variable that takes on the values
$\left\{ 0,1,2,3 \right\}$. Then the state space of $X$ is the set
$\left\{ 0,1,2,3 \right\}$.

### Discrete random variables

A random variable $X$ is discrete if there is countable $A$ such that
$P(X \in A) = 1$. $k$ is a possible value if $P(X = k) > 0$. We discuss
continuous random variables later.

The *probability distribution* of $X$ gives its important probabilistic
information. The probability distribution is a description of the
probabilities $P(X \in B)$ for subsets $B \in {\mathbb{R}}$. We describe
the probability density function and the cumulative distribution
function.

A discrete random variable has probability distribution entirely
determined by its probability mass function (hereafter abbreviated p.m.f
or PMF) $p(k) = P(X = k)$. The p.m.f. is a function from the set of
possible values of $X$ into $\lbrack 0,1\rbrack$. Labeling the p.m.f.
with the random variable is done by $p_{X}(k)$.

$$p_{X}:\text{ State space of }X \rightarrow \lbrack 0,1\rbrack$$

By the axioms of probability,

$$\sum_{k}p_{X}(k) = \sum_{k}P(X = k) = 1$$

For a subset $B \subset {\mathbb{R}}$,

$$P(X \in B) = \sum_{k \in B}p_{X}(k)$$

### Continuous random variables

Now as promised we introduce another major class of random variables.

*Definition. *

Let $X$ be a random variable. If $f$ satisfies

$$P(X \leq b) = \int_{- \infty}^{b}f(x)dx$$

for all $b \in {\mathbb{R}}$, then $f$ is the **probability density
function** (hereafter abbreviated p.d.f. or PDF) of $X$.

We immediately see that the p.d.f. is analogous to the c.d.f. of the
discrete case.

The probability that $X \in ( - \infty,b\rbrack$ is equal to the area
under the graph of $f$ from $- \infty$ to $b$.

A corollary is the following.

*Fact. *

$$P(X \in B) = \int_{B}f(x)dx$$

for any $B \subset {\mathbb{R}}$ where integration makes sense.

The set can be bounded or unbounded, or any collection of intervals.

*Fact. *

$$P(a \leq X \leq b) = \int_{a}^{b}f(x)dx$$
$$P(X > a) = \int_{a}^{\infty}f(x)dx$$

*Fact. *

If a random variable $X$ has density function $f$ then individual point
values have probability zero:

$$P(X = c) = \int_{c}^{c}f(x)dx = 0,\forall c \in {\mathbb{R}}$$

*Remark. *

It follows a random variable with a density function is not discrete. An
immediate corollary of this is that the probabilities of intervals are
not changed by including or excluding endpoints. So $P(X \leq k)$ and
$P(X < k)$ are equivalent.

How to determine which functions are p.d.f.s? Since
$P( - \infty < X < \infty) = 1$, a p.d.f. $f$ must satisfy

$$\begin{array}{r}
f(x) \geq 0\forall x \in {\mathbb{R}} \\
\int_{- \infty}^{\infty}f(x)dx = 1
\end{array}$$

*Fact. *

Random variables with density functions are called *continuous* random
variables. This does not imply that the random variable is a continuous
function on $\Omega$ but it is standard terminology.

## Discrete distributions

Recall that the *probability distribution* of $X$ gives its important
probabilistic information. Let us discuss some of these distributions.

In general we first consider the experiment's properties and theorize
about the distribution that its random variable takes. We can then apply
the distribution to find out various pieces of probabilistic
information.

### Bernoulli trials

A Bernoulli trial is the original "experiment." It's simply a single
trial with a binary "success" or "failure" outcome. Encode this T/F, 0
or 1, or however you'd like. It becomes immediately useful in defining
more complex distributions, so let's analyze its properties.

The setup: the experiment has exactly two outcomes:

-   Success -- $S$ or 1

-   Failure -- $F$ or 0

Additionally: $$\begin{array}{r}
P(S) = p,(0 < p < 1) \\
P(F) = 1 - p = q
\end{array}$$

Construct the probability mass function:

$$\begin{array}{r}
P(X = 1) = p \\
P(X = 0) = 1 - p
\end{array}$$

Write it as:

$$p_{x(k)} = p^{k}(1 - p)^{1 - k}$$

for $k = 1$ and $k = 0$.

### Binomial distribution

The setup: very similar to Bernoulli, trials have exactly 2 outcomes. A
bunch of Bernoulli trials in a row.

Importantly: $p$ and $q$ are defined exactly the same in all trials.

This ties the binomial distribution to the sampling with replacement
model, since each trial does not affect the next.

We conduct $n$ **independent** trials of this experiment. Example with
coins: each flip independently has a $\frac{1}{2}$ chance of heads or
tails (holds same for die, rigged coin, etc).

$n$ is fixed, i.e. known ahead of time.

#### Binomial random variable

Let's consider the random variable characterized by the binomial
distribution now.

Let $X = \#$ of successes in $n$ independent trials. For any particular
sequence of $n$ trials, it takes the form
$\Omega = \left\{ \omega \right\}\text{ where }\omega = SFF\cdots F$ and
is of length $n$.

Then $X(\omega) = 0,1,2,\ldots,n$ can take $n + 1$ possible values. The
probability of any particular sequence is given by the product of the
individual trial probabilities.

*Example. *

$$\omega = SFFSF\cdots S = (pqqpq\cdots p)$$

So $P(x = 0) = P(FFF\cdots F) = q \cdot q \cdot \cdots \cdot q = q^{n}$.

And $$\begin{array}{r}
P(X = 1) = P(SFF\cdots F) + P(FSFF\cdots F) + \cdots + P(FFF\cdots FS) \\
 = \underset{\text{ possible outcomes}}{\underbrace{n}} \cdot p^{1} \cdot p^{n - 1} \\
 = \begin{pmatrix}
n \\
1
\end{pmatrix} \cdot p^{1} \cdot p^{n - 1} \\
 = n \cdot p^{1} \cdot p^{n - 1}
\end{array}$$

Now we can generalize

$$P(X = 2) = \begin{pmatrix}
n \\
2
\end{pmatrix}p^{2}q^{n - 2}$$

How about all successes?

$$P(X = n) = P(SS\cdots S) = p^{n}$$

We see that for all failures we have $q^{n}$ and all successes we have
$p^{n}$. Otherwise we use our method above.

In general, here is the probability mass function for the binomial
random variable

$$P(X = k) = \begin{pmatrix}
n \\
k
\end{pmatrix}p^{k}q^{n - k},\text{ for }k = 0,1,2,\ldots,n$$

Binomial distribution is very powerful. Choosing between two things,
what are the probabilities?

To summarize the characterization of the binomial random variable:

-   $n$ independent trials

-   each trial results in binary success or failure

-   with probability of success $p$, identically across trials

with $X = \#$ successes in **fixed** $n$ trials.

$$X\sim\text{ Bin}(n,p)$$

with probability mass function

$$P(X = x) = \begin{pmatrix}
n \\
x
\end{pmatrix}p^{x}(1 - p)^{n - x} = p(x)\text{ for }x = 0,1,2,\ldots,n$$

We see this is in fact the binomial theorem!

$$p(x) \geq 0,\sum_{x = 0}^{n}p(x) = \sum_{x = 0}^{n}\begin{pmatrix}
n \\
x
\end{pmatrix}p^{x}q^{n - x} = (p + q)^{n}$$

In fact, $$(p + q)^{n} = \left( p + (1 - p) \right)^{n} = 1$$

*Example. *

What is the probability of getting exactly three aces (1's) out of 10
throws of a fair die?

Seems a little trickier but we can still write this as well defined
$S$/$F$. Let $S$ be getting an ace and $F$ being anything else.

Then $p = \frac{1}{6}$ and $n = 10$. We want $P(X = 3)$. So

$$\begin{array}{r}
P(X = 3) = \begin{pmatrix}
10 \\
3
\end{pmatrix}p^{3}q^{7} = \begin{pmatrix}
10 \\
3
\end{pmatrix}\left( \frac{1}{6} \right)^{3}\left( \frac{5}{6} \right)^{7} \\
 \approx 0.15505
\end{array}$$

#### With or without replacement?

I place particular emphasis on the fact that the binomial distribution
generally applies to cases where you're sampling with *replacement*.
Consider the following: *Example. *

Suppose we have two types of candy, red and black. Select $n$ candies.
Let $X$ be the number of red candies among $n$ selected.

2 cases.

-   case 1: with replacement: Binomial Distribution, $n$,
    $p = \frac{a}{a + b}$.

$$P(X = 2) = \begin{pmatrix}
n \\
2
\end{pmatrix}\left( \frac{a}{a + b} \right)^{2}\left( \frac{b}{a + b} \right)^{n - 2}$$

-   case 2: without replacement: then use counting

$$P(X = x) = \frac{\begin{pmatrix}
a \\
x
\end{pmatrix}\begin{pmatrix}
b \\
n - x
\end{pmatrix}}{\begin{pmatrix}
a + b \\
n
\end{pmatrix}} = p(x)$$

In case 2, we used the elementary counting techniques we are already
familiar with. Immediately we see a distinct case similar to the
binomial but when sampling without replacement. Let's formalize this as
a random variable!

### Hypergeometric distribution

Let's introduce a random variable to represent a situation like case 2
above.

*Definition. *

$$P(X = x) = \frac{\begin{pmatrix}
a \\
x
\end{pmatrix}\begin{pmatrix}
b \\
n - x
\end{pmatrix}}{\begin{pmatrix}
a + b \\
n
\end{pmatrix}} = p(x)$$

is known as a **Hypergeometric distribution**.

Abbreviate this by:

$$X\sim\text{ Hypergeom}\left( \#\text{ total},\#\text{ successes},\text{ sample size} \right)$$

For example,

$$X\sim\text{ Hypergeom}\left( N,N_{a},n \right)$$

*Remark. *

If $x$ is very small relative to $a + b$, then both cases give similar
(approx. the same) answers.

For instance, if we're sampling for blood types from UCSB, and we take a
student out without replacement, we don't really change the sample size
substantially. So both answers give a similar result.

Suppose we have two types of items, type $A$ and type $B$. Let $N_{A}$
be $\#$ type $A$, $N_{B}$ $\#$ type $B$. $N = N_{A} + N_{B}$ is the
total number of objects.

We sample $n$ items **without replacement** ($n \leq N$) with order not
mattering. Denote by $X$ the number of type $A$ objects in our sample.

*Definition. *

Let $0 \leq N_{A} \leq N$ and $1 \leq n \leq N$ be integers. A random
variable $X$ has the **hypergeometric distribution** with parameters
$\left( N,N_{A},n \right)$ if $X$ takes values in the set
$\left\{ 0,1,\ldots,n \right\}$ and has p.m.f.

$$P(X = k) = \frac{\begin{pmatrix}
N_{A} \\
k
\end{pmatrix}\begin{pmatrix}
N - N_{A} \\
n - k
\end{pmatrix}}{\begin{pmatrix}
N \\
n
\end{pmatrix}} = p(k)$$

*Example. *

Let $N_{A} = 10$ defectives. Let $N_{B} = 90$ non-defectives. We select
$n = 5$ without replacement. What is the probability that 2 of the 5
selected are defective?

$$X\sim\text{ Hypergeom }\left( N = 100,N_{A} = 10,n = 5 \right)$$

We want $P(X = 2)$.

$$P(X = 2) = \frac{\begin{pmatrix}
10 \\
2
\end{pmatrix}\begin{pmatrix}
90 \\
3
\end{pmatrix}}{\begin{pmatrix}
100 \\
5
\end{pmatrix}} \approx 0.0702$$

*Remark. *

Make sure you can distinguish when a problem is binomial or when it is
hypergeometric. This is very important on exams.

Recall that both ask about number of successes, in a fixed number of
trials. But binomial is sample with replacement (each trial is
independent) and sampling without replacement is hypergeometric.

### Geometric distribution

Consider an infinite sequence of independent trials. e.g. number of
attempts until I make a basket.

In fact we can think of this as a variation on the binomial
distribution. But in this case we don't sample $n$ times and ask how
many successes we have, we sample as many times as we need for *one*
success. Later on we'll see this is really a specific case of another
distribution, the *negative binomial*.

Let $X_{i}$ denote the outcome of the $i^{\text{th}}$ trial, where
success is 1 and failure is 0. Let $N$ be the number of trials needed to
observe the first success in a sequence of independent trials with
probability of success $p$. Then

We fail $k - 1$ times and succeed on the $k^{\text{th}}$ try. Then:

$$P(N = k) = P\left( X_{1} = 0,X_{2} = 0,\ldots,X_{k - 1} = 0,X_{k} = 1 \right) = (1 - p)^{k - 1}p$$

This is the probability of failures raised to the amount of failures,
times probability of success.

The key characteristic in these trials, we keep going until we succeed.
There's no $n$ choose $k$ in front like the binomial distribution
because there's exactly one sequence that gives us success.

*Definition. *

Let $0 < p \leq 1$. A random variable $X$ has the geometric distribution
with success parameter $p$ if the possible values of $X$ are
$\left\{ 1,2,3,\ldots \right\}$ and $X$ satisfies

$$P(X = k) = (1 - p)^{k - 1}p$$

for positive integers $k$. Abbreviate this by $X\sim\text{ Geom}(p)$.

*Example. *

What is the probability it takes more than seven rolls of a fair die to
roll a six?

Let $X$ be the number of rolls of a fair die until the first six. Then
$X\sim\text{ Geom}\left( \frac{1}{6} \right)$. Now we just want
$P(X > 7)$.

$$P(X > 7) = \sum_{k = 8}^{\infty}P(X = k) = \sum_{k = 8}^{\infty}\left( \frac{5}{6} \right)^{k - 1}\frac{1}{6}$$

Re-indexing,

$$\sum_{k = 8}^{\infty}\left( \frac{5}{6} \right)^{k - 1}\frac{1}{6} = \frac{1}{6}\left( \frac{5}{6} \right)^{7}\sum_{j = 0}^{\infty}\left( \frac{5}{6} \right)^{j}$$

Now we calculate by standard methods:

$$\frac{1}{6}\left( \frac{5}{6} \right)^{7}\sum_{j = 0}^{\infty}\left( \frac{5}{6} \right)^{j} = \frac{1}{6}\left( \frac{5}{6} \right)^{7} \cdot \frac{1}{1 - \frac{5}{6}} = \left( \frac{5}{6} \right)^{7}$$

### Negative binomial

As promised, here's the negative binomial.

Consider a sequence of Bernoulli trials with the following
characteristics:

-   Each trial success or failure

-   Prob. of success $p$ is same on each trial

-   Trials are independent (notice they are not fixed to specific
    number)

-   Experiment continues until $r$ successes are observed, where $r$ is
    a given parameter

Then if $X$ is the number of trials necessary until $r$ successes are
observed, we say $X$ is a **negative binomial** random variable.

Immediately we see that the geometric distribution is just the negative
binomial with $r = 1$.

*Definition. *

Let $k \in {\mathbb{Z}}^{+}$ and $0 < p \leq 1$. A random variable $X$
has the negative binomial distribution with parameters
$\left\{ k,p \right\}$ if the possible values of $X$ are the integers
$\left\{ k,k + 1,k + 2,\ldots \right\}$ and the p.m.f. is

$$P(X = n) = \begin{pmatrix}
n - 1 \\
k - 1
\end{pmatrix}p^{k}(1 - p)^{n - k}\text{ for }n \geq k$$

Abbreviate this by $X\sim\text{ Negbin}(k,p)$.

*Example. *

Steph Curry has a three point percentage of approx. $43\%$. What is the
probability that Steph makes his third three-point basket on his
$5^{\text{th}}$ attempt?

Let $X$ be number of attempts required to observe the 3rd success. Then,

$$X\sim\text{ Negbin}(k = 3,p = 0.43)$$

So, $$\begin{aligned}
P(X = 5) & = {\begin{pmatrix}
5 - 1 \\
3 - 1
\end{pmatrix}(0.43)}^{3}(1 - 0.43)^{5 - 3} \\
 & = \begin{pmatrix}
4 \\
2
\end{pmatrix}(0.43)^{3}(0.57)^{2} \\
 & \approx 0.155
\end{aligned}$$

### Poisson distribution

This p.m.f. follows from the Taylor expansion

$$e^{\lambda} = \sum_{k = 0}^{\infty}\frac{\lambda^{k}}{k!}$$

which implies that

$$\sum_{k = 0}^{\infty}e^{- \lambda}\frac{\lambda^{k}}{k!} = e^{- \lambda}e^{\lambda} = 1$$

*Definition. *

For an integer valued random variable $X$, we say
$X\sim\text{ Poisson}(\lambda)$ if it has p.m.f.

$$P(X = k) = e^{- \lambda}\frac{\lambda^{k}}{k!}$$

for $k \in \left\{ 0,1,2,\ldots \right\}$ for $\lambda > 0$ and

$$\sum_{k = 0}^{\infty}P(X = k) = 1$$

The Poisson arises from the Binomial. It applies in the binomial context
when $n$ is very large ($n \geq 100$) and $p$ is very small
$p \leq 0.05$, such that $np$ is a moderate number ($np < 10$).

Then $X$ follows a Poisson distribution with $\lambda = np$.

$$P\left( \text{Bin}(n,p) = k \right) \approx P\left( \text{Poisson}(\lambda = np) = k \right)$$

for $k = 0,1,\ldots,n$.

The Poisson distribution is useful for finding the probabilities of rare
events over a continuous interval of time. By knowing $\lambda = np$ for
small $n$ and $p$, we can calculate many probabilities.

*Example. *

The number of typing errors in the page of a textbook.

Let

-   $n$ be the number of letters of symbols per page (large)

-   $p$ be the probability of error, small enough such that

-   $\lim\limits_{n \rightarrow \infty}\lim\limits_{p \rightarrow 0}np = \lambda = 0.1$

What is the probability of exactly 1 error?

We can approximate the distribution of $X$ with a
$\text{Poisson}(\lambda = 0.1)$ distribution

$$P(X = 1) = \frac{e^{- 0.1}(0.1)^{1}}{1!} = 0.09048$$

## Continuous distributions

All of the distributions we've been analyzing have been discrete, that
is, they apply to random variables with a
[countable](https://en.wikipedia.org/wiki/Countable_set) state space.
Even when the state space is infinite, as in the negative binomial, it
is countable. We can think of it as indexing each trial with a natural
number $0,1,2,3,\ldots$.

Now we turn our attention to continuous random variables that operate on
uncountably infinite state spaces. For example, if we sample uniformly
inside of the interval $\lbrack 0,1\rbrack$, there are an uncountably
infinite number of possible values we could obtain. We cannot index
these values by the natural numbers, by some theorems of set theory we
in fact know that the interval $\lbrack 0,1\rbrack$ has a bijection to
$\mathbb{R}$ and has cardinality $א_{1}$.

Additionally we notice that asking for the probability that we pick a
certain point in the interval $\lbrack 0,1\rbrack$ makes no sense, there
are an infinite amount of sample points! Intuitively we should think
that the probability of choosing any particular point is 0. However, we
should be able to make statements about whether we can choose a point
that lies within a subset, like $\lbrack 0,0.5\rbrack$.

Let's formalize these ideas.

*Definition. *

Let $X$ be a random variable. If we have a function $f$ such that

$$P(X \leq b) = \int_{- \infty}^{b}f(x)dx$$ for all
$b \in {\mathbb{R}}$, then $f$ is the **probability density function**
of $X$.

The probability that the value of $X$ lies in $( - \infty,b\rbrack$
equals the area under the curve of $f$ from $- \infty$ to $b$.

If $f$ satisfies this definition, then for any $B \subset {\mathbb{R}}$
for which integration makes sense,

$$P(X \in B) = \int_{B}f(x)dx$$

*Remark. *

Recall from our previous discussion of random variables that the PDF is
the analogue of the PMF for discrete random variables.

Properties of a CDF:

Any CDF $F(x) = P(X \leq x)$ satisfies

1.  Integrates to unity: $F( - \infty) = 0$, $F(\infty) = 1$

2.  $F(x)$ is non-decreasing in $x$ (monotonically increasing)

$$s < t \Rightarrow F(s) \leq F(t)$$

3.  $P(a < X \leq b) = P(X \leq b) - P(X \leq a) = F(b) - F(a)$

Like we mentioned before, we can only ask about things like
$P(X \leq k)$, but not $P(X = k)$. In fact $P(X = k) = 0$ for all $k$.
An immediate corollary of this is that we can freely interchange $\leq$
and $<$ and likewise for $\geq$ and $>$, since $P(X \leq k) = P(X < k)$
if $P(X = k) = 0$.

*Example. *

Let $X$ be a continuous random variable with density (pdf)

$$f(x) = \begin{cases}
cx^{2} & \text{for }0 < x < 2 \\
0 & \text{otherwise }
\end{cases}$$

1.  What is $c$?

$c$ is such that
$$1 = \int_{- \infty}^{\infty}f(x)dx = \int_{0}^{2}cx^{2}dx$$

2.  Find the probability that $X$ is between 1 and 1.4.

Integrate the curve between 1 and 1.4.

$$\begin{array}{r}
\int_{1}^{1.4}\frac{3}{8}x^{2}dx = \left( \frac{x^{3}}{8} \right)|_{1}^{1.4} \\
 = 0.218
\end{array}$$

This is the probability that $X$ lies between 1 and 1.4.

3.  Find the probability that $X$ is between 1 and 3.

Idea: integrate between 1 and 3, be careful after 2.

$$\int_{1}^{2}\frac{3}{8}x^{2}dx + \int_{2}^{3}0dx =$$

4.  What is the CDF for $P(X \leq x)$? Integrate the curve to $x$.

$$\begin{array}{r}
F(x) = P(X \leq x) = \int_{- \infty}^{x}f(t)dt \\
 = \int_{0}^{x}\frac{3}{8}t^{2}dt \\
 = \frac{x^{3}}{8}
\end{array}$$

Important: include the range!

$$F(x) = \begin{cases}
0 & \text{for }x \leq 0 \\
\frac{x^{3}}{8} & \text{for }0 < x < 2 \\
1 & \text{for }x \geq 2
\end{cases}$$

5.  Find a point $a$ such that you integrate up to the point to find
    exactly $\frac{1}{2}$

the area.

We want to find $\frac{1}{2} = P(X \leq a)$.

$$\frac{1}{2} = P(X \leq a) = F(a) = \frac{a^{3}}{8} \Rightarrow a = \sqrt[3]{4}$$

Now let us discuss some named continuous distributions.

### The (continuous) uniform distribution

The most simple and the best of the named distributions!

*Definition. *

Let $\lbrack a,b\rbrack$ be a bounded interval on the real line. A
random variable $X$ has the uniform distribution on the interval
$\lbrack a,b\rbrack$ if $X$ has the density function

$$f(x) = \begin{cases}
\frac{1}{b - a} & \text{for }x \in \lbrack a,b\rbrack \\
0 & \text{for }x \notin \lbrack a,b\rbrack
\end{cases}$$

Abbreviate this by $X\sim\text{ Unif }\lbrack a,b\rbrack$.

The graph of $\text{Unif }\lbrack a,b\rbrack$ is a constant line at
height $\frac{1}{b - a}$ defined across $\lbrack a,b\rbrack$. The
integral is just the area of a rectangle, and we can check it is 1.

*Fact. *

For $X\sim\text{ Unif }\lbrack a,b\rbrack$, its cumulative distribution
function (CDF) is given by:

$$F_{x}(x) = \begin{cases}
0 & \text{for }x < a \\
\frac{x - a}{b - a} & \text{for }x \in \lbrack a,b\rbrack \\
1 & \text{for }x > b
\end{cases}$$

*Fact. *

If $X\sim\text{ Unif }\lbrack a,b\rbrack$, and
$\lbrack c,d\rbrack \subset \lbrack a,b\rbrack$, then
$$P(c \leq X \leq d) = \int_{c}^{d}\frac{1}{b - a}dx = \frac{d - c}{b - a}$$

*Example. *

Let $Y$ be a uniform random variable on $\lbrack - 2,5\rbrack$. Find the
probability that its absolute value is at least 1.

$Y$ takes values in the interval $\lbrack - 2,5\rbrack$, so the absolute
value is at least 1 iff.
$Y \in \lbrack - 2,1\rbrack \cup \lbrack 1,5\rbrack$.

The density function of $Y$ is
$f(x) = \frac{1}{5 - ( - 2)} = \frac{1}{7}$ on $\lbrack - 2,5\rbrack$
and 0 everywhere else.

So,

$$\begin{aligned}
P\left( |Y| \geq 1 \right) & = P\left( Y \in \lbrack - 2, - 1\rbrack \cup \lbrack 1,5\rbrack \right) \\
 & = P( - 2 \leq Y \leq - 1) + P(1 \leq Y \leq 5) \\
 & = \frac{5}{7}
\end{aligned}$$

### The exponential distribution

The geometric distribution can be viewed as modeling waiting times, in a
discrete setting, i.e. we wait for $n - 1$ failures to arrive at the
$n^{\text{th}}$ success.

The exponential distribution is the continuous analogue to the geometric
distribution, in that we often use it to model waiting times in the
continuous sense. For example, the first custom to enter the barber
shop.

*Definition. *

Let $0 < \lambda < \infty$. A random variable $X$ has the exponential
distribution with parameter $\lambda$ if $X$ has PDF

$$f(x) = \begin{cases}
\lambda e^{- \lambda x} & \text{for }x \geq 0 \\
0 & \text{for }x < 0
\end{cases}$$

Abbreviate this by $X\sim\text{ Exp}(\lambda)$, the exponential
distribution with rate $\lambda$.

The CDF of the $\text{Exp}(\lambda)$ distribution is given by:

$$F(t) + \begin{cases}
0 & \text{if }t < 0 \\
1 - e^{- \lambda t} & \text{if }t \geq 0
\end{cases}$$

*Example. *

Suppose the length of a phone call, in minutes, is well modeled by an
exponential random variable with a rate $\lambda = \frac{1}{10}$.

1.  What is the probability that a call takes more than 8 minutes?

2.  What is the probability that a call takes between 8 and 22 minutes?

Let $X$ be the length of the phone call, so that
$X\sim\text{ Exp}\left( \frac{1}{10} \right)$. Then we can find the
desired probability by:

$$\begin{aligned}
P(X > 8) & = 1 - P(X \leq 8) \\
 & = 1 - F_{x}(8) \\
 & = 1 - \left( 1 - e^{- \left( \frac{1}{10} \right) \cdot 8} \right) \\
 & = e^{- \frac{8}{10}} \approx 0.4493
\end{aligned}$$

Now to find $P(8 < X < 22)$, we can take the difference in CDFs:

$$\begin{aligned}
 & P(X > 8) - P(X \geq 22) \\
 & = e^{- \frac{8}{10}} - e^{- \frac{22}{10}} \\
 & \approx 0.3385
\end{aligned}$$

*Fact (Memoryless property of the exponential distribution).*

Suppose that $X\sim\text{ Exp}(\lambda)$. Then for any $s,t > 0$, we
have $$P\left( X > t + s~|~X > t \right) = P(X > s)$$

This is like saying if I've been waiting 5 minutes and then 3 minutes
for the bus, what is the probability that I'm gonna wait more than 5 + 3
minutes, given that I've already waited 5 minutes? And that's precisely
equal to just the probability I'm gonna wait more than 3 minutes.

*Proof. *

$$\begin{array}{r}
P\left( X > t + s~|~X > t \right) = \frac{P(X > t + s \cap X > t)}{P(X > t)} \\
 = \frac{P(X > t + s)}{P(X > t)} = \frac{e^{- \lambda(t + s)}}{e^{- \lambda t}} = e^{- \lambda s} \\
 \equiv P(X > s)
\end{array}$$

### Gamma distribution

*Definition. *

Let $r,\lambda > 0$. A random variable $X$ has the **gamma
distribution** with parameters $(r,\lambda)$ if $X$ is nonnegative and
has probability density function

$$f(x) = \begin{cases}
\frac{\lambda^{r}x^{r - 2}}{\Gamma(r)}e^{- \lambda x} & \text{for }x \geq 0 \\
0 & \text{for }x < 0
\end{cases}$$

Abbreviate this by $X\sim\text{ Gamma}(r,\lambda)$.

The gamma function $\Gamma(r)$ generalizes the factorial function and is
defined as

$$\Gamma(r) = \int_{0}^{\infty}x^{r - 1}e^{- x}dx,\text{ for }r > 0$$

Special case: $\Gamma(n) = (n - 1)!$ if $n \in {\mathbb{Z}}^{+}$.

*Remark. *

The $\text{Exp}(\lambda)$ distribution is a special case of the gamma
distribution, with parameter $r = 1$.

## The normal distribution

Also known as the Gaussian distribution, this is so important it gets
its own section.

*Definition. *

A random variable $Z$ has the **standard normal distribution** if $Z$
has density function

$$\varphi(x) = \frac{1}{\sqrt{2\pi}}e^{- \frac{x^{2}}{2}}$$ on the real
line. Abbreviate this by $Z\sim N(0,1)$.

*Fact (CDF of a standard normal random variable).*

Let $Z\sim N(0,1)$ be normally distributed. Then its CDF is given by
$$\Phi(x) = \int_{- \infty}^{x}\varphi(s)ds = \int_{- \infty}^{x}\frac{1}{\sqrt{2\pi}}e^{\frac{- \left( - s^{2} \right)}{2}}ds$$

The normal distribution is so important, instead of the standard
$f_{Z(x)}$ and $F_{z(x)}$, we use the special $\varphi(x)$ and
$\Phi(x)$.

*Fact. *

$$\int_{- \infty}^{\infty}e^{- \frac{s^{2}}{2}}ds = \sqrt{2\pi}$$

No closed form of the standard normal CDF $\Phi$ exists, so we are left
to either:

-   approximate

-   use technology (calculator)

-   use the standard normal probability table in the textbook

To evaluate negative values, we can use the symmetry of the normal
distribution to apply the following identity:

$$\Phi( - x) = 1 - \Phi(x)$$

### General normal distributions

We can compute any other parameters of the normal distribution using the
standard normal.

The general family of normal distributions is obtained by linear or
affine transformations of $Z$. Let $\mu$ be real, and $\sigma > 0$, then

$$X = \sigma Z + \mu$$ is also a normally distributed random variable
with parameters $\left( \mu,\sigma^{2} \right)$. The CDF of $X$ in terms
of $\Phi( \cdot )$ can be expressed as

$$\begin{aligned}
F_{X}(x) & = P(X \leq x) \\
 & = P(\sigma Z + \mu \leq x) \\
 & = P\left( Z \leq \frac{x - \mu}{\sigma} \right) \\
 & = \Phi(\frac{x - \mu}{\sigma})
\end{aligned}$$

Also,

$$f(x) = F\prime(x) = \frac{d}{dx}\left\lbrack \Phi(\frac{x - u}{\sigma}) \right\rbrack = \frac{1}{\sigma}\varphi(\frac{x - u}{\sigma}) = \frac{1}{\sqrt{2\pi\sigma^{2}}}e^{\frac{- \left( (x - \mu)^{2} \right)}{2\sigma^{2}}}$$

*Definition. *

Let $\mu$ be real and $\sigma > 0$. A random variable $X$ has the
*normal distribution* with mean $\mu$ and variance $\sigma^{2}$ if $X$
has density function

$$f(x) = \frac{1}{\sqrt{2\pi\sigma^{2}}}e^{\frac{- \left( (x - \mu)^{2} \right)}{2\sigma^{2}}}$$

on the real line. Abbreviate this by
$X\sim N\left( \mu,\sigma^{2} \right)$.

*Fact. *

Let $X\sim N\left( \mu,\sigma^{2} \right)$ and $Y = aX + b$. Then
$$Y\sim N\left( a\mu + b,a^{2}\sigma^{2} \right)$$

That is, $Y$ is normally distributed with parameters
$\left( a\mu + b,a^{2}\sigma^{2} \right)$. In particular,
$$Z = \frac{X - \mu}{\sigma}\sim N(0,1)$$ is a standard normal variable.

## Expectation

Let's discuss the *expectation* of a random variable, which is a similar
idea to the basic concept of *mean*.

*Definition. *

The expectation or mean of a discrete random variable $X$ is the
weighted average, with weights assigned by the corresponding
probabilities.

$$E(X) = \sum_{\text{all }x_{i}}x_{i} \cdot p\left( x_{i} \right)$$

*Example. *

Find the expected value of a single roll of a fair die.

-   $X = \frac{\text{ score }}{\text{ dots}}$

-   $x = 1,2,3,4,5,6$

-   $p(x) = \frac{1}{6},\frac{1}{6},\frac{1}{6},\frac{1}{6},\frac{1}{6},\frac{1}{6}$

$$E\lbrack x\rbrack = 1 \cdot \frac{1}{6} + 2 \cdot \frac{1}{6}\ldots + 6 \cdot \frac{1}{6}$$

### Binomial expected value

$$E\lbrack x\rbrack = np$$

### Bernoulli expected value

Bernoulli is just binomial with one trial.

Recall that $P(X = 1) = p$ and $P(X = 0) = 1 - p$.

$$E\lbrack X\rbrack = 1 \cdot P(X = 1) + 0 \cdot P(X = 0) = p$$

Let $A$ be an event on $\Omega$. Its *indicator random variable* $I_{A}$
is defined for $\omega \in \Omega$ by

$$I_{A}(\omega) = \begin{cases}
1\text{, if  } & \omega \in A \\
0\text{, if } & \omega \notin A
\end{cases}$$

$$E\left\lbrack I_{A} \right\rbrack = 1 \cdot P(A) = P(A)$$

## Geometric expected value

Let $p \in \lbrack 0,1\rbrack$ and $X\sim\text{ Geom}\lbrack p\rbrack$
be a geometric RV with probability of success $p$. Recall that the
p.m.f. is $pq^{k - 1}$, where prob. of failure is defined by
$q ≔ 1 - p$.

Then

$$\begin{aligned}
E\lbrack X\rbrack & = \sum_{k = 1}^{\infty}kpq^{k - 1} \\
 & = p \cdot \sum_{k = 1}^{\infty}k \cdot q^{k - 1}
\end{aligned}$$

Now recall from calculus that you can differentiate a power series term
by term inside its radius of convergence. So for $|t| < 1$,

$$\begin{array}{r}
\sum_{k = 1}^{\infty}kt^{k - 1} = \sum_{k = 1}^{\infty}\frac{d}{dt}t^{k} = \frac{d}{dt}\sum_{k = 1}^{\infty}t^{k} = \frac{d}{dt}\left( \frac{1}{1 - t} \right) = \frac{1}{(1 - t)^{2}} \\
\therefore E\lbrack x\rbrack = \sum_{k = 1}^{\infty}kpq^{k - 1} = p\sum_{k = 1}^{\infty}kq^{k - 1} = p\left( \frac{1}{(1 - q)^{2}} \right) = \frac{1}{p}
\end{array}$$

### Expected value of a continuous RV

*Definition. *

The expectation or mean of a continuous random variable $X$ with density
function $f$ is

$$E\lbrack x\rbrack = \int_{- \infty}^{\infty}x \cdot f(x)dx$$

An alternative symbol is $\mu = E\lbrack x\rbrack$.

$\mu$ is the "first moment" of $X$, analogous to physics, it's the
"center of gravity" of $X$.

*Remark. *

In general when moving between discrete and continuous RV, replace sums
with integrals, p.m.f. with p.d.f., and vice versa.

*Example. *

Suppose $X$ is a continuous RV with p.d.f.

$$f_{X}(x) = \begin{cases}
2x\text{,  } & 0 < x < 1 \\
0\text{, } & \text{elsewhere}
\end{cases}$$

$$E\lbrack X\rbrack = \int_{- \infty}^{\infty}x \cdot f(x)dx = \int_{0}^{1}x \cdot 2xdx = \frac{2}{3}$$

*Example (Uniform expectation).*

Let $X$ be a uniform random variable on the interval
$\lbrack a,b\rbrack$ with $X\sim\text{ Unif}\lbrack a,b\rbrack$. Find
the expected value of $X$.

$$\begin{array}{r}
E\lbrack X\rbrack = \int_{- \infty}^{\infty}x \cdot f(x)dx = \int_{a}^{b}\frac{x}{b - a}dx \\
 = \frac{1}{b - a}\int_{a}^{b}xdx = \frac{1}{b - a} \cdot \frac{b^{2} - a^{2}}{2} = \underset{\text{ midpoint formula}}{\underbrace{\frac{b + a}{2}}}
\end{array}$$

*Example (Exponential expectation).*

Find the expected value of an exponential RV, with p.d.f.

$$f_{X}(x) = \begin{cases}
\lambda e^{- \lambda x}\text{,  } & x > 0 \\
0\text{, } & \text{elsewhere}
\end{cases}$$

$$\begin{array}{r}
E\lbrack x\rbrack = \int_{- \infty}^{\infty}x \cdot f(x)dx = \int_{0}^{\infty}x \cdot \lambda e^{- \lambda x}dx \\
 = \lambda \cdot \int_{0}^{\infty}x \cdot e^{- \lambda x}dx \\
 = \lambda \cdot \left\lbrack \left. -x\frac{1}{\lambda}e^{- \lambda x} \right|_{x = 0}^{x = \infty} - \int_{0}^{\infty} - \frac{1}{\lambda}e^{- \lambda x}dx \right\rbrack \\
 = \frac{1}{\lambda}
\end{array}$$

*Example (Uniform dartboard).*

Our dartboard is a disk of radius $r_{0}$ and the dart lands uniformly
at random on the disk when thrown. Let $R$ be the distance of the dart
from the center of the disk. Find $E\lbrack R\rbrack$ given density
function

$$f_{R}(t) = \begin{cases}
\frac{2t}{r_{0}^{2}}\text{,  } & 0 \leq t \leq r_{0} \\
0\text{,  } & t < 0\text{ or }t > r_{0}
\end{cases}$$

$$\begin{array}{r}
E\lbrack R\rbrack = \int_{- \infty}^{\infty}tf_{R}(t)dt \\
 = \int_{0}^{r_{0}}t \cdot \frac{2t}{r_{0}^{2}}dt \\
 = \frac{2}{3}r_{0}
\end{array}$$

### Expectation of derived values

If we can find the expected value of $X$, can we find the expected value
of $X^{2}$? More precisely, can we find
$E\left\lbrack X^{2} \right\rbrack$?

If the distribution is easy to see, then this is trivial. Otherwise we
have the following useful property:

$$E\left\lbrack X^{2} \right\rbrack = \int_{\text{all }x}x^{2}f_{X}(x)dx$$

(for continuous RVs).

And in the discrete case,

$$E\left\lbrack X^{2} \right\rbrack = \sum_{\text{all }x}x^{2}p_{X}(x)$$

In fact $E\left\lbrack X^{2} \right\rbrack$ is so important that we call
it the **mean square**.

*Fact. *

More generally, a real valued function $g(X)$ defined on the range of
$X$ is itself a random variable (with its own distribution).

We can find expected value of $g(X)$ by

$$E\left\lbrack g(x) \right\rbrack = \int_{- \infty}^{\infty}g(x)f(x)dx$$

or

$$E\left\lbrack g(x) \right\rbrack = \sum_{\text{all }x}g(x)f(x)$$

*Example. *

You roll a fair die to determine the winnings (or losses) $W$ of a
player as follows:

$$W = \begin{cases}
 - 1,\ if\ the\ roll\ is\ 1,\ 2,\ or\ 3 \\
1,\ if\ the\ roll\ is\ a\ 4 \\
3,\ if\ the\ roll\ is\ 5\ or\ 6
\end{cases}$$

What is the expected winnings/losses for the player during 1 roll of the
die?

Let $X$ denote the outcome of the roll of the die. Then we can define
our random variable as $W = g(X)$ where the function $g$ is defined by
$g(1) = g(2) = g(3) = - 1$ and so on.

Note that $P(W = - 1) = P(X = 1 \cup X = 2 \cup X = 3) = \frac{1}{2}$.
Likewise $P(W = 1) = P(X = 4) = \frac{1}{6}$, and
$P(W = 3) = P(X = 5 \cup X = 6) = \frac{1}{3}$.

Then $$\begin{array}{r}
E\left\lbrack g(X) \right\rbrack = E\lbrack W\rbrack = ( - 1) \cdot P(W = - 1) + (1) \cdot P(W = 1) + (3) \cdot P(W = 3) \\
 = - \frac{1}{2} + \frac{1}{6} + 1 = \frac{2}{3}
\end{array}$$

*Example. *

A stick of length $l$ is broken at a uniformly chosen random location.
What is the expected length of the longer piece?

Idea: if you break it before the halfway point, then the longer piece
has length given by $l - x$. If you break it after the halfway point,
the longer piece has length $x$.

Let the interval $\lbrack 0,l\rbrack$ represent the stick and let
$X\sim\text{ Unif}\lbrack 0,l\rbrack$ be the location where the stick is
broken. Then $X$ has density $f(x) = \frac{1}{l}$ on
$\lbrack 0,l\rbrack$ and 0 elsewhere.

Let $g(x)$ be the length of the longer piece when the stick is broken at
$x$,

$$g(x) = \begin{cases}
1 - x\text{,  } & 0 \leq x < \frac{l}{2} \\
x\text{,  } & \frac{1}{2} \leq x \leq l
\end{cases}$$

Then $$\begin{array}{r}
E\left\lbrack g(X) \right\rbrack = \int_{- \infty}^{\infty}g(x)f(x)dx = \int_{0}^{\frac{l}{2}}\frac{l - x}{l}dx + \int_{\frac{l}{2}}^{l}\frac{x}{l}dx \\
 = \frac{3}{4}l
\end{array}$$

So we expect the longer piece to be $\frac{3}{4}$ of the total length,
which is a bit pathological.

### Moments of a random variable

We continue discussing expectation but we introduce new terminology.

*Fact. *

The $n^{\text{th}}$ moment (or $n^{\text{th}}$ raw moment) of a discrete
random variable $X$ with p.m.f. $p_{X}(x)$ is the expectation

$$E\left\lbrack X^{n} \right\rbrack = \sum_{k}k^{n}p_{X}(k) = \mu_{n}$$

If $X$ is continuous, then we have analogously

$$E\left\lbrack X^{n} \right\rbrack = \int_{- \infty}^{\infty}x^{n}f_{X}(x) = \mu_{n}$$

The **deviation** is given by $\sigma$ and the **variance** is given by
$\sigma^{2}$ and

$$\sigma^{2} = \mu_{2} - \left( \mu_{1} \right)^{2}$$

$\mu_{3}$ is used to measure "skewness" / asymmetry of a distribution.
For example, the normal distribution is very symmetric.

$\mu_{4}$ is used to measure kurtosis/peakedness of a distribution.

### Central moments

Previously we discussed "raw moments." Be careful not to confuse them
with *central moments*.

*Fact. *

The $n^{\text{th}}$ central moment of a discrete random variable $X$
with p.m.f. $p_{X}(x)$ is the expected value of the difference about the
mean raised to the $n^{\text{th}}$ power

$$E\left\lbrack (X - \mu)^{n} \right\rbrack = \sum_{k}(k - \mu)^{n}p_{X}(k) = \mu\prime_{n}$$

And of course in the continuous case,

$$E\left\lbrack (X - \mu)^{n} \right\rbrack = \int_{- \infty}^{\infty}(x - \mu)^{n}f_{X}(x) = \mu\prime_{n}$$

In particular,

$$\begin{array}{r}
\mu\prime_{1} = E\left\lbrack (X - \mu)^{1} \right\rbrack = \int_{- \infty}^{\infty}(x - \mu)^{1}f_{X}(x)dx \\
 = \int_{\infty}^{\infty}xf_{X}(x)dx = \int_{- \infty}^{\infty}\mu f_{X}(x)dx = \mu - \mu \cdot 1 = 0 \\
\mu\prime_{2} = E\left\lbrack (X - \mu)^{2} \right\rbrack = \sigma_{X}^{2} = \text{ Var}(X)
\end{array}$$

*Example. *

Let $Y$ be a uniformly chosen integer from
$\left\{ 0,1,2,\ldots,m \right\}$. Find the first and second moment of
$Y$.

The p.m.f. of $Y$ is $p_{Y}(k) = \frac{1}{m + 1}$ for
$k \in \lbrack 0,m\rbrack$. Thus,

$$\begin{array}{r}
E\lbrack Y\rbrack = \sum_{k = 0}^{m}k\frac{1}{m + 1} = \frac{1}{m + 1}\sum_{k = 0}^{m}k \\
 = \frac{m}{2}
\end{array}$$

Then,

$$E\left\lbrack Y^{2} \right\rbrack = \sum_{k = 0}^{m}k^{2}\frac{1}{m + 1} = \frac{1}{m + 1} = \frac{m(2m + 1)}{6}$$

*Example. *

Let $c > 0$ and let $U$ be a uniform random variable on the interval
$\lbrack 0,c\rbrack$. Find the $n^{\text{th}}$ moment for $U$ for all
positive integers $n$.

The density function of $U$ is

$$f(x) = \begin{cases}
\frac{1}{c}\text{, if } & x \in \lbrack 0,c\rbrack \\
0\text{,  } & \text{otherwise}
\end{cases}$$

Therefore the $n^{\text{th}}$ moment of $U$ is,

$$E\left\lbrack U^{n} \right\rbrack = \int_{- \infty}^{\infty}x^{n}f(x)dx$$

*Example. *

Suppose the random variable $X\sim\text{ Exp}(\lambda)$. Find the second
moment of $X$.

$$\begin{array}{r}
E\left\lbrack X^{2} \right\rbrack = \int_{0}^{\infty}x^{2}\lambda e^{- \lambda x}dx \\
 = \frac{1}{\lambda^{2}}\int_{0}^{\infty}u^{2}e^{- u}du \\
 = \frac{1}{\lambda^{2}}\Gamma(2 + 1) = \frac{2!}{\lambda^{2}}
\end{array}$$

*Fact. *

In general, to find teh $n^{\text{th}}$ moment of
$X\sim\text{ Exp}(\lambda)$,
$$E\left\lbrack X^{n} \right\rbrack = \int_{0}^{\infty}x^{n}\lambda e^{- \lambda x}dx = \frac{n!}{\lambda^{n}}$$

### Median and quartiles

When a random variable has rare (abnormal) values, its expectation may
be a bad indicator of where the center of the distribution lies.

*Definition. *

The **median** of a random variable $X$ is any real value $m$ that
satisfies

$$P(X \geq m) \geq \frac{1}{2}\text{ and }P(X \leq m) \geq \frac{1}{2}$$

With half the probability on both $\left\{ X \leq m \right\}$ and
$\left\{ X \geq m \right\}$, the median is representative of the
midpoint of the distribution. We say that the median is more *robust*
because it is less affected by outliers. It is not necessarily unique.

*Example. *

Let $X$ be discretely uniformly distributed in the set
$\left\{ - 100,1,2,,3,\ldots,9 \right\}$ so $X$ has probability mass
function $$p_{X}( - 100) = p_{X}(1) = \cdots = p_{X}(9)$$

Find the expected value and median of $X$.

$$E\lbrack X\rbrack = ( - 100) \cdot \frac{1}{10} + (1) \cdot \frac{1}{10} + \cdots + (9) \cdot \frac{1}{10} = - 5.5$$

While the median is any number $m \in \lbrack 4,5\rbrack$.

The median reflects the fact that 90% of the values and probability is
in the range $1,2,\ldots,9$ while the mean is heavily influenced by the
$- 100$ value.
