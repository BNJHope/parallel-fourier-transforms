import Criterion.Main
import FFT.Orig
import FFT.FFTData
import FFT.Samples

setupEnv = do
    let samples1024 = samples 1 1024
        samples2048 = samples 1 2048
        samples4096 = samples 1 4096
        samples65536 = samples 1 65536
        samples131072 = samples 1 131072
    return (samples1024, samples2048, samples4096, samples65536, samples131072)

main = defaultMain [
        env setupEnv $ \ ~(samples1024, samples2048, samples4096, samples65536, samples131072) -> bgroup "FFT-Data" [
                bgroup "FFTData65536" [
                    bench "orig" $ nf fft samples65536,
                    bench "fftbFlySParZip" $ nf fftbFlySParZip samples65536,
                    bench "fftbFlySParZipMap" $ nf fftbFlySParZipMap samples65536,
		    bench "fftMapReduce" $ nf fftMapReduce samples65536
                ]
            ]
    ]
