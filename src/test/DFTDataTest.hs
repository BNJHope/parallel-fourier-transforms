import Test.HUnit
import FFT.DFTData
import FFT.Orig
import FFT.Samples
import System.Environment
import Data.Complex

testDftInnerMap = TestCase (assertEqual "DFTInnerMap" expected actual)
    where
        expected = (sum $ dftInnerMap samples512)
        actual = (sum $ dft samples512)
        samples512 = samples 1 512

testDftFoldMap =  TestCase (assertEqual "DFTFoldMap" expected actual)
    where
        expected = (sum $ dftFoldMap samples512)
        actual = (sum $ dft samples512)
        samples512 = samples 1 512

testDftOuterMap = TestCase (assertEqual "DFTOuterMap" expected actual)
    where
        expected = (sum $ dftOuterMap samples512)
        actual = (sum $ dft samples512)
        samples512 = samples 1 512

testDftInnerMapReduce = TestCase (assertEqual "DFTInnerMapReduce" expected actual)
    where
        expected = (sum $ dft samples512)
        actual = (sum $ dft samples512)
        samples512 = samples 1 512

tests = TestList [TestLabel "testDftOuterMap" testDftOuterMap,
                    TestLabel "testDftInnerMap" testDftInnerMap,
                    TestLabel "testDftFoldMap" testDftFoldMap,
                    TestLabel "testDftInnerMapReduce" testDftInnerMapReduce
                    ]

main = runTestTT tests
