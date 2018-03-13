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
-- dft :: [Complex Float] -> [Complex Float]
-- taskfarm :: NFData b => (a -> [b]) -> Int -> [a] -> [[b]]

--dcdft [] = []
--dcdft xs = dc split threshold combine worker xs
--  where
--    n = length xs
--    n' = n-1
--    worker = map (\k -> map (\j -> xs!!j * tw n (j*k)) [0..n'])
--    combine = concat
--    threshold = (\x -> length x < (sqrt defsize))
--    split xs = [front, back]
--	where
--	    front = take p xs
--	    back = drop p xs
--	    p = length xs `div` 2
--
main = defaultMain [
                bgroup "dft-control" [
                    
                ]
    ]
