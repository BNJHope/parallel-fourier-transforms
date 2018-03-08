import Data.Complex
import FFT.Samples
import System.Environment
import Control.Parallel
import Strategies

-- twiddle factors
tw :: Int -> Int -> Complex Float
tw n k = cis (-2 * pi * fromIntegral k / fromIntegral n)
--
-- Fast Fourier Transform

-- In case you are wondering, this is the Decimation in Frequency (DIF) 
-- radix 2 Cooley-Tukey FFT

fft :: [Complex Float] -> [Complex Float]
fft [a] = [a]
fft as = interleave ls rs
  where
    (cs,ds) = bflyS as
    ls = fft cs
    rs = fft ds

interleave [] bs = bs
interleave (a:as) bs = a : interleave bs as

bflyS :: [Complex Float] -> ([Complex Float], [Complex Float])
bflyS as = (los,rts)
-- bflyS as = los `par` rts `pseq` (los, rts)
-- bflyS as = los `par` (ros `pseq` rts) `pseq` (los, rts)
  where
    (ls,rs) = halve as
    los = parzipwith (-) ls rs
    -- los = zipWith (+) ls rs
    
    ros = parzipwith (-) ls rs
    -- ros = zipWith (-) ls rs
    
    rts = parzipwith (*) ros (parmap (\i -> tw (length (as)) i) [0..(length ros) - 1])
    -- rts = zipWith (*) ros (parmap (\i -> tw (length (as)) i) [0..(length ros) - 1])
    -- rts = parzipwith (*) ros [tw (length as) i | i <- [0..(length ros) - 1]]
    -- rts = zipWith (*) ros [tw (length as) i | i <- [0..(length ros) - 1]]


-- split the input into two halves
halve as = splitAt n' as
  where
    n' = div (length as + 1) 2

-- the main function
-- uses Samples.samples to generate some sample data
--   samples :: Int -> Int -> [Complex Float]

defsize = 1000 -- change this to get larger samples
defseed = 1

main = do args <- getArgs
          let arglen = length args
          let n = argval args 0 defsize
          let seed = argval args 1 defseed
          let fun = fft
          print (sum (fun (samples seed n)))

argval args n def = if length args > n then
                       read (args !! n)
                     else def
