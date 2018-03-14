module FFT.FFTControl(
    fftbflySPipeline,
    fftdc,
    fftdcPipeline
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

fftdc as = dc split threshold combine worker as
	where
                combine [xs] = xs
		combine [xs,ys] = interleave xs ys
		threshold = (\x -> length x <= 1) --(floor $ sqrt $ fromIntegral as))
		worker a = [a]
		split xs = [cs, ds]
			where (cs, ds) = bflyS xs

fftdcPipeline as = dc split threshold combine worker as
	where
                combine [xs] = xs
		combine [xs,ys] = interleave xs ys
		threshold = (\x -> length x <= 1) --(floor $ sqrt $ fromIntegral as))
		worker a = [a]
		split xs = [cs, ds]
			where (cs, ds) = bflySPipeline xs

fftbflySPipeline as = interleave ls rs
    where
        (cs,ds) = bflySPipeline as
        ls = fft cs
        rs = fft ds

interleave :: [Complex Float] -> [Complex Float] -> [Complex Float]
interleave [] bs = bs
interleave (a:as) bs = a : interleave bs as

bflyS :: [Complex Float] -> ([Complex Float], [Complex Float])
bflyS as = (los,rts)
  where
    (ls,rs) = halve as
    los = zipWith (+) ls rs
    ros = zipWith (-) ls rs
    rts = zipWith (*) ros [tw (length as) i | i <- [0..(length ros) - 1]]

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

