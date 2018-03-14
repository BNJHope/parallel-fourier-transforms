import Criterion.Main
import FFT.Orig
import FFT.DFTData
import FFT.Samples

setupEnv = do
    let samples512 = samples 1 512
	samples1024 = samples 1 1024
        samples2048 = samples 1 2048
    return (samples512, samples1024, samples2048)

main = defaultMain [
        env setupEnv $ \ ~(samples512, samples1024, samples2048) -> bgroup "DFT-Data" [
                bgroup "DFTData512" [
                    bench "orig" $ nf dft samples512,
                    bench "innerMap" $ nf dftInnerMap samples512,
                    bench "foldMap" $ nf dftFoldMap samples512,
                    bench "outerMap" $ nf dftOuterMap samples512,
                    bench "innerMapReduce" $ nf dftInnerMapReduce samples512
                ],
                bgroup "DFTData1024" [
                    bench "orig" $ nf dft samples1024,
                    bench "innerMap" $ nf dftInnerMap samples1024,
                    bench "foldMap" $ nf dftFoldMap samples1024,
                    bench "outerMap" $ nf dftOuterMap samples1024,
                    bench "innerMapReduce" $ nf dftInnerMapReduce samples1024
                ],
                bgroup "DFTData2048" [
                    bench "orig" $ nf dft samples2048,
                    bench "innerMap" $ nf dftInnerMap samples2048,
                    bench "foldMap" $ nf dftFoldMap samples2048,
                    bench "outerMap" $ nf dftOuterMap samples2048,
                    bench "innerMapReduce" $ nf dftInnerMapReduce samples2048
                ]
            ]
    ]
