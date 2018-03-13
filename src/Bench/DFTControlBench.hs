import Criterion.Main
import FFT.Orig
import FFT.DFTControl
import FFT.Samples

setupEnv = do
    let samples1024 = samples 1 1024
        samples2048 = samples 1 2048
        samples4096 = samples 1 4096
    return (samples1024, samples2048, samples4096)

main = defaultMain [
        env setupEnv $ \ ~(samples1024, samples2048, samples4096) -> bgroup "DFT-Control" [
                bgroup "dft-control" [
                    bench "orig" $ nf dft samples1024,
                    bench "dcdft" $ nf dcdft samples1024
                    ]
            ]
    ]
