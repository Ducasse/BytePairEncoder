# BytePairEncoder


I implement the Byte-Pair Encoding: Subword-based tokenization algorithm as defined in A New Algorithm for Data Compression but adapted to NLP as defined in ""Neural Machine Translation of Rare Words with Subword Units""
by Rico Sennrich and Barry Haddow and Alexandra Birch.

BPE is a simple form of data compression algorithm in which the most common pair of consecutive bytes of data is replaced with a byte that does not occur in that data. It was first described in the article ""A New Algorithm for Data Compression"" published in 1994. 

Suppose we have data aaabdaaabac which needs to be encoded (compressed). The byte pair aa occurs most often, so we will replace it with Z as Z does not occur in our data. So we now have ZabdZabac where Z = aa. The next common byte pair is ab so let’s replace it with Y. We now have ZYdZYac where Z = aa and Y = ab. The only byte pair left is ac which appears as just one so we will not encode it. We can use recursive byte pair encoding to encode ZY as X. Our data has now transformed into XdXac where X = ZY, Y = ab, and Z = aa. It cannot be further compressed as there are no byte pairs appearing more than once. We decompress the data by performing replacements in reverse order. 
A variant of this is used in NLP that use the merge rules to tokenise text.

A good explanation is available https://www.youtube.com/watch?v=HEikzVL-lZU

