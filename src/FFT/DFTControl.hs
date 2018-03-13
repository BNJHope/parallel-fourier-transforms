module FFT.DFTControl (
    dcdft
) where
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

dcdft [] = []
dcdft xs = dc split threshold combine worker [0..n']
  where
    n = length xs
    n' = n-1
    worker = map workerInner
        where workerInner k = [sum (map (\j -> xs!!j * tw n (j*k)) [0..n'])]
    combine = concat
    threshold = (\x -> length x < (floor $ sqrt $ fromIntegral n'))
    split l = [front, back]
        where
            front = take p l
            back = drop p l
            p = length l `div` 2

