import Criterion.Main
import FFT.Orig
import FFT.DFTData
import FFT.Samples

setupEnv = do
    let samples1024 = samples 1 1024
        samples2048 = samples 1 2048
        samples4096 = samples 1 4096
    return (samples1024, samples2048, samples4096)

main = defaultMain [
        env setupEnv $ \ ~(samples1024, samples2048, samples4096) -> bgroup "DFT-Data" [
                bgroup "DFTData1024" [
                    bench "orig" $ nf dft samples1024,
                    bench "innerMap" $ nf dftInnerMap samples1024,
                    bench "foldMap" $ nf dftFoldMap samples1024,
                    bench "outerMap" $ nf dftOuterMap samples1024,
                    bench "innerMapReduce" $ nf dftInnerMapReduce samples1024
                ]
            ]
    ]
