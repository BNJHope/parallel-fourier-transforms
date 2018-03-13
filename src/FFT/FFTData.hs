module FFT.FFTData (
    fftbFlySParZip,
    fftbFlySParZipMap
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

fftbFlySParZip :: [Complex Float] -> [Complex Float]
fftbFlySParZip [a] = [a]
fftbFlySParZip as = interleave ls rs
  where
    (cs,ds) = bflySParZip as
    ls = fft cs
    rs = fft ds

fftbFlySParZipMap :: [Complex Float] -> [Complex Float]
fftbFlySParZipMap [a] = [a]
fftbFlySParZipMap as = interleave ls rs
  where
    (cs,ds) = bflySParZipMap as
    ls = fft cs
    rs = fft ds

interleave [] bs = bs
interleave (a:as) bs = a : interleave bs as

bflyS :: [Complex Float] -> ([Complex Float], [Complex Float])
bflyS as = (los,rts)
  where
    (ls,rs) = halve as
    los = zipWith (+) ls rs

    ros = zipWith (-) ls rs
    
    -- rts = parzipwith (*) ros (parmap (\i -> tw (length (as)) i) [0..(length ros) - 1])
    -- rts = zipWith (*) ros (parmap (\i -> tw (length (as)) i) [0..(length ros) - 1])
    -- rts = parzipwith (*) ros [tw (length as) i | i <- [0..(length ros) - 1]]
    rts = zipWith (*) ros [tw (length as) i | i <- [0..(length ros) - 1]]

bflySParZip as = (los, rts)
    where
        (ls,rs) = halve as
        los = parzipwith (+) ls rs
        ros = parzipwith (-) ls rs
        rts = parzipwith (*) ros [tw (length as) i | i <- [0..(length ros) - 1]]

bflySParZipMap as = (los, rts)
    where
        (ls,rs) = halve as
        los = parzipwith (+) ls rs
        ros = parzipwith (-) ls rs
        rts = parzipwith (*) ros (parmap (\i -> tw (length (as)) i) [0..(length ros) - 1])

halve as = splitAt n' as
  where
    n' = div (length as + 1) 2
