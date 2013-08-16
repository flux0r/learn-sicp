import Prelude hiding (product, sum)

cube x = x*x*x

sum term next a b =
    if a > b
        then 0
        else term a + sum term next (next a) b

sumCubes = sum cube succ

sumIntegers = sum id succ

piApprox n = 8*sumPi
  where
    sumPi = sum (\ x -> 1/(x*(x + 2))) (4 +) 1 n

definiteIntegral f a b dx = dx*(sum f (dx +) (a + dx/2) b)

------------------------------------------------------------------------------
-- | Exercise 1.29: Simpson's rule
simpsons f a b n = (h/3)*(y 0 + summation 1 (n' - 1) + y n')
  where
    n' = if even n then n else n - 1
    h = (b - a)/(fromIntegral n)
    y k = f (a + (fromIntegral k)*h)
    summation = sum term (1 +)
    term k = (if even k then 2 else 4)*(y k)

------------------------------------------------------------------------------
-- | Exercise 1.30: Iterative version of sum
sumIter term next a b = iter a 0
  where
    iter x acc = if x > b then acc else iter (next x) (acc + term x)

------------------------------------------------------------------------------
-- | Exercise 1.31: Products
product term next a b = 
    if a > b
        then 1
        else (term a)*(product term next (next a) b)

factorial = product id succ 1

piApproxProduct n = 4*(product term succ 1 n)
  where
    term x = let x' = fromIntegral x
             in  if odd x
                    then (x' + 1)/(x' + 2)
                    else (x' + 2)/(x' + 1)

productIter term next a b = iter a 1
  where
    iter x acc = if x > b then acc else iter (next x) (acc*(term x))

------------------------------------------------------------------------------
-- | Exercise 1.32: Accumulate
accumulate f identity term next a b =
    if a > b
        then identity
        else (term a) `f` (accumulate f identity term next (next a) b)

accumulateIter f identity term next a b = iter a identity
  where
    iter x acc =
        if x > b
            then acc
            else iter (next x) (acc `f` term x)

------------------------------------------------------------------------------
-- | Exercise 1.33: Filtered accumulate
filteredAccumulate f identity p term next a b
  | a > b       = identity
  | p a         = f (term a)
                    (filteredAccumulate f identity p term next (next a) b)
  | otherwise   = (filteredAccumulate f identity p term next (next a) b)

divides x y = x `mod` y == 0

findDivisor n x
  | x*x > n     = n
  | divides n x = x
  | otherwise   = findDivisor n (x + 1)

smallestDivisor = flip findDivisor $ 2

prime x = smallestDivisor x == x

sumSquaresPrime = filteredAccumulate (+) 0 prime (^2) (+ 1)
