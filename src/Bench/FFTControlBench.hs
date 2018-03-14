import Criterion.Main
import FFT.Orig
import FFT.FFTControl
import FFT.Samples

setupEnv = do
    let samples32768 = samples 1 32768 
        samples65536 = samples 1 65536
        samples131072 = samples 1 131072
    return (samples32768, samples65536, samples131072)

main = defaultMain [
        env setupEnv $ \ ~(samples32768, samples65536, samples131072) -> bgroup "FFT-Control" [
                bgroup "FFTControl32768" [
                    bench "orig" $ nf fft samples32768,
                    bench "bflySPipeline" $ nf fftbflySPipeline samples32768,
		    bench "dc" $ nf fftdc samples32768,
		    bench "dc" $ nf fftdcPipeline samples32768
                ],
                bgroup "FFTControl65536" [
                    bench "orig" $ nf fft samples65536,
                    bench "bflySPipeline" $ nf fftbflySPipeline samples65536,
		    bench "dc" $ nf fftdc samples65536,
		    bench "dc" $ nf fftdcPipeline samples65536
                ],
                bgroup "FFTControl131072" [
                    bench "orig" $ nf fft samples131072,
                    bench "bflySPipeline" $ nf fftbflySPipeline samples131072,
		    bench "dc" $ nf fftdc samples131072,
		    bench "dc" $ nf fftdcPipeline samples131072
                ]
            ]
    ]
