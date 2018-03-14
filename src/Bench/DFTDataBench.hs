import Criterion.Main
import FFT.Orig
import FFT.DFTData
import FFT.Samples

setupEnv = do
    let samples256 = samples 1 256
        samples512 = samples 1 512
	samples1024 = samples 1 1024
    return (samples256, samples512, samples1024)

main = defaultMain [
        env setupEnv $ \ ~(samples256, samples512, samples1024) -> bgroup "DFT-Data" [
                bgroup "DFTData256" [
                    bench "orig" $ nf dft samples256,
                    bench "innerMap" $ nf dftInnerMap samples256,
                    bench "foldMap" $ nf dftFoldMap samples256,
                    bench "outerMap" $ nf dftOuterMap samples256,
                    bench "innerMapReduce" $ nf dftInnerMapReduce samples256
                ],                bgroup "DFTData512" [
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
                ]
           ]
    ]
