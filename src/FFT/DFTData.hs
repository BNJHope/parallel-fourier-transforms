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

-- the main function
-- uses Samples.samples to generate some sample data
--   samples :: Int -> Int -> [Complex Float]

defsize = 1000 -- change this to get larger samples
defseed = 1

main = do args <- getArgs
          let arglen = length args
          let n = argval args 0 defsize
          let seed = argval args 1 defseed
          let fun = dft
          print (sum (fun (samples seed n)))

argval args n def = if length args > n then
                       read (args !! n)
                     else def
