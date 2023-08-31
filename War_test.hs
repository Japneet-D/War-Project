module Main where
    import Test.HUnit
    import Data.List
    import qualified War
    import qualified System.Exit as Exit

    main = do
         status <- runTestTT tests
         if failures status > 0 then Exit.exitFailure else return ()
-- run tests with:
--     cabal test

-- here are some standard tests
-- you should augment them with your own tests for development purposes

    deal = War.deal
    
    --Test Values In Order of Lowest To Highest Distribued (2-13, 1)
    t6 = [2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,8,8,8,8,9,9,9,9,10,10,10,10,11,11,11,11,12,12,12,12,13,13,13,13,1,1,1,1]
    r6 = [1,1,1,1,13,13,13,13,12,12,12,12,11,11,11,11,10,10,10,10,9,9,9,9,8,8,8,8,7,7,7,7,6,6,6,6,5,5,5,5,4,4,4,4,3,3,3,3,2,2,2,2] 
 
    --Test Random Values From A Deck I Shuffled For War
    t7 = [12,13,9,8,4,13,11,11,8,1,2,12,13,2,3,7,5,1,8,13,5,9,7,9,10,2,11,1,9,10,3,4,5,7,5,3,11,2,12,8,4,3,6,6,1,4,12,7,6,6,10,10]
    r7 = [12,10,12,6,11,11,10,10,4,2,8,2,7,2,7,6,11,4,8,3,1,5,13,3,13,12,9,8,10,9,9,6,4,2,6,3,1,1,1,12,11,5,7,3,13,8,9,7,13,5,5,4]

    --Test Values Counting Down 13-1, 13-1
    t8 = [13,12,11,10,9,8,7,6,5,4,3,2,1,13,12,11,10,9,8,7,6,5,4,3,2,1,13,12,11,10,9,8,7,6,5,4,3,2,1,13,12,11,10,9,8,7,6,5,4,3,2,1]
    r8 = [1,9,13,7,13,6,12,11,11,8,4,3,11,6,9,2,9,8,8,5,9,5,8,2,1,10,12,7,13,10,7,5,11,6,6,4,1,12,5,3,13,10,4,3,1,10,4,2,12,7,3,2]

    --Test Values Counting Up - Repeating Twice 1,1-13,13, 1,1-13,13
    t9 = [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13]  
    r9 = [1,1,1,1,13,13,13,13,12,12,12,12,11,11,11,11,10,10,10,10,9,9,9,9,8,8,8,8,7,7,7,7,6,6,6,6,5,5,5,5,4,4,4,4,3,3,3,3,2,2,2,2]

    --Test Values Repeated Twice From Lowest To Highest 2,3,2,3,2,3,2,3-12,13,12,13,12,13,12,13
    t10 = [2,3,2,3,2,3,2,3,4,5,4,5,4,5,4,5,6,7,6,7,6,7,6,7,8,9,8,9,8,9,8,9,10,11,10,11,10,11,10,11,12,13,12,13,12,13,12,13,1,1,1,1]
    r10 = [1,1,1,1,13,12,13,12,13,12,13,12,11,10,11,10,11,10,11,10,9,8,9,8,9,8,9,8,7,6,7,6,7,6,7,6,5,4,5,4,5,4,5,4,3,2,3,2,3,2,3,2]

    test6 = TestCase (assertEqual "t6" r6 (deal t6))
    test7 = TestCase (assertEqual "t7" r7 (deal t7))
    test8 = TestCase (assertEqual "t8" r8 (deal t8))
    test9 = TestCase (assertEqual "t9" r9 (deal t9))
    test10 = TestCase (assertEqual "t10" r10 (deal t10))

    tests = TestList [ TestLabel "test6" test6, 
                       TestLabel "test7" test7,
                       TestLabel "test8" test8,
                       TestLabel "test9" test9,
                       TestLabel "test10" test10 ]





