import Test.HUnit
import FFT.DFTControl
import FFT.Orig
import FFT.Samples
import System.Environment
import Data.Complex

testDcDft = TestCase (assertEqual "DFTDc" expected actual)
    where
        expected = (sum $ dcdft samples512)
        actual = (sum $ dft samples512)
        samples512 = samples 1 512

tests = TestList [TestLabel "testDcDFT" testDcDft
                    ]
                    
main = runTestTT tests
