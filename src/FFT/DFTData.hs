import Data.Complex
import FFT.Samples
import System.Environment
import Control.Parallel
import Strategies
import Criterion.Main
import FFT.Orig

-- twiddle factors
tw :: Int -> Int -> Complex Float
tw n k = cis (-2 * pi * fromIntegral k / fromIntegral n)

-- Discrete Fourier Transform -- O(n^2)
-- dft xs = [ sum (parmap(\j -> xs!!j * tw n (j*k)) [0..n']) | k <- [0..n']]
dftFoldMap xs = [ (parfold (+) (0 :+ 0) (parmap(\j -> xs!!j * tw n (j*k)) [0..n'])) | k <- [0..n']]
  where
    n = length xs
    n' = n-1

main = defaultMain [
                bgroup "dft-data" [
                    bench "orig" $ nf sum (dft (samples 1 1000)),
                    bench "foldMap" $ nf sum (dftFoldMap (samples 1 1000))
                ]
    ]
