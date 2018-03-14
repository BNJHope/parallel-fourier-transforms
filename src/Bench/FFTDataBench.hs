import Criterion.Main
import FFT.Orig
import FFT.FFTData
import FFT.Samples

setupEnv = do
    let samples32768 = samples 1 32768 
        samples65536 = samples 1 65536
        samples131072 = samples 1 131072
    return (samples32768, samples65536, samples131072)

main = defaultMain [
        env setupEnv $ \ ~(samples32768, samples65536, samples131072) -> bgroup "FFT-Data" [
                bgroup "FFTData32768" [
                    bench "orig" $ nf fft samples32768,
                    bench "fftbFlySParZip" $ nf fftbFlySParZip samples32768,
                    bench "fftbFlySParZipMap" $ nf fftbFlySParZipMap samples32768,
		    bench "fftMapReduce" $ nf fftMapReduce samples32768
                ],
		bgroup "FFTData65536" [
                    bench "orig" $ nf fft samples65536,
                    bench "fftbFlySParZip" $ nf fftbFlySParZip samples65536,
                    bench "fftbFlySParZipMap" $ nf fftbFlySParZipMap samples65536,
		    bench "fftMapReduce" $ nf fftMapReduce samples65536
                ],
		bgroup "FFTData131072" [
                    bench "orig" $ nf fft samples131072,
                    bench "fftbFlySParZip" $ nf fftbFlySParZip samples131072,
                    bench "fftbFlySParZipMap" $ nf fftbFlySParZipMap samples131072,
		    bench "fftMapReduce" $ nf fftMapReduce samples131072
                ]
            ]
    ]
