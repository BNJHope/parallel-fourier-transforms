module FFT.DFTData (
) where
import Data.Complex
import FFT.Samples
import System.Environment
import Control.Parallel
import Strategies

-- twiddle factors
tw :: Int -> Int -> Complex Float
tw n k = cis (-2 * pi * fromIntegral k / fromIntegral n)

-- Discrete Fourier Transform -- O(n^2)
dft :: [Complex Float] -> [Complex Float]
-- dft xs = [ sum (parmap(\j -> xs!!j * tw n (j*k)) [0..n']) | k <- [0..n']]
dft xs = [ (parfold (+) (0 :+ 0) (parmap(\j -> xs!!j * tw n (j*k)) [0..n'])) | k <- [0..n']]
  where
    n = length xs
    n' = n-1
