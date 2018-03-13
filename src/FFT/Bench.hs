import Criterion.Main
import FFT.Orig
import FFT.FFTControl
import FFT.FFTData
import FFT.DFTData
import FFT.DFTControl
import FFT.Samples
import Data.Complex
import System.Environment

main = defaultMain [
                bgroup "dft-data" [
                    bench "orig" $ nf sum (dft (samples 1 1000)),
                    bench "foldMap" $ nf sum (dftFoldMap (samples 1 1000))
                ],
                bgroup "dft-control" [
                    
                ],
                bgroup "fft-control" [
                    bench "orig" $ nf sum (fft (samples 1 100000)),
                    bench "bflySPipeline" $ nf sum (fftbflySPipeline (samples 1 100000))
                ],
                bgroup "fft-data" [
                ]
    ]
