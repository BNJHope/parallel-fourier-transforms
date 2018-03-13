import Test.HUnit
import FFT.FFTData
import FFT.Orig
import FFT.Samples
import System.Environment
import Data.Complex


testfftbFlySParZip = TestCase (assertEqual "FFT-blfys-parzip" expected actual)
    where
        expected = (sum $ fftbFlySParZip samples512)
        actual = (sum $ fft samples512)
        samples512 = samples 1 512

testfftbFlySParZipMap = TestCase (assertEqual "FFT-blfys-parzipmap" expected actual)
    where
        expected = (sum $ fftbFlySParZipMap samples512)
        actual = (sum $ fft samples512)
        samples512 = samples 1 512


tests = TestList [TestLabel "testfftFlySParZip" testfftbFlySParZip,
                TestLabel "testfftbFlySParZipMap" testfftbFlySParZipMap]

main = runTestTT tests
