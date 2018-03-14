import Test.HUnit
import FFT.FFTControl
import FFT.Orig
import FFT.Samples
import System.Environment
import Data.Complex

testFFTbflySPipeline = TestCase (assertEqual "FFT-bflyS-Pipline" expected actual)
    where
        expected = (sum $ fftbflySPipeline samples512)
        actual = (sum $ fft samples512)
        samples512 = samples 1 512

testFFTDc = TestCase (assertEqual "DFTDc" expected actual)
    where
        expected = (sum $ fftdc samples512)
        actual = (sum $ fft samples512)
        samples512 = samples 1 512

tests = TestList [TestLabel "testFFTbFlysPipeline" testFFTbflySPipeline,
		TestLabel "testFFTDc" testFFTDc
                    ]
                    
main = runTestTT tests
