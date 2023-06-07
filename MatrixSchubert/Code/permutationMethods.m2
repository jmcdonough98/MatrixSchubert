-----------------------------------------------
-----------------------------------------------
--**Useful functions for permutations**
-----------------------------------------------
-----------------------------------------------

--INPUT: A list w
--OUTPUT: TRUE if w is a permutation; else FALSE

isPerm = method()
isPerm List := Boolean => (w) -> (
    n := #w;
    (sort w) == toList(1..n)
    )

isIdentity = method()
isIdentity List := Boolean => (w) -> (
    n := #w;
    w == toList(1..n)
    )

lastDescent = method()
lastDescent List := Boolean => (w) -> (
    if not (isPerm w) then error ("Expecting a permutation.");
    if isIdentity(w) then error ("Expecting a non-identity permutation.");
    n := #w;
   
    ans := -1;
    scan (reverse (0..n-2), i-> if w_i > w_(i+1) then (ans = i+1; break));
    ans
    )

permLength = method()
permLength List:= ZZ => (p) -> (
    if not(isPerm p) then error("The input must be a permutation.");
    l := 0;
    scan(#p, i->scan(i..#p-1, j ->(if p#i>p#j then l=l+1)));
     l)
 
swap = (L,i,j) -> (apply(#L, k-> if k!=i and k!=j then L_k
	                         else if k == i then L_j
				 else L_i))
--------------------------------
--auxiliary function for making a permutation matrix out of a perm in 1-line notation
--INPUT: a list w, which is a permutation in 1-line notation
--OUTPUT: a permutation matrix A corresponding to to w
--NOTE: this might be the transpose of what some would want
--TODO: add documentation
-----------------------------------
permToMatrix = method()
permToMatrix List := Matrix => (w) -> (
    if not(isPerm w) then error("The input must be a permutation.");
    n := #w;
    transpose (id_(ZZ^n))_(apply(w, i-> i-1))
    )


------------------------------------
--INPUT: A transposition in cycle notation, and the n for which to regard perm 
--       as an element of S_n
--OUTPUT: the transposition in one-line notation
--TODO: docs and tests
------------------------------------
toOneLineNotation = method()
toOneLineNotation (Sequence, ZZ) := List => (perm, maxIdx) -> (
    switch(perm_0-1, perm_1-1, toList(1..maxIdx))
)
toOneLineNotation (List, ZZ) := List => (perm, maxIdx) -> (
    switch(perm_0-1, perm_1-1, toList(1..maxIdx))
)

------------------------------------
--INPUT: An index (i,j)
--OUTPUT: the corresponding transposition according to antidiagonal term order
--TODO: docs and tests
------------------------------------
toAntiDiagTrans = method()
toAntiDiagTrans (Sequence, ZZ) := List => (idx, maxIdx) -> (
    transposition := (sum(toList idx)-1, sum(toList idx));
    toOneLineNotation(transposition, maxIdx)
)
toAntiDiagTrans (List, ZZ) := List => (idx, maxIdx) -> (
    transposition := {sum(toList idx)-1, sum(toList idx)};
    toOneLineNotation(transposition, maxIdx)
)

------------------------------------
--INPUT: Two permutations in one-line notation
--OUTPUT: the composition of the two permutations w = vu
------------------------------------
composePerms = method()
composePerms (List, List) := List => (u,v) -> (
    if not (isPerm u) then error("The first argument is not a permutation.");
    if not (isPerm v) then error("the second argument is not a permutation.");
    u0 := apply(u, i->i-1);
    v0 := apply(v, i->i-1);
    apply(u0_v0, i-> i+1)
    )

--------------------------------
--checks if a permutation is pattern-avoiding
--INPUT: a permutation (in one-line notation), written as a list
--OUTPUT: whether the permutation avoid the pattern
--TODO: input validation/type checking
--------------------------------
isPatternAvoiding = method()
isPatternAvoiding (List,List) := Boolean => (perm, pattern) -> (
    --input validation
    if not (isPerm perm) then error(toString perm | " is not a permutation.");
    --assume permutation is pattern-avoiding, break if not true
    isAvoiding := true;
    for idx in subsets(0..#perm-1, #pattern) do {
        sortedIdx := sort(idx);
        pairwiseComparison := apply(pattern_{0..#pattern-2}, pattern_{1..#pattern-1}, (i,j) -> perm#(sortedIdx#(i-1)) < perm#(sortedIdx#(j-1))); -- pairwise comparison of permutation according to pattern
        isAvoiding = not all(pairwiseComparison, i -> i == true); -- true if there was one inequality that failed, else all inequalities are true and so not pattern-avoiding
        if not isAvoiding then break;
    };
    isAvoiding
)

--------------------------------
--checks if a permutation is vexillary, i.e. 2143-avoiding
--INPUT: a permutation (one-line notation), written as a list
--OUTPUT: whether the permutation is vexillary
--TODO: input validation/type checking
--------------------------------
isVexillary = method()
isVexillary List := Boolean => (perm) -> (
    --input validation
    if not (isPerm perm) then error(toString perm | " is not a permutation.");
    isPatternAvoiding(perm, {2,1,4,3})
)

------------------------------------------
--INPUT: rajCode, takes a permutation in one line notation
--OUTPUT: returns the rajCode of the permutation
------------------------------------------

rajCode = method()
rajCode List := ZZ => (w) -> (

    if not (isPerm w) then error ("Expecting a permutation.");
   
    rajCodeVec := {};
    for k from 0 to #w-2 do (
	maxLengthIncr := 1;
	fVal := w_k;
	subPerm := w_{k+1..#w-1};
	for l in delete({},subsets(subPerm)) do (
	    testPerm := {fVal} | l;
	    maxLengthIncr = max(maxLengthIncr,lengthIncrSubset(testPerm));
	);
    	
	rajCodeVec = append(rajCodeVec,(#subPerm+1 - maxLengthIncr));
    );
    return rajCodeVec;
);


------------------------------------------
--INPUT: rajIndex, takes a permutation in one line notation
--OUTPUT: returns the rajIndex of the permutation
------------------------------------------
rajIndex = method()
rajIndex List := ZZ => (w) -> (
  
    if not (isPerm w) then error ("Expecting a permutation.");
    
    return sum rajCode w;
    
);

------------------------------------------
--INPUT: lengthIncrSeq, takes a permutation in one line notation
--OUTPUT: returns the length of the longest consecutive permutation
--        which starts at the beginning of the permutation
--TO DO: Thoroughly test and document
------------------------------------------

lengthIncrSubset = (w) -> (
   
   if (w == {}) then return 0;
   
   i := 1;
   preVal := w_0;
   for i from 1 to #w-1 do (
       if (preVal > w_i) then return i;
       preVal = w_i;
   );
   return #w;
);