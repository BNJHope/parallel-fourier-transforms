import Criterion.Main
import FFT.Orig
import FFT.DFTControl
import FFT.Samples

setupEnv = do
    let samples256 = samples 1 256
        samples512 = samples 1 512
	samples1024 = samples 1 1024
    return (samples256, samples512, samples1024)

main = defaultMain [
        env setupEnv $ \ ~(samples256, samples512, samples1024) -> bgroup "DFT-Control" [
                bgroup "dft-control256" [
                    bench "orig" $ nf dft samples256,
                    bench "dcdft" $ nf dcdft samples256,
                    bench "tfdft" $ nf tfdft samples256,
                    bench "nestedtfdft" $ nf nestedtfdft samples256
		    ],
                bgroup "dft-control512" [
                    bench "orig" $ nf dft samples512,
                    bench "dcdft" $ nf dcdft samples512,
                    bench "tfdft" $ nf tfdft samples512,
                    bench "nestedtfdft" $  nf nestedtfdft samples512
		    ],
                bgroup "dft-control1024" [
                    bench "orig" $ nf dft samples1024,
                    bench "dcdft" $ nf dcdft samples1024,
                    bench "tfdft" $ nf tfdft samples1024,
                    bench "nestedtfdft" $  nf nestedtfdft samples1024
                    ]
           ]
    ]
