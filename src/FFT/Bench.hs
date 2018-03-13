import Criterion.Main
import FFT.Orig
import FFT.FFTControl
import FFT.FFTData
import FFT.DFTData
import FFT.DFTControl
import FFT.Samples
import Data.Complex
import System.Environment

defsize = 100000 -- change this to get larger samples
defseed = 1

main = defaultMain [
                bgroup "dft-data" [
                
                ],
                bgroup "dft-control" [
                    
                ],
                bgroup "fft-control" [ bench "orig"  $ whnf sum (fft (samples 1 100000)),
                            bench "bflySPipeline" $ whnf sum (fftbflySPipeline (samples 1 100000))
                ],
                bgroup "fft-data" [
                ]
                ]
