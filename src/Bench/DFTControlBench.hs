import Criterion.Main
import FFT.Orig
import FFT.DFTControl
import FFT.Samples

setupEnv = do
    let samples512 = samples 1 512
	samples1024 = samples 1 1024
        samples2048 = samples 1 2048
    return (samples512, samples1024, samples2048)

main = defaultMain [
        env setupEnv $ \ ~(samples512, samples1024, samples2048) -> bgroup "DFT-Control" [
                bgroup "dft-control512" [
                    bench "orig" $ nf dft samples512,
                    bench "dcdft" $ nf dcdft samples512 
		    ],
                bgroup "dft-control1024" [
                    bench "orig" $ nf dft samples1024,
                    bench "dcdft" $ nf dcdft samples1024
                    ],
                bgroup "dft-control2048" [
                    bench "orig" $ nf dft samples2048,
                    bench "dcdft" $ nf dcdft samples2048 
                    ]
            ]
    ]
