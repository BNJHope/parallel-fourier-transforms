import Test.HUnit
import FFT.FFTControl
import FFT.Orig
import FFT.Samples
import System.Environment
import Data.Complex

testFFTbflySPipeline = TestCase (assertEqual "DFTDc" expected actual)
    where
        expected = (sum $ fftbflySPipeline samples512)
        actual = (sum $ fft samples512)
        samples512 = samples 1 512

tests = TestList [TestLabel "testFFTbFlysPipeline" testFFTbflySPipeline
                    ]
                    
main = runTestTT tests
