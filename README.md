# Testground Stability

- rust-sdk

Using commit: 94bfd55ba7f7e8e28e633a9eed1bb0568f4ae1d9
This is when we started seeing random failure in the rust-sdk CI,
see PR: https://github.com/testground/sdk-rust/pull/34


It looks like publishing data to a topic messed up with testground success detection.

