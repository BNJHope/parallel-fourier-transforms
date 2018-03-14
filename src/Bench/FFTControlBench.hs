import Criterion.Main
import FFT.Orig
import FFT.FFTControl
import FFT.Samples

setupEnv = do
    let samples1024 = samples 1 1024
        samples2048 = samples 1 2048
        samples4096 = samples 1 4096
        samples65536 = samples 1 65536
        samples131072 = samples 1 131072
    return (samples1024, samples2048, samples4096, samples65536, samples131072)

main = defaultMain [
        env setupEnv $ \ ~(samples1024, samples2048, samples4096, samples65536, samples131072) -> bgroup "FFT-Control" [
                bgroup "FFTControl65536" [
                    bench "orig" $ nf fft samples65536,
                    bench "bflySPipeline" $ nf fftbflySPipeline samples65536,
		    bench "dc" $ nf fftdc samples65536
                ],
                bgroup "FFTControl131072" [
                    bench "orig" $ nf fft samples131072,
                    bench "bflySPipeline" $ nf fftbflySPipeline samples131072,
		    bench "dc" $ nf fftdc samples131072
                ]
            ]
    ]
