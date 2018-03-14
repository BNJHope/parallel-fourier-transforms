module FFT.DFTData(
    dftInnerMap,
    dftFoldMap,
    dftOuterMap,
    dftInnerMapReduce
) where
import Data.Complex
import FFT.Samples
import Control.Parallel
import Strategies

-- twiddle factors
tw :: Int -> Int -> Complex Float
tw n k = cis (-2 * pi * fromIntegral k / fromIntegral n)

dftInnerMap xs = [ sum (innerMap k) | k <- [0..n']]
  where
    innerMap k = parmap (\j -> xs!!j * tw n (j*k)) [0..n']
    n = length xs
    n' = n-1

dftFoldMap xs = [ (parfold (+) (0 :+ 0) (innerMap k)) | k <- [0..n']]
  where
    innerMap k = parmap (\j -> xs!!j * tw n (j*k)) [0..n']
    n = length xs
    n' = n-1

dftOuterMap xs = parmap innerFunc [0..n']
    where
        innerFunc k = sum [ xs!!j * tw n (j*k) | j <- [0..n']]
        n = length xs
        n' = n-1

dftInnerMapReduce xs = parmap (\k -> parMapReduceSimple rdeepseq (mapper k) rdeepseq reducer [0..n']) [0..n']
    where
        mapper k j = xs!!j * tw n (j*k)
        reducer = sum
        n = length xs
        n' = n-1

