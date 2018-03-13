module FFT.FFTControl (
    fftbflySPipeline
) where
import Data.Complex
import FFT.Samples
import System.Environment
import Control.Parallel
import Strategies

-- twiddle factors
tw :: Int -> Int -> Complex Float
tw n k = cis (-2 * pi * fromIntegral k / fromIntegral n)

-- Fast Fourier Transform

-- In case you are wondering, this is the Decimation in Frequency (DIF) 
-- radix 2 Cooley-Tukey FFT

fft :: [Complex Float] -> [Complex Float]
fft [a] = [a]
--fft as = ls `par` rs `pseq` interleave ls rs
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
    -- los = parZipWith (-) ls rs
    los = zipWith (+) ls rs
    
    -- ros = parZipWith (-) ls rs
    ros = zipWith (-) ls rs
    
    -- rts = parZipWith (*) ros (pmap (\i -> tw length (as) i) [0..(length ros) - 1])
    -- rts = zipWith (*) ros (pmap (\i -> tw length (as) i) [0..(length ros) - 1])
    -- rts = parZipWith (*) ros [tw (length as) i | i <- [0..(length ros) - 1]]
    rts = zipWith (*) ros [tw (length as) i | i <- [0..(length ros) - 1]]

fftbflySPipeline as = interleave ls rs
    where
        (cs,ds) = bflySPipeline as
        ls = fft cs
        rs = fft ds

bflySPipeline :: [Complex Float] -> ([Complex Float], [Complex Float])
bflySPipeline as = (los,rts)
    where
        (ls, rs) = halve as
        los = zipWith (+) ls rs
        rts = parpipeline2 (zipWith (-) ls) (zipWith (*) [tw (length as) i | i <- [0..(length rs) - 1]]) rs

-- split the input into two halves
halve as = splitAt n' as
  where
    n' = div (length as + 1) 2

