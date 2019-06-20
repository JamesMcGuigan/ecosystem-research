# Zeit Now Deployment

NOTE: Fails to deploy correctly to Zeit Now, and just shows a directory listing

### Links
- [https://github.com/zeit/now-examples/tree/3a578a130926f30d5e7eb61575a5f9360ee713a0/haskell-hello]
- [https://github.com/zeit/now-examples/pull/55/commits/3a578a130926f30d5e7eb61575a5f9360ee713a0#diff-7ffa443b950cedfb98cc524210cdd596]


# haskell-hello

A simple hello world server written in [Haskell](https://haskell.org).

- Built in multiple stages
  - `haskell` official image for build
  - [`haskell-scratch`](https://github.com/fpco/haskell-scratch) for bin
- Resulting image is just 5MB

Based on [this example](https://github.com/knative/docs/blob/master/serving/samples/helloworld-haskell).