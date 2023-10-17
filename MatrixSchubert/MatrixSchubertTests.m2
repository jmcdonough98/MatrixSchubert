-------------------------
-------------------------
--**TESTS SECTIONS**--
-------------------------
-------------------------

--Testing functions in MatrixSchubertConstructions--

TEST ///
--isPartialASM
L = {
    matrix{{1}},
    matrix{{1,0},{0,1}},
    matrix{{0,1},{1,0}},
    matrix{{0,1,0},{0,0,1},{1,0,0}},
    matrix{{0,1,0},{1,-1,1},{0,1,0}},
    matrix{{0,1,0,0},{0,0,1,0},{1,0,0,0},{0,0,0,1}},
    matrix{{1,0,0,0},{0,0,1,0},{0,1,-1,1},{0,0,1,0}},
    matrix{{0,0,1,0},{0,1,-1,1},{1,-1,1,0},{0,1,0,0}},
    matrix{{0,0,1,0},{1,0,-1,1},{0,1,0,0},{0,0,1,0}},
    matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}},
    matrix{{0,0,1,0,0,0,0,0},{1,0,-1,0,1,0,0,0},{0,0,0,1,-1,0,0,1},{0,0,1,-1,1,0,0,0},{0,0,0,0,0,0,1,0},{0,0,0,0,0,1,0,0},{0,1,-1,1,0,0,0,0},{0,0,1,0,0,0,0,0}},
    matrix{{0,0,0,0,1,0,0,0},{0,0,1,0,-1,1,0,0},{0,0,0,1,0,0,0,0},{1,0,0,-1,1,-1,1,0},{0,1,-1,1,-1,1,0,0},{0,0,0,0,1,0,0,0},{0,0,1,0,0,0,0,0},{0,0,0,0,0,0,0,1}},
    matrix{{0,0,0},{0,1,0},{1,-1,0}},
    matrix{{1,0,0},{0,0,0}},
    matrix{{1,0,0},{0,0,1}},
    matrix{{0,1,0},{1,-1,0}},
    matrix{{0,1,0},{1,-1,0}},
    matrix{{0,0,1},{1,0,-1}},
    matrix{{0,0,1,0,0},{0,0,0,0,1},{0,0,0,0,0},{0,1,0,0,0}}
    };
assert(apply(L,isPartialASM) == toList (#L:true))



T = {
    matrix{{-1}},
    matrix{{0,1,0},{1,0,1},{0,1,0}},
    matrix{{0,0,1,0,0,0,0,0},{1,0,1,0,1,0,0,0},{0,0,0,1,-1,0,0,1},{0,0,1,-1,1,0,0,0},{0,0,0,0,0,0,1,0},{0,0,0,0,0,1,0,0},{0,1,-1,1,0,0,0,0},{0,0,1,0,0,0,0,0}},
    matrix{{1,0,0,0},{0,0,1,0},{-1,1,0,0},{1,0,-1,1}}
    };
assert( apply(T, isPartialASM) == toList (#T:false))
///

TEST ///
---partialASMToASM
assert(partialASMToASM matrix{{0,0,1,0},{1,0,-1,0},{0,0,0,0}} == matrix{{0,0,1,0,0,0},{1,0,-1,0,1,0},{0,0,0,0,0,1},{0,1,0,0,0,0},{0,0,1,0,0,0},{0,0,0,1,0,0}})
///

TEST ///
--antiDiagInit
I = antiDiagInit({1,3,2});
R = ring I;
assert(I == ideal ( R_1 * R_3));

I = antiDiagInit(matrix{{0,0,0,1},{0,1,0,0},{1,-1,1,0},{0,1,0,0}});
R = ring I;
assert(I == ideal (R_0,R_1,R_2,R_4,R_5*R_8));
///

TEST ///
--rankTable
assert(rankTable({1,3,2}) == matrix{{1, 1, 1}, {1, 1, 2}, {1, 2, 3}});
assert(rankTable(matrix{{0,0,0,1},{0,1,0,0},{1,-1,1,0},{0,1,0,0}}) == matrix{{0, 0, 0, 1}, {0, 1, 1, 2}, {1, 1, 2, 3}, {1, 2, 3, 4}});
///

TEST ///
-- rotheDiagram

assert(sort rotheDiagram matrix{{0,0,1,0,0},{1,0,-1,0,0},{0,1,0,0,0},{0,0,1,0,0}} == sort {(1,1),(1,2),(2,3),(2,4),(2,5)})
assert(sort rotheDiagram {2,6,5,1,4,3} == sort {(1,1),(2,1),(2,3),(2,4),(2,5),(3,1),(3,3),(3,4),(5,3)})
///

TEST ///
-- augmentedRotheDiagram 

assert(sort augmentedRotheDiagram {2,1,5,4,3} == sort {((1,1),0), ((3,3),2),((3,4),2), ((4,3),2)})
assert(sort augmentedRotheDiagram matrix{{0,1,0},{1,-1,1},{0,1,0}} == sort{((1,1),0), ((2,2),1)})
assert (sort augmentedRotheDiagram matrix {{0,0,1,0,0},{1,0,0,0,0},{0,1,-1,1,0},{0,0,0,0,1},{0,0,1,0,0}} == sort {((1,1),0),((1,2),0),((4,3),2),((3,3),2)})
///

TEST ///
--essentialSet
--Example 2.1 in Weigandt "Prism Tableaux for ASMs"
A = matrix{{0,0,0,1},{0,1,0,0},{1,-1,1,0},{0,1,0,0}};
assert(isPartialASM A)
assert(sort essentialSet(A) == {(1,3),(2,1),(3,2)})
///

TEST ///
-- essentialSet

assert(essentialSet({2,1,6,3,5,4 })== {(1, 1), (3, 5), (5, 4)})
assert(essentialSet matrix {{0,1,0,0,0,0},{1,0,0,0,0,0},{0,0,0,0,0,1},{0,0,1,0,0,0},{0,0,0,0,1,0},{0,0,0,1,0,0}} == {(1, 1), (3, 5), (5, 4)})

assert(essentialSet({1}) == {})
assert(essentialSet(matrix {{0,0,1,0,0},{1,0,0,0,0},{0,1,-1,1,0},{0,0,0,0,1},{0,0,1,0,0}}) == {(1,2),(4,3)}) -- previously broken example
///


TEST ///
-- augmentedEssentialSet

assert(augmentedEssentialSet({2,1,6,3,5,4 })== {((1, 1), 0), ((3, 5), 2), ((5, 4), 3)})
assert(augmentedEssentialSet matrix {{0,1,0,0,0,0},{1,0,0,0,0,0},{0,0,0,0,0,1},{0,0,1,0,0,0},{0,0,0,0,1,0},{0,0,0,1,0,0}} == {((1, 1), 0), ((3, 5), 2), ((5, 4), 3)})

assert(augmentedEssentialSet({1}) == {})
assert(augmentedEssentialSet(matrix {{0,0,1,0,0},{1,0,0,0,0},{0,1,-1,1,0},{0,0,0,0,1},{0,0,1,0,0}}) == {((1, 2), 0), ((4, 3), 2)}) -- previously broken example
///


--TODO: make more complicated tests
TEST ///
--schubDetIdeal
--Example 15.4 from Miller-Sturmfels
I = schubDetIdeal({1,2,3});
assert(I == ideal(0_(ring I)));

I = schubDetIdeal({2,1,3});
assert(I == ideal((ring I)_0));

I = schubDetIdeal({2,3,1});
assert(I == ideal((ring I)_0, (ring I)_3));

I = schubDetIdeal({3,2,1});
assert(I == ideal((ring I)_0, (ring I)_1, (ring I)_3));

I = schubDetIdeal({1,3,2});
assert(I == ideal((ring I)_0 * (ring I)_4 - (ring I)_1 * (ring I)_3));
///

TEST ///
--fultonGens
L = fultonGens matrix{{0,1,0},{1,-1,1},{0,1,0}};
assert(toExternalString L_0 == "z_(1,1)")
assert(toExternalString L_1 == "-z_(1,2)*z_(2,1)+z_(1,1)*z_(2,2)")


L = fultonGens {2,5,4,1,3};
assert(toExternalString L_0 == "-z_(1,2)*z_(2,1)+z_(1,1)*z_(2,2)");
assert(toExternalString L_1 == "-z_(1,3)*z_(2,1)+z_(1,1)*z_(2,3)");
assert(toExternalString L_2 == "-z_(1,3)*z_(2,2)+z_(1,2)*z_(2,3)");
assert(toExternalString L_3 == "-z_(1,4)*z_(2,1)+z_(1,1)*z_(2,4)");
assert(toExternalString L_4 == "-z_(1,4)*z_(2,2)+z_(1,2)*z_(2,4)");
assert(toExternalString L_5 == "-z_(1,4)*z_(2,3)+z_(1,3)*z_(2,4)");
assert(toExternalString L_6 == "z_(1,1)");
assert(toExternalString L_7 == "z_(2,1)");
assert(toExternalString L_8 == "z_(3,1)");
assert(toExternalString L_9 == "-z_(1,2)*z_(3,1)+z_(1,1)*z_(3,2)");
assert(toExternalString L_10 == "-z_(2,2)*z_(3,1)+z_(2,1)*z_(3,2)");
assert(toExternalString L_11 == "-z_(1,3)*z_(3,1)+z_(1,1)*z_(3,3)");
assert(toExternalString L_12 == "-z_(2,3)*z_(3,1)+z_(2,1)*z_(3,3)");
assert(toExternalString L_13 == "-z_(1,3)*z_(3,2)+z_(1,2)*z_(3,3)");
assert(toExternalString L_14 == "-z_(2,3)*z_(3,2)+z_(2,2)*z_(3,3)");

///

TEST ///
-- entrywiseMinRankTable
assert(entrywiseMinRankTable(({{4,3,1,2},{2,4,3,1}} / permToMatrix)) == matrix{{0, 0, 0, 1}, {0, 0, 1, 2}, {0, 1, 2, 3}, {1, 2, 3, 4}});
///


TEST ///
-- entrywiseMaxRankTable
assert(entrywiseMaxRankTable(({{4,3,1,2},{2,4,3,1}} / permToMatrix)) == matrix{{0, 1, 1, 1}, {0, 1, 1, 2}, {1, 1, 2, 3}, {1, 2, 3, 4}});
///

TEST ///
-- isASMUnion
assert isASMUnion {{1}}
assert isASMUnion {{4,3,2,1}}
assert not isASMUnion {{2,1,3,4},{4,2,3,1}}
assert isASMUnion {{3,1,2},{2,3,1}}
assert isASMUnion {{4,1,3,2},{3,4,1,2},{2,4,3,1}}
///

TEST ///
-- isMinRankTable
T1 = matrix {{0,1,1},{1,1,2},{1,2,3}}
T2 = matrix {{1,1,1,1,1},{1,2,2,2,2},{1,2,2,2,3},{1,2,2,3,3},{1,2,3,3,3}}
F1 = matrix {{1,0,1,0},{0,1,0,-1},{2,2,0,0},{3,5,8,0}}
F2 = matrix {{1,1,1,1,1},{1,2,2,2,0},{1,2,2,2,3},{1,2,2,3,3},{1,2,3,3,3}}

assert(isMinRankTable(T1))
assert(isMinRankTable(T2))
assert(not isMinRankTable(F1))
assert(not isMinRankTable(F2))
///

TEST///
-- rankTableToASM
Ar = matrix {{0,0,1,1},{0,1,1,2},{1,2,2,3},{1,2,3,4}}
A = matrix {{0,0,1,0},{0,1,-1,1},{1,0,0,0},{0,0,1,0}}
assert(rankTableToASM(Ar) == A)

Br = matrix {{0,0,1,1,1},{1,1,1,2,2},{1,2,2,3,3},{1,2,3,4,4},{1,2,3,4,5}}
B = matrix {{0,0,1,0,0},{1,0,-1,1,0},{0,1,0,0,0},{0,0,1,0,0},{0,0,0,0,1}}
assert(rankTableToASM(Br) == B)
///

TEST///
-- rankTableFromMatrix
Am = matrix {{1,0,0},{0,23,24},{23,24,25}}
A = matrix {{0,0,0},{0,1,1},{1,2,2}}
assert(rankTableFromMatrix(Am) == A)
///

TEST ///
--schubIntersect
I=schubIntersect {matrix {{0,1,0},{1,-1,1},{0,1,0}}, {3,2,1}};
R=ring I;
assert(I==ideal(R_0,R_1*R_3));
///


TEST ///
--schubAdd
I=schubAdd {matrix {{0,1,0},{1,-1,1},{0,1,0}}, {3,2,1}};
R=ring I;
assert(I==ideal(R_0,R_1,R_3));
///

TEST ///
-- getPermFromASM
L = {
    matrix{{1,0,0,0}},
    matrix{{1,0},{0,0}},
    matrix{{0,0,0,1},{0,1,0,0},{1,-1,1,0},{0,1,0,0}},
    matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}},
    matrix{{0,1,0,0},{1,0,0,0},{0,0,1,0},{0,0,0,1}}
}
Lc = {{},{},{},{},{2,1,3,4}}
assert all (#L, i -> getPermFromASM L_i == Lc_i)
///

-*
--NOTE: it would be nice to keep this test, but it would also be nice to not 
--      have to export it as well
TEST ///
--indexOfVariable
R = QQ[x_1..x_5]
assert(indexOfVariable x_1 == 1)

R = QQ[x_1..x_3,y_3..y_5]
assert(indexOfVariable y_4 == 4)

R = QQ[x_(1,1)..x_(4,4)]
assert(indexOfVariable x_(2,3) == (2,3))

R = QQ[x_{1,1}..x_{4,4}]
assert(indexOfVariable x_{2,3} == {2,3})
///
*-

--Testing Permutation Functions--

TEST ///
--composePerms
assert(composePerms({2,3,4,1}, {4,3,2,1}) == {1,4,3,2})
assert(composePerms({4,3,2,1}, {4,3,2,1}) == {1,2,3,4})
assert(composePerms({1,2,3,4,5}, {3,5,2,1,4}) == {3,5,2,1,4})
assert(composePerms({3,5,2,1,4}, {1,2,3,4,5}) == {3,5,2,1,4})
///

TEST ///
--isPatternAvoiding
assert(not isPatternAvoiding({2,3,7,1,5,8,4,6}, {1,4,3,2}));
assert(isPatternAvoiding({1,4,6,2,3,7,5}, {1,4,3,2}));

assert(not isPatternAvoiding({7,2,5,8,1,3,6,4}, {2,1,4,3}));
assert(isPatternAvoiding({1,6,9,2,4,7,3,5,8}, {2,1,4,3}));

--isVexillary
assert(not isVexillary({7,2,5,8,1,3,6,4}));
assert(isVexillary({1,6,9,2,4,7,3,5,8}));
///

TEST ///
--isCDG
assert(isCDG({5,4,3,2,1}));

--isCartwrightSturmfels
assert(isCartwrightSturmfels({5,4,3,2,1}));
///

TEST /// 
-- permLength 

assert(permLength {1} == 0)
assert(permLength {1,2} == 0)
assert(permLength {3,2,1} == 3)
assert(permLength {2,1,3} == 1)
assert(permLength {8,7,6,5,4,3,2,1} == 28)
///


TEST ///
-- schubCodim
L = {
    {1},
    {2,1},
    matrix{{0,0,0,1},{0,1,0,0},{1,-1,1,0},{0,1,0,0}},
    matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}}
}
assert all (L, i -> schubCodim i == codim schubDetIdeal i)
///

TEST ///
--schubReg
L = {
    {2,9,3,4,1,7,5,6,8}, -- example 1.2 in PSW
    {2,1},
    matrix{{0,0,0,1},{0,1,0,0},{1,-1,1,0},{0,1,0,0}},
    matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}},
    matrix{{0,1,0,0},{1,0,0,0},{0,0,0,1},{0,0,1,0}}
}
expected = {5,0,1,4,2}

assert all (#L, i -> schubReg L#i == expected#i)
///

TEST ///
-- bijections between ASMs and monotone triangles
-- example from introduction of Hamaker-Reiner
A = matrix{{0,1,0,0,0,0},{0,0,0,1,0,0},{1,-1,1,-1,0,1},{0,0,0,1,0,0},{0,1,0,-1,1,0},{0,0,0,1,0,0}}
M = {{}, {2}, {2, 4}, {1, 3, 6}, {1, 3, 4, 6}, {1, 2, 3, 5, 6}, {1, 2, 3, 4, 5, 6}}

assert(ASMToMonotoneTriangle A == M)
assert(MonotoneTriangleToASM M == A)
assert(ASMToMonotoneTriangle MonotoneTriangleToASM M == M)    -- inverse operations
assert(MonotoneTriangleToASM ASMToMonotoneTriangle A == A)    -- inverse operations
///


--Testing MatrixSchubertConstructions with Identity permutation / matrix--
TEST ///

w = {1,2,3,4};
I = matrix{{1,0,0,0},{0,1,0,0},{0,0,1,0},{0,0,0,1}};

--isPartialASM--
assert(isPartialASM(I) == true);
assert(partialASMToASM(I) == I);

--antiDiagInit--
testIdealPerm = antiDiagInit(w);
testIdealMat = antiDiagInit(I);
assert(testIdealPerm == ideal(0_(ring testIdealPerm)));
assert(testIdealMat == ideal(0_(ring testIdealMat)));

--rankMatrix--
assert(rankTable(w) == matrix{{1,1,1,1},{1,2,2,2},{1,2,3,3},{1,2,3,4}} );
assert(rankTable(I) == matrix{{1,1,1,1},{1,2,2,2},{1,2,3,3},{1,2,3,4}} );

--rotheDiagram--
assert(rotheDiagram(w) == {} );
assert(rotheDiagram(I) == {} );

--augmentedRotheDiagram--
assert(augmentedRotheDiagram(w) == {} );
assert(augmentedRotheDiagram(I) == {} );

--essentialSet--
assert(essentialSet(w) == {} );
assert(essentialSet(I) == {} );

assert(augmentedEssentialSet(w) == {} );
assert(augmentedEssentialSet(I) == {} );

--schubDetIdeal--
testIdealPerm = schubDetIdeal(w);
testIdealMat = schubDetIdeal(I);
assert(testIdealPerm == ideal(0_(ring testIdealPerm)));
assert(testIdealMat == ideal(0_(ring testIdealMat)));

--fultonGens--
assert(fultonGens(w) == {0} );
assert(fultonGens(I) == {0} );

--diagLexInitSE--
testIdealPerm = diagLexInitSE(w);
testIdealMat = diagLexInitSE(I);
assert(testIdealPerm == monomialIdeal(0_(ring testIdealPerm)));
assert(testIdealMat == monomialIdeal(0_(ring testIdealMat)));

--diagLexInitNW--
testIdealPerm = diagLexInitNW(w);
testIdealMat = diagLexInitNW(I);
assert(testIdealPerm == monomialIdeal(0_(ring testIdealPerm)));
assert(testIdealMat == monomialIdeal(0_(ring testIdealMat)));

--diagRevLexInit--
testIdealPerm = diagRevLexInit(w);
testIdealMat = diagRevLexInit(I);
assert(testIdealPerm == monomialIdeal(0_(ring testIdealPerm)));
assert(testIdealMat == monomialIdeal(0_(ring testIdealMat)));

--subwordComplex--
assert(toExternalString facets subwordComplex w == "{z_(1,1)*z_(1,2)*z_(1,3)*z_(1,4)*z_(2,1)*z_(2,2)*z_(2,3)*z_(2,4)*z_(3,1)*z_(3,2)*z_(3,3)*z_(3,4)*z_(4,1)*z_(4,2)*z_(4,3)*z_(4,4)}")

--entrywiseMinRankTable--
assert(entrywiseMinRankTable {I} == matrix{{1, 1, 1, 1}, {1, 2, 2, 2}, {1, 2, 3, 3}, {1, 2, 3, 4}})

--entrywiseMaxRankTable--
assert(entrywiseMaxRankTable {I} == matrix{{1, 1, 1, 1}, {1, 2, 2, 2}, {1, 2, 3, 3}, {1, 2, 3, 4}})

--schubDecomposition--
testIdealPerm = schubDetIdeal(w);
testIdealMat = schubDetIdeal(I);
assert(schubDecomposition schubDetIdeal w == {{1, 2, 3, 4}})
assert(schubDecomposition schubDetIdeal I == {{1, 2, 3, 4}})

--permOverASM--
assert(permOverASM I == {{1, 2, 3, 4}})

--isIntersectionSchubIdeals--
assert(isIntersectionSchubIdeals schubDetIdeal w == true );
assert(isIntersectionSchubIdeals schubDetIdeal I == true );

--isASMIdeal--
assert(isASMIdeal schubDetIdeal w == true );
assert(isASMIdeal schubDetIdeal I == true );

--isASMUnion--
--Examples in other file

--getASM--
assert(getASM schubDetIdeal w == I );
assert(getASM schubDetIdeal I == I );

--isMinRankTable--
assert(isMinRankTable rankTable w == true );
assert(isMinRankTable rankTable I == true );

--rankTableToASM--
--Examples in other file

--rankTableFromMatrix--
--Examples in other file

--schubIntersect--
--Examples in other file

--schubAdd--
--Examples in other file

--getPermFromASM
assert(getPermFromASM getASM schubDetIdeal I == w );

--ASM--
--???

--ASMToMonotoneTriangle--
assert(ASMToMonotoneTriangle(I) == {{},{1},{1,2},{1,2,3},{1,2,3,4}})

--MonotoneTriangleToASM--
assert(MonotoneTriangleToASM({{},{1},{1,2},{1,2,3},{1,2,3,4}}) == I)

--pipeDreams--
assert(pipeDreams w == {{{"/", "/", "/", "/"}, {"/", "/", "/", "/"}, {"/", "/", "/", "/"}, {"/", "/", "/", "/"}}})

--pipeDreamsNonReduced--
assert(pipeDreamsNonReduced w == {{{"/", "/", "/", "/"}, {"/", "/", "/", "/"}, {"/", "/", "/", "/"}, {"/", "/", "/", "/"}}})
///

------------------------
-------------------------
--**TESTS SECTIONS**--
-------------------------
-------------------------

--Testing MatrixSchubertConstructions with semi-interesting permutation / ASM / partial ASM--


TEST ///
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

--isPartialASM--
assert(isPartialASM(I) == true);
assert(isPartialASM(PI) == true);

--partialASMtToASM
outPI = matrix{{0, 0, 1, 0, 0, 0}, {0, 1, -1, 1, 0, 0}, {1, -1, 1, 0, 0, 0}, {0, 1, 0, -1, 0, 1}, {0, 0, 0, 1, 0, 0}, {0, 0, 0, 0, 1, 0}};
assert(partialASMToASM(I) == I);
assert(partialASMToASM(PI) == outPI);
///

TEST ///
--antiDiagInit--
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

L = antiDiagInit w;
assert(numgens L == 14);
assert(toExternalString L_0 == "z_(1,1)");
assert(toExternalString L_1 == "z_(1,3)*z_(2,2)*z_(3,1)");
assert(toExternalString L_2 == "z_(1,4)*z_(2,2)*z_(3,1)");
assert(toExternalString L_3 == "z_(1,5)*z_(2,2)*z_(3,1)");
assert(toExternalString L_4 == "z_(1,4)*z_(2,3)*z_(3,1)");
assert(toExternalString L_5 == "z_(1,5)*z_(2,3)*z_(3,1)");
assert(toExternalString L_6 == "z_(1,5)*z_(2,4)*z_(3,1)");
assert(toExternalString L_7 == "z_(1,4)*z_(2,3)*z_(3,2)");
assert(toExternalString L_8 == "z_(1,5)*z_(2,3)*z_(3,2)");
assert(toExternalString L_9 == "z_(1,5)*z_(2,4)*z_(3,2)");
assert(toExternalString L_10 == "z_(1,5)*z_(2,4)*z_(3,3)");
assert(toExternalString L_11 == "z_(1,4)*z_(2,3)*z_(4,2)*z_(5,1)");
assert(toExternalString L_12 == "z_(1,4)*z_(3,3)*z_(4,2)*z_(5,1)");
assert(toExternalString L_13 == "z_(2,4)*z_(3,3)*z_(4,2)*z_(5,1)");

L = antiDiagInit I;
assert(numgens L == 6);
assert(toExternalString L_0 == "z_(1,1)");
assert(toExternalString L_1 == "z_(1,2)");
assert(toExternalString L_2 == "z_(2,1)");
assert(toExternalString L_3 == "z_(1,3)*z_(2,2)");
assert(toExternalString L_4 == "z_(2,2)*z_(3,1)");
assert(toExternalString L_5 == "z_(1,4)*z_(2,3)*z_(3,2)*z_(4,1)");

L= antiDiagInit PI;
assert(numgens L == 10);
assert(toExternalString L_0 == "z_(1,1)");
assert(toExternalString L_1 == "z_(1,2)");
assert(toExternalString L_2 == "z_(2,1)");
assert(toExternalString L_3 == "z_(1,3)*z_(2,2)");
assert(toExternalString L_4 == "z_(2,2)*z_(3,1)");
assert(toExternalString L_5 == "z_(1,4)*z_(2,3)*z_(3,2)*z_(4,1)");
assert(toExternalString L_6 == "z_(1,5)*z_(2,3)*z_(3,2)*z_(4,1)");
assert(toExternalString L_7 == "z_(1,5)*z_(2,4)*z_(3,2)*z_(4,1)");
assert(toExternalString L_8 == "z_(1,5)*z_(2,4)*z_(3,3)*z_(4,1)");
assert(toExternalString L_9 == "z_(1,5)*z_(2,4)*z_(3,3)*z_(4,2)");
///

TEST ///
--rankTable--
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

assert(rankTable(w) == matrix{{0, 1, 1, 1, 1, 1}, {1, 2, 2, 2, 2, 2}, {1, 2, 2, 2, 2, 3}, {1, 2, 3, 3, 3, 4}, {1, 2, 3, 3, 4, 5}, {1, 2, 3, 4, 5, 6}} );
assert(rankTable(I) == matrix{{0, 0, 1, 1, 1}, {0, 1, 1, 2, 2}, {1, 1, 2, 3, 3}, {1, 2, 3, 3, 4}, {1, 2, 3, 4, 5}} );
assert(rankTable(PI) == matrix{{0, 0, 1, 1, 1}, {0, 1, 1, 2, 2}, {1, 1, 2, 3, 3}, {1, 2, 3, 3, 3}, {1, 2, 3, 4, 4}} );
///

TEST ///
--rotheDiagram--
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

assert(rotheDiagram(w) == {(1, 1), (3, 3), (3, 4), (3, 5), (5, 4)} );
assert(rotheDiagram(I) == {(1, 1), (1, 2), (2, 1), (2, 3), (3, 2), (4, 4)} );
assert(rotheDiagram(PI) == {(1, 1), (1, 2), (2, 1), (2, 3), (3, 2), (4, 4), (4, 5)} );
///

TEST ///
--augmentedRotheDiagram--
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

assert(augmentedRotheDiagram(w) == {((1, 1), 0), ((3, 3), 2), ((3, 4), 2), ((3, 5), 2), ((5, 4), 3)} );
assert(augmentedRotheDiagram(I) ==  {((1, 1), 0), ((1, 2), 0), ((2, 1), 0), ((2, 3), 1), ((3, 2), 1), ((4, 4), 3)} );
assert(augmentedRotheDiagram(PI) ==  {((1, 1), 0), ((1, 2), 0), ((2, 1), 0), ((2, 3), 1), ((3, 2), 1), ((4, 4), 3), ((4, 5),3)} );
///

TEST ///
--essentialSet--
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

assert(essentialSet(w) ==  {(1, 1), (3, 5), (5, 4)} );
assert(essentialSet(I) ==  {(1, 2), (2, 1), (2, 3), (3, 2), (4, 4)} );
assert(essentialSet(PI) == {(1, 2), (2, 1), (2, 3), (3, 2), (4, 5)} );
///

TEST ///
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

assert(augmentedEssentialSet(w) == {((1, 1), 0), ((3, 5), 2), ((5, 4), 3)} );
assert(augmentedEssentialSet(I) == {((1, 2), 0), ((2, 1), 0), ((2, 3), 1), ((3, 2), 1), ((4, 4), 3)} );
assert(augmentedEssentialSet(PI) ==  {((1, 2), 0), ((2, 1), 0), ((2, 3), 1), ((3, 2), 1), ((4, 5), 3)} );
///

TEST ///
--schubDetIdeal--
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

L = schubDetIdeal w;
assert(toExternalString L_0 == "z_(1,1)");
assert(toExternalString L_1 == "-z_(1,3)*z_(2,2)*z_(3,1)+z_(1,2)*z_(2,3)*z_(3,1)+z_(1,3)*z_(2,1)*z_(3,2)-z_(1,1)*z_(2,3)*z_(3,2)-z_(1,2)*z_(2,1)*z_(3,3)+z_(1,1)*z_(2,2)*z_(3,3)");
assert(toExternalString L_2 == "-z_(1,4)*z_(2,2)*z_(3,1)+z_(1,2)*z_(2,4)*z_(3,1)+z_(1,4)*z_(2,1)*z_(3,2)-z_(1,1)*z_(2,4)*z_(3,2)-z_(1,2)*z_(2,1)*z_(3,4)+z_(1,1)*z_(2,2)*z_(3,4)");
assert(toExternalString L_3 == "-z_(1,4)*z_(2,3)*z_(3,1)+z_(1,3)*z_(2,4)*z_(3,1)+z_(1,4)*z_(2,1)*z_(3,3)-z_(1,1)*z_(2,4)*z_(3,3)-z_(1,3)*z_(2,1)*z_(3,4)+z_(1,1)*z_(2,3)*z_(3,4)");
assert(toExternalString L_4 == "-z_(1,4)*z_(2,3)*z_(3,2)+z_(1,3)*z_(2,4)*z_(3,2)+z_(1,4)*z_(2,2)*z_(3,3)-z_(1,2)*z_(2,4)*z_(3,3)-z_(1,3)*z_(2,2)*z_(3,4)+z_(1,2)*z_(2,3)*z_(3,4)");
assert(toExternalString L_5 == "-z_(1,5)*z_(2,2)*z_(3,1)+z_(1,2)*z_(2,5)*z_(3,1)+z_(1,5)*z_(2,1)*z_(3,2)-z_(1,1)*z_(2,5)*z_(3,2)-z_(1,2)*z_(2,1)*z_(3,5)+z_(1,1)*z_(2,2)*z_(3,5)");
assert(toExternalString L_6 == "-z_(1,5)*z_(2,3)*z_(3,1)+z_(1,3)*z_(2,5)*z_(3,1)+z_(1,5)*z_(2,1)*z_(3,3)-z_(1,1)*z_(2,5)*z_(3,3)-z_(1,3)*z_(2,1)*z_(3,5)+z_(1,1)*z_(2,3)*z_(3,5)");
assert(toExternalString L_7 == "-z_(1,5)*z_(2,3)*z_(3,2)+z_(1,3)*z_(2,5)*z_(3,2)+z_(1,5)*z_(2,2)*z_(3,3)-z_(1,2)*z_(2,5)*z_(3,3)-z_(1,3)*z_(2,2)*z_(3,5)+z_(1,2)*z_(2,3)*z_(3,5)");
assert(toExternalString L_8 == "-z_(1,5)*z_(2,4)*z_(3,1)+z_(1,4)*z_(2,5)*z_(3,1)+z_(1,5)*z_(2,1)*z_(3,4)-z_(1,1)*z_(2,5)*z_(3,4)-z_(1,4)*z_(2,1)*z_(3,5)+z_(1,1)*z_(2,4)*z_(3,5)");
assert(toExternalString L_9 == "-z_(1,5)*z_(2,4)*z_(3,2)+z_(1,4)*z_(2,5)*z_(3,2)+z_(1,5)*z_(2,2)*z_(3,4)-z_(1,2)*z_(2,5)*z_(3,4)-z_(1,4)*z_(2,2)*z_(3,5)+z_(1,2)*z_(2,4)*z_(3,5)");
assert(toExternalString L_10 == "-z_(1,5)*z_(2,4)*z_(3,3)+z_(1,4)*z_(2,5)*z_(3,3)+z_(1,5)*z_(2,3)*z_(3,4)-z_(1,3)*z_(2,5)*z_(3,4)-z_(1,4)*z_(2,3)*z_(3,5)+z_(1,3)*z_(2,4)*z_(3,5)");
assert(toExternalString L_11 == "z_(1,4)*z_(2,3)*z_(3,2)*z_(4,1)-z_(1,3)*z_(2,4)*z_(3,2)*z_(4,1)-z_(1,4)*z_(2,2)*z_(3,3)*z_(4,1)+z_(1,2)*z_(2,4)*z_(3,3)*z_(4,1)+z_(1,3)*z_(2,2)*z_(3,4)*z_(4,1)-z_(1,2)*z_(2,3)*z_(3,4)*z_(4,1)-z_(1,4)*z_(2,3)*z_(3,1)*z_(4,2)+z_(1,3)*z_(2,4)*z_(3,1)*z_(4,2)+z_(1,4)*z_(2,1)*z_(3,3)*z_(4,2)-z_(1,1)*z_(2,4)*z_(3,3)*z_(4,2)-z_(1,3)*z_(2,1)*z_(3,4)*z_(4,2)+z_(1,1)*z_(2,3)*z_(3,4)*z_(4,2)+z_(1,4)*z_(2,2)*z_(3,1)*z_(4,3)-z_(1,2)*z_(2,4)*z_(3,1)*z_(4,3)-z_(1,4)*z_(2,1)*z_(3,2)*z_(4,3)+z_(1,1)*z_(2,4)*z_(3,2)*z_(4,3)+z_(1,2)*z_(2,1)*z_(3,4)*z_(4,3)-z_(1,1)*z_(2,2)*z_(3,4)*z_(4,3)-z_(1,3)*z_(2,2)*z_(3,1)*z_(4,4)+z_(1,2)*z_(2,3)*z_(3,1)*z_(4,4)+z_(1,3)*z_(2,1)*z_(3,2)*z_(4,4)-z_(1,1)*z_(2,3)*z_(3,2)*z_(4,4)-z_(1,2)*z_(2,1)*z_(3,3)*z_(4,4)+z_(1,1)*z_(2,2)*z_(3,3)*z_(4,4)");
assert(toExternalString L_12 == "z_(1,4)*z_(2,3)*z_(3,2)*z_(5,1)-z_(1,3)*z_(2,4)*z_(3,2)*z_(5,1)-z_(1,4)*z_(2,2)*z_(3,3)*z_(5,1)+z_(1,2)*z_(2,4)*z_(3,3)*z_(5,1)+z_(1,3)*z_(2,2)*z_(3,4)*z_(5,1)-z_(1,2)*z_(2,3)*z_(3,4)*z_(5,1)-z_(1,4)*z_(2,3)*z_(3,1)*z_(5,2)+z_(1,3)*z_(2,4)*z_(3,1)*z_(5,2)+z_(1,4)*z_(2,1)*z_(3,3)*z_(5,2)-z_(1,1)*z_(2,4)*z_(3,3)*z_(5,2)-z_(1,3)*z_(2,1)*z_(3,4)*z_(5,2)+z_(1,1)*z_(2,3)*z_(3,4)*z_(5,2)+z_(1,4)*z_(2,2)*z_(3,1)*z_(5,3)-z_(1,2)*z_(2,4)*z_(3,1)*z_(5,3)-z_(1,4)*z_(2,1)*z_(3,2)*z_(5,3)+z_(1,1)*z_(2,4)*z_(3,2)*z_(5,3)+z_(1,2)*z_(2,1)*z_(3,4)*z_(5,3)-z_(1,1)*z_(2,2)*z_(3,4)*z_(5,3)-z_(1,3)*z_(2,2)*z_(3,1)*z_(5,4)+z_(1,2)*z_(2,3)*z_(3,1)*z_(5,4)+z_(1,3)*z_(2,1)*z_(3,2)*z_(5,4)-z_(1,1)*z_(2,3)*z_(3,2)*z_(5,4)-z_(1,2)*z_(2,1)*z_(3,3)*z_(5,4)+z_(1,1)*z_(2,2)*z_(3,3)*z_(5,4)");
assert(toExternalString L_13 == "z_(1,4)*z_(2,3)*z_(4,2)*z_(5,1)-z_(1,3)*z_(2,4)*z_(4,2)*z_(5,1)-z_(1,4)*z_(2,2)*z_(4,3)*z_(5,1)+z_(1,2)*z_(2,4)*z_(4,3)*z_(5,1)+z_(1,3)*z_(2,2)*z_(4,4)*z_(5,1)-z_(1,2)*z_(2,3)*z_(4,4)*z_(5,1)-z_(1,4)*z_(2,3)*z_(4,1)*z_(5,2)+z_(1,3)*z_(2,4)*z_(4,1)*z_(5,2)+z_(1,4)*z_(2,1)*z_(4,3)*z_(5,2)-z_(1,1)*z_(2,4)*z_(4,3)*z_(5,2)-z_(1,3)*z_(2,1)*z_(4,4)*z_(5,2)+z_(1,1)*z_(2,3)*z_(4,4)*z_(5,2)+z_(1,4)*z_(2,2)*z_(4,1)*z_(5,3)-z_(1,2)*z_(2,4)*z_(4,1)*z_(5,3)-z_(1,4)*z_(2,1)*z_(4,2)*z_(5,3)+z_(1,1)*z_(2,4)*z_(4,2)*z_(5,3)+z_(1,2)*z_(2,1)*z_(4,4)*z_(5,3)-z_(1,1)*z_(2,2)*z_(4,4)*z_(5,3)-z_(1,3)*z_(2,2)*z_(4,1)*z_(5,4)+z_(1,2)*z_(2,3)*z_(4,1)*z_(5,4)+z_(1,3)*z_(2,1)*z_(4,2)*z_(5,4)-z_(1,1)*z_(2,3)*z_(4,2)*z_(5,4)-z_(1,2)*z_(2,1)*z_(4,3)*z_(5,4)+z_(1,1)*z_(2,2)*z_(4,3)*z_(5,4)");
assert(toExternalString L_14 == "z_(1,4)*z_(3,3)*z_(4,2)*z_(5,1)-z_(1,3)*z_(3,4)*z_(4,2)*z_(5,1)-z_(1,4)*z_(3,2)*z_(4,3)*z_(5,1)+z_(1,2)*z_(3,4)*z_(4,3)*z_(5,1)+z_(1,3)*z_(3,2)*z_(4,4)*z_(5,1)-z_(1,2)*z_(3,3)*z_(4,4)*z_(5,1)-z_(1,4)*z_(3,3)*z_(4,1)*z_(5,2)+z_(1,3)*z_(3,4)*z_(4,1)*z_(5,2)+z_(1,4)*z_(3,1)*z_(4,3)*z_(5,2)-z_(1,1)*z_(3,4)*z_(4,3)*z_(5,2)-z_(1,3)*z_(3,1)*z_(4,4)*z_(5,2)+z_(1,1)*z_(3,3)*z_(4,4)*z_(5,2)+z_(1,4)*z_(3,2)*z_(4,1)*z_(5,3)-z_(1,2)*z_(3,4)*z_(4,1)*z_(5,3)-z_(1,4)*z_(3,1)*z_(4,2)*z_(5,3)+z_(1,1)*z_(3,4)*z_(4,2)*z_(5,3)+z_(1,2)*z_(3,1)*z_(4,4)*z_(5,3)-z_(1,1)*z_(3,2)*z_(4,4)*z_(5,3)-z_(1,3)*z_(3,2)*z_(4,1)*z_(5,4)+z_(1,2)*z_(3,3)*z_(4,1)*z_(5,4)+z_(1,3)*z_(3,1)*z_(4,2)*z_(5,4)-z_(1,1)*z_(3,3)*z_(4,2)*z_(5,4)-z_(1,2)*z_(3,1)*z_(4,3)*z_(5,4)+z_(1,1)*z_(3,2)*z_(4,3)*z_(5,4)");
assert(toExternalString L_15 == "z_(2,4)*z_(3,3)*z_(4,2)*z_(5,1)-z_(2,3)*z_(3,4)*z_(4,2)*z_(5,1)-z_(2,4)*z_(3,2)*z_(4,3)*z_(5,1)+z_(2,2)*z_(3,4)*z_(4,3)*z_(5,1)+z_(2,3)*z_(3,2)*z_(4,4)*z_(5,1)-z_(2,2)*z_(3,3)*z_(4,4)*z_(5,1)-z_(2,4)*z_(3,3)*z_(4,1)*z_(5,2)+z_(2,3)*z_(3,4)*z_(4,1)*z_(5,2)+z_(2,4)*z_(3,1)*z_(4,3)*z_(5,2)-z_(2,1)*z_(3,4)*z_(4,3)*z_(5,2)-z_(2,3)*z_(3,1)*z_(4,4)*z_(5,2)+z_(2,1)*z_(3,3)*z_(4,4)*z_(5,2)+z_(2,4)*z_(3,2)*z_(4,1)*z_(5,3)-z_(2,2)*z_(3,4)*z_(4,1)*z_(5,3)-z_(2,4)*z_(3,1)*z_(4,2)*z_(5,3)+z_(2,1)*z_(3,4)*z_(4,2)*z_(5,3)+z_(2,2)*z_(3,1)*z_(4,4)*z_(5,3)-z_(2,1)*z_(3,2)*z_(4,4)*z_(5,3)-z_(2,3)*z_(3,2)*z_(4,1)*z_(5,4)+z_(2,2)*z_(3,3)*z_(4,1)*z_(5,4)+z_(2,3)*z_(3,1)*z_(4,2)*z_(5,4)-z_(2,1)*z_(3,3)*z_(4,2)*z_(5,4)-z_(2,2)*z_(3,1)*z_(4,3)*z_(5,4)+z_(2,1)*z_(3,2)*z_(4,3)*z_(5,4)");


L = schubDetIdeal I;
assert(toExternalString L_0 == "z_(1,1)");
assert(toExternalString L_1 == "z_(1,2)");
assert(toExternalString L_2 == "z_(2,1)");
assert(toExternalString L_3 == "-z_(1,2)*z_(2,1)+z_(1,1)*z_(2,2)");
assert(toExternalString L_4 == "-z_(1,3)*z_(2,1)+z_(1,1)*z_(2,3)");
assert(toExternalString L_5 == "-z_(1,3)*z_(2,2)+z_(1,2)*z_(2,3)");
assert(toExternalString L_6 == "-z_(1,2)*z_(3,1)+z_(1,1)*z_(3,2)");
assert(toExternalString L_7 == "-z_(2,2)*z_(3,1)+z_(2,1)*z_(3,2)");
assert(toExternalString L_8 == "z_(1,4)*z_(2,3)*z_(3,2)*z_(4,1)-z_(1,3)*z_(2,4)*z_(3,2)*z_(4,1)-z_(1,4)*z_(2,2)*z_(3,3)*z_(4,1)+z_(1,2)*z_(2,4)*z_(3,3)*z_(4,1)+z_(1,3)*z_(2,2)*z_(3,4)*z_(4,1)-z_(1,2)*z_(2,3)*z_(3,4)*z_(4,1)-z_(1,4)*z_(2,3)*z_(3,1)*z_(4,2)+z_(1,3)*z_(2,4)*z_(3,1)*z_(4,2)+z_(1,4)*z_(2,1)*z_(3,3)*z_(4,2)-z_(1,1)*z_(2,4)*z_(3,3)*z_(4,2)-z_(1,3)*z_(2,1)*z_(3,4)*z_(4,2)+z_(1,1)*z_(2,3)*z_(3,4)*z_(4,2)+z_(1,4)*z_(2,2)*z_(3,1)*z_(4,3)-z_(1,2)*z_(2,4)*z_(3,1)*z_(4,3)-z_(1,4)*z_(2,1)*z_(3,2)*z_(4,3)+z_(1,1)*z_(2,4)*z_(3,2)*z_(4,3)+z_(1,2)*z_(2,1)*z_(3,4)*z_(4,3)-z_(1,1)*z_(2,2)*z_(3,4)*z_(4,3)-z_(1,3)*z_(2,2)*z_(3,1)*z_(4,4)+z_(1,2)*z_(2,3)*z_(3,1)*z_(4,4)+z_(1,3)*z_(2,1)*z_(3,2)*z_(4,4)-z_(1,1)*z_(2,3)*z_(3,2)*z_(4,4)-z_(1,2)*z_(2,1)*z_(3,3)*z_(4,4)+z_(1,1)*z_(2,2)*z_(3,3)*z_(4,4)");


L = schubDetIdeal PI;
assert(numgens L == 13);
assert(toExternalString L_0 == "z_(1,1)");
assert(toExternalString L_1 == "z_(1,2)");
assert(toExternalString L_2 == "z_(2,1)");
assert(toExternalString L_3 == "-z_(1,2)*z_(2,1)+z_(1,1)*z_(2,2)");
assert(toExternalString L_4 == "-z_(1,3)*z_(2,1)+z_(1,1)*z_(2,3)");
assert(toExternalString L_5 == "-z_(1,3)*z_(2,2)+z_(1,2)*z_(2,3)");
assert(toExternalString L_6 == "-z_(1,2)*z_(3,1)+z_(1,1)*z_(3,2)");
assert(toExternalString L_7 == "-z_(2,2)*z_(3,1)+z_(2,1)*z_(3,2)");
assert(toExternalString L_8 == "z_(1,4)*z_(2,3)*z_(3,2)*z_(4,1)-z_(1,3)*z_(2,4)*z_(3,2)*z_(4,1)-z_(1,4)*z_(2,2)*z_(3,3)*z_(4,1)+z_(1,2)*z_(2,4)*z_(3,3)*z_(4,1)+z_(1,3)*z_(2,2)*z_(3,4)*z_(4,1)-z_(1,2)*z_(2,3)*z_(3,4)*z_(4,1)-z_(1,4)*z_(2,3)*z_(3,1)*z_(4,2)+z_(1,3)*z_(2,4)*z_(3,1)*z_(4,2)+z_(1,4)*z_(2,1)*z_(3,3)*z_(4,2)-z_(1,1)*z_(2,4)*z_(3,3)*z_(4,2)-z_(1,3)*z_(2,1)*z_(3,4)*z_(4,2)+z_(1,1)*z_(2,3)*z_(3,4)*z_(4,2)+z_(1,4)*z_(2,2)*z_(3,1)*z_(4,3)-z_(1,2)*z_(2,4)*z_(3,1)*z_(4,3)-z_(1,4)*z_(2,1)*z_(3,2)*z_(4,3)+z_(1,1)*z_(2,4)*z_(3,2)*z_(4,3)+z_(1,2)*z_(2,1)*z_(3,4)*z_(4,3)-z_(1,1)*z_(2,2)*z_(3,4)*z_(4,3)-z_(1,3)*z_(2,2)*z_(3,1)*z_(4,4)+z_(1,2)*z_(2,3)*z_(3,1)*z_(4,4)+z_(1,3)*z_(2,1)*z_(3,2)*z_(4,4)-z_(1,1)*z_(2,3)*z_(3,2)*z_(4,4)-z_(1,2)*z_(2,1)*z_(3,3)*z_(4,4)+z_(1,1)*z_(2,2)*z_(3,3)*z_(4,4)");
assert(toExternalString L_9 == "z_(1,5)*z_(2,3)*z_(3,2)*z_(4,1)-z_(1,3)*z_(2,5)*z_(3,2)*z_(4,1)-z_(1,5)*z_(2,2)*z_(3,3)*z_(4,1)+z_(1,2)*z_(2,5)*z_(3,3)*z_(4,1)+z_(1,3)*z_(2,2)*z_(3,5)*z_(4,1)-z_(1,2)*z_(2,3)*z_(3,5)*z_(4,1)-z_(1,5)*z_(2,3)*z_(3,1)*z_(4,2)+z_(1,3)*z_(2,5)*z_(3,1)*z_(4,2)+z_(1,5)*z_(2,1)*z_(3,3)*z_(4,2)-z_(1,1)*z_(2,5)*z_(3,3)*z_(4,2)-z_(1,3)*z_(2,1)*z_(3,5)*z_(4,2)+z_(1,1)*z_(2,3)*z_(3,5)*z_(4,2)+z_(1,5)*z_(2,2)*z_(3,1)*z_(4,3)-z_(1,2)*z_(2,5)*z_(3,1)*z_(4,3)-z_(1,5)*z_(2,1)*z_(3,2)*z_(4,3)+z_(1,1)*z_(2,5)*z_(3,2)*z_(4,3)+z_(1,2)*z_(2,1)*z_(3,5)*z_(4,3)-z_(1,1)*z_(2,2)*z_(3,5)*z_(4,3)-z_(1,3)*z_(2,2)*z_(3,1)*z_(4,5)+z_(1,2)*z_(2,3)*z_(3,1)*z_(4,5)+z_(1,3)*z_(2,1)*z_(3,2)*z_(4,5)-z_(1,1)*z_(2,3)*z_(3,2)*z_(4,5)-z_(1,2)*z_(2,1)*z_(3,3)*z_(4,5)+z_(1,1)*z_(2,2)*z_(3,3)*z_(4,5)");
assert(toExternalString L_10 == "z_(1,5)*z_(2,4)*z_(3,2)*z_(4,1)-z_(1,4)*z_(2,5)*z_(3,2)*z_(4,1)-z_(1,5)*z_(2,2)*z_(3,4)*z_(4,1)+z_(1,2)*z_(2,5)*z_(3,4)*z_(4,1)+z_(1,4)*z_(2,2)*z_(3,5)*z_(4,1)-z_(1,2)*z_(2,4)*z_(3,5)*z_(4,1)-z_(1,5)*z_(2,4)*z_(3,1)*z_(4,2)+z_(1,4)*z_(2,5)*z_(3,1)*z_(4,2)+z_(1,5)*z_(2,1)*z_(3,4)*z_(4,2)-z_(1,1)*z_(2,5)*z_(3,4)*z_(4,2)-z_(1,4)*z_(2,1)*z_(3,5)*z_(4,2)+z_(1,1)*z_(2,4)*z_(3,5)*z_(4,2)+z_(1,5)*z_(2,2)*z_(3,1)*z_(4,4)-z_(1,2)*z_(2,5)*z_(3,1)*z_(4,4)-z_(1,5)*z_(2,1)*z_(3,2)*z_(4,4)+z_(1,1)*z_(2,5)*z_(3,2)*z_(4,4)+z_(1,2)*z_(2,1)*z_(3,5)*z_(4,4)-z_(1,1)*z_(2,2)*z_(3,5)*z_(4,4)-z_(1,4)*z_(2,2)*z_(3,1)*z_(4,5)+z_(1,2)*z_(2,4)*z_(3,1)*z_(4,5)+z_(1,4)*z_(2,1)*z_(3,2)*z_(4,5)-z_(1,1)*z_(2,4)*z_(3,2)*z_(4,5)-z_(1,2)*z_(2,1)*z_(3,4)*z_(4,5)+z_(1,1)*z_(2,2)*z_(3,4)*z_(4,5)");
assert(toExternalString L_11 == "z_(1,5)*z_(2,4)*z_(3,3)*z_(4,1)-z_(1,4)*z_(2,5)*z_(3,3)*z_(4,1)-z_(1,5)*z_(2,3)*z_(3,4)*z_(4,1)+z_(1,3)*z_(2,5)*z_(3,4)*z_(4,1)+z_(1,4)*z_(2,3)*z_(3,5)*z_(4,1)-z_(1,3)*z_(2,4)*z_(3,5)*z_(4,1)-z_(1,5)*z_(2,4)*z_(3,1)*z_(4,3)+z_(1,4)*z_(2,5)*z_(3,1)*z_(4,3)+z_(1,5)*z_(2,1)*z_(3,4)*z_(4,3)-z_(1,1)*z_(2,5)*z_(3,4)*z_(4,3)-z_(1,4)*z_(2,1)*z_(3,5)*z_(4,3)+z_(1,1)*z_(2,4)*z_(3,5)*z_(4,3)+z_(1,5)*z_(2,3)*z_(3,1)*z_(4,4)-z_(1,3)*z_(2,5)*z_(3,1)*z_(4,4)-z_(1,5)*z_(2,1)*z_(3,3)*z_(4,4)+z_(1,1)*z_(2,5)*z_(3,3)*z_(4,4)+z_(1,3)*z_(2,1)*z_(3,5)*z_(4,4)-z_(1,1)*z_(2,3)*z_(3,5)*z_(4,4)-z_(1,4)*z_(2,3)*z_(3,1)*z_(4,5)+z_(1,3)*z_(2,4)*z_(3,1)*z_(4,5)+z_(1,4)*z_(2,1)*z_(3,3)*z_(4,5)-z_(1,1)*z_(2,4)*z_(3,3)*z_(4,5)-z_(1,3)*z_(2,1)*z_(3,4)*z_(4,5)+z_(1,1)*z_(2,3)*z_(3,4)*z_(4,5)");
assert(toExternalString L_12 == "z_(1,5)*z_(2,4)*z_(3,3)*z_(4,2)-z_(1,4)*z_(2,5)*z_(3,3)*z_(4,2)-z_(1,5)*z_(2,3)*z_(3,4)*z_(4,2)+z_(1,3)*z_(2,5)*z_(3,4)*z_(4,2)+z_(1,4)*z_(2,3)*z_(3,5)*z_(4,2)-z_(1,3)*z_(2,4)*z_(3,5)*z_(4,2)-z_(1,5)*z_(2,4)*z_(3,2)*z_(4,3)+z_(1,4)*z_(2,5)*z_(3,2)*z_(4,3)+z_(1,5)*z_(2,2)*z_(3,4)*z_(4,3)-z_(1,2)*z_(2,5)*z_(3,4)*z_(4,3)-z_(1,4)*z_(2,2)*z_(3,5)*z_(4,3)+z_(1,2)*z_(2,4)*z_(3,5)*z_(4,3)+z_(1,5)*z_(2,3)*z_(3,2)*z_(4,4)-z_(1,3)*z_(2,5)*z_(3,2)*z_(4,4)-z_(1,5)*z_(2,2)*z_(3,3)*z_(4,4)+z_(1,2)*z_(2,5)*z_(3,3)*z_(4,4)+z_(1,3)*z_(2,2)*z_(3,5)*z_(4,4)-z_(1,2)*z_(2,3)*z_(3,5)*z_(4,4)-z_(1,4)*z_(2,3)*z_(3,2)*z_(4,5)+z_(1,3)*z_(2,4)*z_(3,2)*z_(4,5)+z_(1,4)*z_(2,2)*z_(3,3)*z_(4,5)-z_(1,2)*z_(2,4)*z_(3,3)*z_(4,5)-z_(1,3)*z_(2,2)*z_(3,4)*z_(4,5)+z_(1,2)*z_(2,3)*z_(3,4)*z_(4,5)");
///

TEST ///
--fultonGens--
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

L = fultonGens w; 
assert(# L == 16);
assert(toExternalString L_0 == "z_(1,1)" );
assert(toExternalString L_1 == "-z_(1,3)*z_(2,2)*z_(3,1)+z_(1,2)*z_(2,3)*z_(3,1)+z_(1,3)*z_(2,1)*z_(3,2)-z_(1,1)*z_(2,3)*z_(3,2)-z_(1,2)*z_(2,1)*z_(3,3)+z_(1,1)*z_(2,2)*z_(3,3)" );
assert(toExternalString L_2 == "-z_(1,4)*z_(2,2)*z_(3,1)+z_(1,2)*z_(2,4)*z_(3,1)+z_(1,4)*z_(2,1)*z_(3,2)-z_(1,1)*z_(2,4)*z_(3,2)-z_(1,2)*z_(2,1)*z_(3,4)+z_(1,1)*z_(2,2)*z_(3,4)" );
assert(toExternalString L_3 == "-z_(1,4)*z_(2,3)*z_(3,1)+z_(1,3)*z_(2,4)*z_(3,1)+z_(1,4)*z_(2,1)*z_(3,3)-z_(1,1)*z_(2,4)*z_(3,3)-z_(1,3)*z_(2,1)*z_(3,4)+z_(1,1)*z_(2,3)*z_(3,4)" );
assert(toExternalString L_4 == "-z_(1,4)*z_(2,3)*z_(3,2)+z_(1,3)*z_(2,4)*z_(3,2)+z_(1,4)*z_(2,2)*z_(3,3)-z_(1,2)*z_(2,4)*z_(3,3)-z_(1,3)*z_(2,2)*z_(3,4)+z_(1,2)*z_(2,3)*z_(3,4)" );
assert(toExternalString L_5 == "-z_(1,5)*z_(2,2)*z_(3,1)+z_(1,2)*z_(2,5)*z_(3,1)+z_(1,5)*z_(2,1)*z_(3,2)-z_(1,1)*z_(2,5)*z_(3,2)-z_(1,2)*z_(2,1)*z_(3,5)+z_(1,1)*z_(2,2)*z_(3,5)" );
assert(toExternalString L_6 == "-z_(1,5)*z_(2,3)*z_(3,1)+z_(1,3)*z_(2,5)*z_(3,1)+z_(1,5)*z_(2,1)*z_(3,3)-z_(1,1)*z_(2,5)*z_(3,3)-z_(1,3)*z_(2,1)*z_(3,5)+z_(1,1)*z_(2,3)*z_(3,5)" );
assert(toExternalString L_7 == "-z_(1,5)*z_(2,3)*z_(3,2)+z_(1,3)*z_(2,5)*z_(3,2)+z_(1,5)*z_(2,2)*z_(3,3)-z_(1,2)*z_(2,5)*z_(3,3)-z_(1,3)*z_(2,2)*z_(3,5)+z_(1,2)*z_(2,3)*z_(3,5)" );
assert(toExternalString L_8 == "-z_(1,5)*z_(2,4)*z_(3,1)+z_(1,4)*z_(2,5)*z_(3,1)+z_(1,5)*z_(2,1)*z_(3,4)-z_(1,1)*z_(2,5)*z_(3,4)-z_(1,4)*z_(2,1)*z_(3,5)+z_(1,1)*z_(2,4)*z_(3,5)" );
assert(toExternalString L_9 == "-z_(1,5)*z_(2,4)*z_(3,2)+z_(1,4)*z_(2,5)*z_(3,2)+z_(1,5)*z_(2,2)*z_(3,4)-z_(1,2)*z_(2,5)*z_(3,4)-z_(1,4)*z_(2,2)*z_(3,5)+z_(1,2)*z_(2,4)*z_(3,5)" );
assert(toExternalString L_10 == "-z_(1,5)*z_(2,4)*z_(3,3)+z_(1,4)*z_(2,5)*z_(3,3)+z_(1,5)*z_(2,3)*z_(3,4)-z_(1,3)*z_(2,5)*z_(3,4)-z_(1,4)*z_(2,3)*z_(3,5)+z_(1,3)*z_(2,4)*z_(3,5)" );
assert(toExternalString L_11 == "z_(1,4)*z_(2,3)*z_(3,2)*z_(4,1)-z_(1,3)*z_(2,4)*z_(3,2)*z_(4,1)-z_(1,4)*z_(2,2)*z_(3,3)*z_(4,1)+z_(1,2)*z_(2,4)*z_(3,3)*z_(4,1)+z_(1,3)*z_(2,2)*z_(3,4)*z_(4,1)-z_(1,2)*z_(2,3)*z_(3,4)*z_(4,1)-z_(1,4)*z_(2,3)*z_(3,1)*z_(4,2)+z_(1,3)*z_(2,4)*z_(3,1)*z_(4,2)+z_(1,4)*z_(2,1)*z_(3,3)*z_(4,2)-z_(1,1)*z_(2,4)*z_(3,3)*z_(4,2)-z_(1,3)*z_(2,1)*z_(3,4)*z_(4,2)+z_(1,1)*z_(2,3)*z_(3,4)*z_(4,2)+z_(1,4)*z_(2,2)*z_(3,1)*z_(4,3)-z_(1,2)*z_(2,4)*z_(3,1)*z_(4,3)-z_(1,4)*z_(2,1)*z_(3,2)*z_(4,3)+z_(1,1)*z_(2,4)*z_(3,2)*z_(4,3)+z_(1,2)*z_(2,1)*z_(3,4)*z_(4,3)-z_(1,1)*z_(2,2)*z_(3,4)*z_(4,3)-z_(1,3)*z_(2,2)*z_(3,1)*z_(4,4)+z_(1,2)*z_(2,3)*z_(3,1)*z_(4,4)+z_(1,3)*z_(2,1)*z_(3,2)*z_(4,4)-z_(1,1)*z_(2,3)*z_(3,2)*z_(4,4)-z_(1,2)*z_(2,1)*z_(3,3)*z_(4,4)+z_(1,1)*z_(2,2)*z_(3,3)*z_(4,4)" );
assert(toExternalString L_12 == "z_(1,4)*z_(2,3)*z_(3,2)*z_(5,1)-z_(1,3)*z_(2,4)*z_(3,2)*z_(5,1)-z_(1,4)*z_(2,2)*z_(3,3)*z_(5,1)+z_(1,2)*z_(2,4)*z_(3,3)*z_(5,1)+z_(1,3)*z_(2,2)*z_(3,4)*z_(5,1)-z_(1,2)*z_(2,3)*z_(3,4)*z_(5,1)-z_(1,4)*z_(2,3)*z_(3,1)*z_(5,2)+z_(1,3)*z_(2,4)*z_(3,1)*z_(5,2)+z_(1,4)*z_(2,1)*z_(3,3)*z_(5,2)-z_(1,1)*z_(2,4)*z_(3,3)*z_(5,2)-z_(1,3)*z_(2,1)*z_(3,4)*z_(5,2)+z_(1,1)*z_(2,3)*z_(3,4)*z_(5,2)+z_(1,4)*z_(2,2)*z_(3,1)*z_(5,3)-z_(1,2)*z_(2,4)*z_(3,1)*z_(5,3)-z_(1,4)*z_(2,1)*z_(3,2)*z_(5,3)+z_(1,1)*z_(2,4)*z_(3,2)*z_(5,3)+z_(1,2)*z_(2,1)*z_(3,4)*z_(5,3)-z_(1,1)*z_(2,2)*z_(3,4)*z_(5,3)-z_(1,3)*z_(2,2)*z_(3,1)*z_(5,4)+z_(1,2)*z_(2,3)*z_(3,1)*z_(5,4)+z_(1,3)*z_(2,1)*z_(3,2)*z_(5,4)-z_(1,1)*z_(2,3)*z_(3,2)*z_(5,4)-z_(1,2)*z_(2,1)*z_(3,3)*z_(5,4)+z_(1,1)*z_(2,2)*z_(3,3)*z_(5,4)" );
assert(toExternalString L_13 == "z_(1,4)*z_(2,3)*z_(4,2)*z_(5,1)-z_(1,3)*z_(2,4)*z_(4,2)*z_(5,1)-z_(1,4)*z_(2,2)*z_(4,3)*z_(5,1)+z_(1,2)*z_(2,4)*z_(4,3)*z_(5,1)+z_(1,3)*z_(2,2)*z_(4,4)*z_(5,1)-z_(1,2)*z_(2,3)*z_(4,4)*z_(5,1)-z_(1,4)*z_(2,3)*z_(4,1)*z_(5,2)+z_(1,3)*z_(2,4)*z_(4,1)*z_(5,2)+z_(1,4)*z_(2,1)*z_(4,3)*z_(5,2)-z_(1,1)*z_(2,4)*z_(4,3)*z_(5,2)-z_(1,3)*z_(2,1)*z_(4,4)*z_(5,2)+z_(1,1)*z_(2,3)*z_(4,4)*z_(5,2)+z_(1,4)*z_(2,2)*z_(4,1)*z_(5,3)-z_(1,2)*z_(2,4)*z_(4,1)*z_(5,3)-z_(1,4)*z_(2,1)*z_(4,2)*z_(5,3)+z_(1,1)*z_(2,4)*z_(4,2)*z_(5,3)+z_(1,2)*z_(2,1)*z_(4,4)*z_(5,3)-z_(1,1)*z_(2,2)*z_(4,4)*z_(5,3)-z_(1,3)*z_(2,2)*z_(4,1)*z_(5,4)+z_(1,2)*z_(2,3)*z_(4,1)*z_(5,4)+z_(1,3)*z_(2,1)*z_(4,2)*z_(5,4)-z_(1,1)*z_(2,3)*z_(4,2)*z_(5,4)-z_(1,2)*z_(2,1)*z_(4,3)*z_(5,4)+z_(1,1)*z_(2,2)*z_(4,3)*z_(5,4)" );
assert(toExternalString L_14 == "z_(1,4)*z_(3,3)*z_(4,2)*z_(5,1)-z_(1,3)*z_(3,4)*z_(4,2)*z_(5,1)-z_(1,4)*z_(3,2)*z_(4,3)*z_(5,1)+z_(1,2)*z_(3,4)*z_(4,3)*z_(5,1)+z_(1,3)*z_(3,2)*z_(4,4)*z_(5,1)-z_(1,2)*z_(3,3)*z_(4,4)*z_(5,1)-z_(1,4)*z_(3,3)*z_(4,1)*z_(5,2)+z_(1,3)*z_(3,4)*z_(4,1)*z_(5,2)+z_(1,4)*z_(3,1)*z_(4,3)*z_(5,2)-z_(1,1)*z_(3,4)*z_(4,3)*z_(5,2)-z_(1,3)*z_(3,1)*z_(4,4)*z_(5,2)+z_(1,1)*z_(3,3)*z_(4,4)*z_(5,2)+z_(1,4)*z_(3,2)*z_(4,1)*z_(5,3)-z_(1,2)*z_(3,4)*z_(4,1)*z_(5,3)-z_(1,4)*z_(3,1)*z_(4,2)*z_(5,3)+z_(1,1)*z_(3,4)*z_(4,2)*z_(5,3)+z_(1,2)*z_(3,1)*z_(4,4)*z_(5,3)-z_(1,1)*z_(3,2)*z_(4,4)*z_(5,3)-z_(1,3)*z_(3,2)*z_(4,1)*z_(5,4)+z_(1,2)*z_(3,3)*z_(4,1)*z_(5,4)+z_(1,3)*z_(3,1)*z_(4,2)*z_(5,4)-z_(1,1)*z_(3,3)*z_(4,2)*z_(5,4)-z_(1,2)*z_(3,1)*z_(4,3)*z_(5,4)+z_(1,1)*z_(3,2)*z_(4,3)*z_(5,4)" );
assert(toExternalString L_15 == "z_(2,4)*z_(3,3)*z_(4,2)*z_(5,1)-z_(2,3)*z_(3,4)*z_(4,2)*z_(5,1)-z_(2,4)*z_(3,2)*z_(4,3)*z_(5,1)+z_(2,2)*z_(3,4)*z_(4,3)*z_(5,1)+z_(2,3)*z_(3,2)*z_(4,4)*z_(5,1)-z_(2,2)*z_(3,3)*z_(4,4)*z_(5,1)-z_(2,4)*z_(3,3)*z_(4,1)*z_(5,2)+z_(2,3)*z_(3,4)*z_(4,1)*z_(5,2)+z_(2,4)*z_(3,1)*z_(4,3)*z_(5,2)-z_(2,1)*z_(3,4)*z_(4,3)*z_(5,2)-z_(2,3)*z_(3,1)*z_(4,4)*z_(5,2)+z_(2,1)*z_(3,3)*z_(4,4)*z_(5,2)+z_(2,4)*z_(3,2)*z_(4,1)*z_(5,3)-z_(2,2)*z_(3,4)*z_(4,1)*z_(5,3)-z_(2,4)*z_(3,1)*z_(4,2)*z_(5,3)+z_(2,1)*z_(3,4)*z_(4,2)*z_(5,3)+z_(2,2)*z_(3,1)*z_(4,4)*z_(5,3)-z_(2,1)*z_(3,2)*z_(4,4)*z_(5,3)-z_(2,3)*z_(3,2)*z_(4,1)*z_(5,4)+z_(2,2)*z_(3,3)*z_(4,1)*z_(5,4)+z_(2,3)*z_(3,1)*z_(4,2)*z_(5,4)-z_(2,1)*z_(3,3)*z_(4,2)*z_(5,4)-z_(2,2)*z_(3,1)*z_(4,3)*z_(5,4)+z_(2,1)*z_(3,2)*z_(4,3)*z_(5,4)" );

L = fultonGens I;
assert(# L == 9); 
assert(toExternalString L_0 == "z_(1,1)" );
assert(toExternalString L_1 == "z_(1,2)" );
assert(toExternalString L_2 == "z_(2,1)" );
assert(toExternalString L_3 == "-z_(1,2)*z_(2,1)+z_(1,1)*z_(2,2)" );
assert(toExternalString L_4 == "-z_(1,3)*z_(2,1)+z_(1,1)*z_(2,3)" );
assert(toExternalString L_5 == "-z_(1,3)*z_(2,2)+z_(1,2)*z_(2,3)" );
assert(toExternalString L_6 == "-z_(1,2)*z_(3,1)+z_(1,1)*z_(3,2)" );
assert(toExternalString L_7 == "-z_(2,2)*z_(3,1)+z_(2,1)*z_(3,2)" );
assert(toExternalString L_8 == "z_(1,4)*z_(2,3)*z_(3,2)*z_(4,1)-z_(1,3)*z_(2,4)*z_(3,2)*z_(4,1)-z_(1,4)*z_(2,2)*z_(3,3)*z_(4,1)+z_(1,2)*z_(2,4)*z_(3,3)*z_(4,1)+z_(1,3)*z_(2,2)*z_(3,4)*z_(4,1)-z_(1,2)*z_(2,3)*z_(3,4)*z_(4,1)-z_(1,4)*z_(2,3)*z_(3,1)*z_(4,2)+z_(1,3)*z_(2,4)*z_(3,1)*z_(4,2)+z_(1,4)*z_(2,1)*z_(3,3)*z_(4,2)-z_(1,1)*z_(2,4)*z_(3,3)*z_(4,2)-z_(1,3)*z_(2,1)*z_(3,4)*z_(4,2)+z_(1,1)*z_(2,3)*z_(3,4)*z_(4,2)+z_(1,4)*z_(2,2)*z_(3,1)*z_(4,3)-z_(1,2)*z_(2,4)*z_(3,1)*z_(4,3)-z_(1,4)*z_(2,1)*z_(3,2)*z_(4,3)+z_(1,1)*z_(2,4)*z_(3,2)*z_(4,3)+z_(1,2)*z_(2,1)*z_(3,4)*z_(4,3)-z_(1,1)*z_(2,2)*z_(3,4)*z_(4,3)-z_(1,3)*z_(2,2)*z_(3,1)*z_(4,4)+z_(1,2)*z_(2,3)*z_(3,1)*z_(4,4)+z_(1,3)*z_(2,1)*z_(3,2)*z_(4,4)-z_(1,1)*z_(2,3)*z_(3,2)*z_(4,4)-z_(1,2)*z_(2,1)*z_(3,3)*z_(4,4)+z_(1,1)*z_(2,2)*z_(3,3)*z_(4,4)" );

L = fultonGens PI; 
assert(# L == 13);
assert(toExternalString L_0 == "z_(1,1)" );
assert(toExternalString L_1 == "z_(1,2)" );
assert(toExternalString L_2 == "z_(2,1)" );
assert(toExternalString L_3 == "-z_(1,2)*z_(2,1)+z_(1,1)*z_(2,2)" );
assert(toExternalString L_4 == "-z_(1,3)*z_(2,1)+z_(1,1)*z_(2,3)" );
assert(toExternalString L_5 == "-z_(1,3)*z_(2,2)+z_(1,2)*z_(2,3)" );
assert(toExternalString L_6 == "-z_(1,2)*z_(3,1)+z_(1,1)*z_(3,2)" );
assert(toExternalString L_7 == "-z_(2,2)*z_(3,1)+z_(2,1)*z_(3,2)" );
assert(toExternalString L_8 == "z_(1,4)*z_(2,3)*z_(3,2)*z_(4,1)-z_(1,3)*z_(2,4)*z_(3,2)*z_(4,1)-z_(1,4)*z_(2,2)*z_(3,3)*z_(4,1)+z_(1,2)*z_(2,4)*z_(3,3)*z_(4,1)+z_(1,3)*z_(2,2)*z_(3,4)*z_(4,1)-z_(1,2)*z_(2,3)*z_(3,4)*z_(4,1)-z_(1,4)*z_(2,3)*z_(3,1)*z_(4,2)+z_(1,3)*z_(2,4)*z_(3,1)*z_(4,2)+z_(1,4)*z_(2,1)*z_(3,3)*z_(4,2)-z_(1,1)*z_(2,4)*z_(3,3)*z_(4,2)-z_(1,3)*z_(2,1)*z_(3,4)*z_(4,2)+z_(1,1)*z_(2,3)*z_(3,4)*z_(4,2)+z_(1,4)*z_(2,2)*z_(3,1)*z_(4,3)-z_(1,2)*z_(2,4)*z_(3,1)*z_(4,3)-z_(1,4)*z_(2,1)*z_(3,2)*z_(4,3)+z_(1,1)*z_(2,4)*z_(3,2)*z_(4,3)+z_(1,2)*z_(2,1)*z_(3,4)*z_(4,3)-z_(1,1)*z_(2,2)*z_(3,4)*z_(4,3)-z_(1,3)*z_(2,2)*z_(3,1)*z_(4,4)+z_(1,2)*z_(2,3)*z_(3,1)*z_(4,4)+z_(1,3)*z_(2,1)*z_(3,2)*z_(4,4)-z_(1,1)*z_(2,3)*z_(3,2)*z_(4,4)-z_(1,2)*z_(2,1)*z_(3,3)*z_(4,4)+z_(1,1)*z_(2,2)*z_(3,3)*z_(4,4)" );
assert(toExternalString L_9 == "z_(1,5)*z_(2,3)*z_(3,2)*z_(4,1)-z_(1,3)*z_(2,5)*z_(3,2)*z_(4,1)-z_(1,5)*z_(2,2)*z_(3,3)*z_(4,1)+z_(1,2)*z_(2,5)*z_(3,3)*z_(4,1)+z_(1,3)*z_(2,2)*z_(3,5)*z_(4,1)-z_(1,2)*z_(2,3)*z_(3,5)*z_(4,1)-z_(1,5)*z_(2,3)*z_(3,1)*z_(4,2)+z_(1,3)*z_(2,5)*z_(3,1)*z_(4,2)+z_(1,5)*z_(2,1)*z_(3,3)*z_(4,2)-z_(1,1)*z_(2,5)*z_(3,3)*z_(4,2)-z_(1,3)*z_(2,1)*z_(3,5)*z_(4,2)+z_(1,1)*z_(2,3)*z_(3,5)*z_(4,2)+z_(1,5)*z_(2,2)*z_(3,1)*z_(4,3)-z_(1,2)*z_(2,5)*z_(3,1)*z_(4,3)-z_(1,5)*z_(2,1)*z_(3,2)*z_(4,3)+z_(1,1)*z_(2,5)*z_(3,2)*z_(4,3)+z_(1,2)*z_(2,1)*z_(3,5)*z_(4,3)-z_(1,1)*z_(2,2)*z_(3,5)*z_(4,3)-z_(1,3)*z_(2,2)*z_(3,1)*z_(4,5)+z_(1,2)*z_(2,3)*z_(3,1)*z_(4,5)+z_(1,3)*z_(2,1)*z_(3,2)*z_(4,5)-z_(1,1)*z_(2,3)*z_(3,2)*z_(4,5)-z_(1,2)*z_(2,1)*z_(3,3)*z_(4,5)+z_(1,1)*z_(2,2)*z_(3,3)*z_(4,5)" );
assert(toExternalString L_10 == "z_(1,5)*z_(2,4)*z_(3,2)*z_(4,1)-z_(1,4)*z_(2,5)*z_(3,2)*z_(4,1)-z_(1,5)*z_(2,2)*z_(3,4)*z_(4,1)+z_(1,2)*z_(2,5)*z_(3,4)*z_(4,1)+z_(1,4)*z_(2,2)*z_(3,5)*z_(4,1)-z_(1,2)*z_(2,4)*z_(3,5)*z_(4,1)-z_(1,5)*z_(2,4)*z_(3,1)*z_(4,2)+z_(1,4)*z_(2,5)*z_(3,1)*z_(4,2)+z_(1,5)*z_(2,1)*z_(3,4)*z_(4,2)-z_(1,1)*z_(2,5)*z_(3,4)*z_(4,2)-z_(1,4)*z_(2,1)*z_(3,5)*z_(4,2)+z_(1,1)*z_(2,4)*z_(3,5)*z_(4,2)+z_(1,5)*z_(2,2)*z_(3,1)*z_(4,4)-z_(1,2)*z_(2,5)*z_(3,1)*z_(4,4)-z_(1,5)*z_(2,1)*z_(3,2)*z_(4,4)+z_(1,1)*z_(2,5)*z_(3,2)*z_(4,4)+z_(1,2)*z_(2,1)*z_(3,5)*z_(4,4)-z_(1,1)*z_(2,2)*z_(3,5)*z_(4,4)-z_(1,4)*z_(2,2)*z_(3,1)*z_(4,5)+z_(1,2)*z_(2,4)*z_(3,1)*z_(4,5)+z_(1,4)*z_(2,1)*z_(3,2)*z_(4,5)-z_(1,1)*z_(2,4)*z_(3,2)*z_(4,5)-z_(1,2)*z_(2,1)*z_(3,4)*z_(4,5)+z_(1,1)*z_(2,2)*z_(3,4)*z_(4,5)" );
assert(toExternalString L_11 == "z_(1,5)*z_(2,4)*z_(3,3)*z_(4,1)-z_(1,4)*z_(2,5)*z_(3,3)*z_(4,1)-z_(1,5)*z_(2,3)*z_(3,4)*z_(4,1)+z_(1,3)*z_(2,5)*z_(3,4)*z_(4,1)+z_(1,4)*z_(2,3)*z_(3,5)*z_(4,1)-z_(1,3)*z_(2,4)*z_(3,5)*z_(4,1)-z_(1,5)*z_(2,4)*z_(3,1)*z_(4,3)+z_(1,4)*z_(2,5)*z_(3,1)*z_(4,3)+z_(1,5)*z_(2,1)*z_(3,4)*z_(4,3)-z_(1,1)*z_(2,5)*z_(3,4)*z_(4,3)-z_(1,4)*z_(2,1)*z_(3,5)*z_(4,3)+z_(1,1)*z_(2,4)*z_(3,5)*z_(4,3)+z_(1,5)*z_(2,3)*z_(3,1)*z_(4,4)-z_(1,3)*z_(2,5)*z_(3,1)*z_(4,4)-z_(1,5)*z_(2,1)*z_(3,3)*z_(4,4)+z_(1,1)*z_(2,5)*z_(3,3)*z_(4,4)+z_(1,3)*z_(2,1)*z_(3,5)*z_(4,4)-z_(1,1)*z_(2,3)*z_(3,5)*z_(4,4)-z_(1,4)*z_(2,3)*z_(3,1)*z_(4,5)+z_(1,3)*z_(2,4)*z_(3,1)*z_(4,5)+z_(1,4)*z_(2,1)*z_(3,3)*z_(4,5)-z_(1,1)*z_(2,4)*z_(3,3)*z_(4,5)-z_(1,3)*z_(2,1)*z_(3,4)*z_(4,5)+z_(1,1)*z_(2,3)*z_(3,4)*z_(4,5)" );
assert(toExternalString L_12 == "z_(1,5)*z_(2,4)*z_(3,3)*z_(4,2)-z_(1,4)*z_(2,5)*z_(3,3)*z_(4,2)-z_(1,5)*z_(2,3)*z_(3,4)*z_(4,2)+z_(1,3)*z_(2,5)*z_(3,4)*z_(4,2)+z_(1,4)*z_(2,3)*z_(3,5)*z_(4,2)-z_(1,3)*z_(2,4)*z_(3,5)*z_(4,2)-z_(1,5)*z_(2,4)*z_(3,2)*z_(4,3)+z_(1,4)*z_(2,5)*z_(3,2)*z_(4,3)+z_(1,5)*z_(2,2)*z_(3,4)*z_(4,3)-z_(1,2)*z_(2,5)*z_(3,4)*z_(4,3)-z_(1,4)*z_(2,2)*z_(3,5)*z_(4,3)+z_(1,2)*z_(2,4)*z_(3,5)*z_(4,3)+z_(1,5)*z_(2,3)*z_(3,2)*z_(4,4)-z_(1,3)*z_(2,5)*z_(3,2)*z_(4,4)-z_(1,5)*z_(2,2)*z_(3,3)*z_(4,4)+z_(1,2)*z_(2,5)*z_(3,3)*z_(4,4)+z_(1,3)*z_(2,2)*z_(3,5)*z_(4,4)-z_(1,2)*z_(2,3)*z_(3,5)*z_(4,4)-z_(1,4)*z_(2,3)*z_(3,2)*z_(4,5)+z_(1,3)*z_(2,4)*z_(3,2)*z_(4,5)+z_(1,4)*z_(2,2)*z_(3,3)*z_(4,5)-z_(1,2)*z_(2,4)*z_(3,3)*z_(4,5)-z_(1,3)*z_(2,2)*z_(3,4)*z_(4,5)+z_(1,2)*z_(2,3)*z_(3,4)*z_(4,5)" );
///

TEST ///
--diagLexInitSE--
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

L = diagLexInitSE w; 
assert(numgens L == 17);
assert(toExternalString L_0 == "z_(5,4)*z_(4,3)*z_(3,2)*z_(2,1)" );
assert(toExternalString L_1 == "z_(5,4)*z_(4,3)*z_(3,5)*z_(3,1)*z_(2,2)*z_(1,4)" );
assert(toExternalString L_2 == "z_(3,5)*z_(2,1)*z_(1,4)" );
assert(toExternalString L_3 == "z_(3,5)*z_(2,4)*z_(1,3)" );
assert(toExternalString L_4 == "z_(5,4)*z_(4,3)*z_(3,5)*z_(3,1)*z_(2,2)*z_(1,3)" );
assert(toExternalString L_5 == "z_(5,4)*z_(4,3)*z_(3,4)*z_(3,1)*z_(2,2)*z_(1,3)" );
assert(toExternalString L_6 == "z_(3,5)*z_(2,1)*z_(1,3)" );
assert(toExternalString L_7 == "z_(3,4)*z_(2,1)*z_(1,3)" );
assert(toExternalString L_8 == "z_(5,4)*z_(4,3)*z_(3,1)*z_(1,2)" );
assert(toExternalString L_9 == "z_(3,5)*z_(2,4)*z_(1,2)" );
assert(toExternalString L_10 == "z_(3,5)*z_(2,3)*z_(1,2)" );
assert(toExternalString L_11 == "z_(3,4)*z_(2,3)*z_(1,2)" );
assert(toExternalString L_12 == "z_(5,4)*z_(4,3)*z_(2,1)*z_(1,2)" );
assert(toExternalString L_13 == "z_(3,5)*z_(2,1)*z_(1,2)" );
assert(toExternalString L_14 == "z_(3,4)*z_(2,1)*z_(1,2)" );
assert(toExternalString L_15 == "z_(3,3)*z_(2,1)*z_(1,2)" );
assert(toExternalString L_16 == "z_(1,1)" );

L = diagLexInitSE I; 
assert(numgens L == 7);
assert(toExternalString L_0 == "z_(3,1)*z_(2,2)" );
assert(toExternalString L_1 == "z_(2,1)" );
assert(toExternalString L_2 == "z_(4,1)*z_(3,3)*z_(2,2)^2*z_(1,4)" );
assert(toExternalString L_3 == "z_(4,2)*z_(3,1)*z_(2,4)*z_(1,3)" );
assert(toExternalString L_4 == "z_(2,2)*z_(1,3)" );
assert(toExternalString L_5 == "z_(1,2)" );
assert(toExternalString L_6 == "z_(1,1)" );

L = diagLexInitSE PI; 
assert(numgens L == 16);
assert(toExternalString L_0 == "z_(3,1)*z_(2,2)" );
assert(toExternalString L_1 == "z_(2,1)" );
assert(toExternalString L_2 == "z_(4,1)*z_(3,3)*z_(2,2)^2*z_(1,5)" );
assert(toExternalString L_3 == "z_(4,2)*z_(3,1)*z_(2,5)*z_(1,4)" );
assert(toExternalString L_4 == "z_(4,5)*z_(3,3)*z_(2,2)*z_(1,4)" );
assert(toExternalString L_5 == "z_(4,1)*z_(3,5)*z_(2,3)*z_(2,2)*z_(1,4)" );
assert(toExternalString L_6 == "z_(4,1)*z_(3,5)*z_(2,2)^2*z_(1,4)" );
assert(toExternalString L_7 == "z_(4,1)*z_(3,3)*z_(2,2)^2*z_(1,4)" );
assert(toExternalString L_8 == "z_(4,2)*z_(3,1)*z_(2,5)*z_(1,3)" );
assert(toExternalString L_9 == "z_(4,5)*z_(3,1)*z_(2,4)*z_(1,3)" );
assert(toExternalString L_10 == "z_(4,2)*z_(3,1)*z_(2,4)*z_(1,3)" );
assert(toExternalString L_11 == "z_(4,5)*z_(4,1)*z_(3,5)*z_(3,2)*z_(2,4)*z_(2,3)*z_(1,3)" );
assert(toExternalString L_12 == "z_(2,2)*z_(1,3)" );
assert(toExternalString L_13 == "z_(4,5)*z_(3,2)*z_(2,4)*z_(1,3)^2" );
assert(toExternalString L_14 == "z_(1,2)" );
assert(toExternalString L_15 == "z_(1,1)" );
///

TEST ///
--diagLexInitNW--
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

L = diagLexInitNW w; 
assert(numgens L == 17);
assert(toExternalString L_0 == "z_(1,1)" );
assert(toExternalString L_1 == "z_(1,2)*z_(2,1)*z_(3,3)" );
assert(toExternalString L_2 == "z_(1,2)*z_(2,1)*z_(3,4)" );
assert(toExternalString L_3 == "z_(1,3)*z_(2,1)*z_(3,4)" );
assert(toExternalString L_4 == "z_(1,2)*z_(2,3)*z_(3,4)" );
assert(toExternalString L_5 == "z_(1,2)*z_(2,1)*z_(3,5)" );
assert(toExternalString L_6 == "z_(1,3)*z_(2,1)*z_(3,5)" );
assert(toExternalString L_7 == "z_(1,4)*z_(2,1)*z_(3,5)" );
assert(toExternalString L_8 == "z_(1,2)*z_(2,3)*z_(3,5)" );
assert(toExternalString L_9 == "z_(1,2)*z_(2,4)*z_(3,5)" );
assert(toExternalString L_10 == "z_(1,3)*z_(2,4)*z_(3,5)" );
assert(toExternalString L_11 == "z_(1,2)*z_(2,1)*z_(4,3)*z_(5,4)" );
assert(toExternalString L_12 == "z_(1,2)*z_(3,1)*z_(4,3)*z_(5,4)" );
assert(toExternalString L_13 == "z_(2,1)*z_(3,2)*z_(4,3)*z_(5,4)" );
assert(toExternalString L_14 == "z_(1,3)*z_(2,2)*z_(3,1)*z_(3,4)*z_(4,3)*z_(5,4)" );
assert(toExternalString L_15 == "z_(1,3)*z_(2,2)*z_(3,1)*z_(3,5)*z_(4,3)*z_(5,4)" );
assert(toExternalString L_16 == "z_(1,4)*z_(2,2)*z_(3,1)*z_(3,5)*z_(4,3)*z_(5,4)" );

L = diagLexInitNW I; 
assert(numgens L == 7);
assert(toExternalString L_0 == "z_(1,1)" );
assert(toExternalString L_1 == "z_(1,2)" );
assert(toExternalString L_2 == "z_(2,1)" );
assert(toExternalString L_3 == "z_(1,3)*z_(2,2)" );
assert(toExternalString L_4 == "z_(2,2)*z_(3,1)" );
assert(toExternalString L_5 == "z_(1,4)*z_(2,2)^2*z_(3,3)*z_(4,1)" );
assert(toExternalString L_6 == "z_(1,3)*z_(2,4)*z_(3,1)*z_(4,2)" );

L = diagLexInitNW PI; 
assert(numgens L == 16);
assert(toExternalString L_0 == "z_(1,1)" );
assert(toExternalString L_1 == "z_(1,2)" );
assert(toExternalString L_2 == "z_(2,1)" );
assert(toExternalString L_3 == "z_(1,3)*z_(2,2)" );
assert(toExternalString L_4 == "z_(2,2)*z_(3,1)" );
assert(toExternalString L_5 == "z_(1,4)*z_(2,2)^2*z_(3,3)*z_(4,1)" );
assert(toExternalString L_6 == "z_(1,5)*z_(2,2)^2*z_(3,3)*z_(4,1)" );
assert(toExternalString L_7 == "z_(1,4)*z_(2,2)*z_(2,5)*z_(3,3)*z_(4,1)" );
assert(toExternalString L_8 == "z_(1,4)*z_(2,2)*z_(3,5)*z_(4,1)" );
assert(toExternalString L_9 == "z_(1,3)*z_(2,4)*z_(3,1)*z_(4,2)" );
assert(toExternalString L_10 == "z_(1,3)*z_(2,5)*z_(3,1)*z_(4,2)" );
assert(toExternalString L_11 == "z_(1,4)*z_(2,5)*z_(3,1)^2*z_(4,2)" );
assert(toExternalString L_12 == "z_(1,4)*z_(2,3)*z_(2,5)*z_(3,1)*z_(3,5)*z_(4,2)" );
assert(toExternalString L_13 == "z_(1,3)*z_(2,4)*z_(3,1)*z_(4,5)" );
assert(toExternalString L_14 == "z_(1,3)*z_(2,4)*z_(3,2)*z_(4,5)" );
assert(toExternalString L_15 == "z_(1,4)*z_(2,2)^2*z_(3,3)*z_(4,5)" );
///

TEST ///
--diagRevLexInit--
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

L = diagRevLexInit w; 
assert(numgens L == 17);
assert(toExternalString L_0 == "z_(1,1)" );
assert(toExternalString L_1 == "z_(1,3)*z_(2,4)*z_(3,5)" );
assert(toExternalString L_2 == "z_(1,2)*z_(2,4)*z_(3,5)" );
assert(toExternalString L_3 == "z_(1,2)*z_(2,3)*z_(3,5)" );
assert(toExternalString L_4 == "z_(1,4)*z_(2,1)*z_(3,5)" );
assert(toExternalString L_5 == "z_(1,3)*z_(2,1)*z_(3,5)" );
assert(toExternalString L_6 == "z_(1,2)*z_(2,1)*z_(3,5)" );
assert(toExternalString L_7 == "z_(1,2)*z_(2,3)*z_(3,4)" );
assert(toExternalString L_8 == "z_(1,3)*z_(2,1)*z_(3,4)" );
assert(toExternalString L_9 == "z_(1,2)*z_(2,1)*z_(3,4)" );
assert(toExternalString L_10 == "z_(1,2)*z_(2,1)*z_(3,3)" );
assert(toExternalString L_11 == "z_(1,2)*z_(2,1)*z_(4,3)*z_(5,4)" );
assert(toExternalString L_12 == "z_(2,1)*z_(3,2)*z_(4,3)*z_(5,4)" );
assert(toExternalString L_13 == "z_(1,2)*z_(3,1)*z_(4,3)*z_(5,4)" );
assert(toExternalString L_14 == "z_(1,4)*z_(2,2)*z_(3,5)*z_(3,1)*z_(4,3)*z_(5,4)" );
assert(toExternalString L_15 == "z_(1,3)*z_(2,2)*z_(3,5)*z_(3,1)*z_(4,3)*z_(5,4)" );
assert(toExternalString L_16 == "z_(1,3)*z_(2,2)*z_(3,4)*z_(3,1)*z_(4,3)*z_(5,4)" );

L = diagRevLexInit I; 
assert(numgens L == 7);
assert(toExternalString L_0 == "z_(1,2)" );
assert(toExternalString L_1 == "z_(1,1)" );
assert(toExternalString L_2 == "z_(1,3)*z_(2,2)" );
assert(toExternalString L_3 == "z_(2,1)" );
assert(toExternalString L_4 == "z_(2,2)*z_(3,1)" );
assert(toExternalString L_5 == "z_(1,3)*z_(2,4)*z_(3,1)*z_(4,2)" );
assert(toExternalString L_6 == "z_(1,4)*z_(2,2)^2*z_(3,3)*z_(4,1)" );


L = diagRevLexInit PI; 
assert(numgens L == 17);
assert(toExternalString L_0 == "z_(1,2)");
assert(toExternalString L_1 == "z_(1,1)");
assert(toExternalString L_2 == "z_(1,3)*z_(2,2)");
assert(toExternalString L_3 == "z_(2,1)");
assert(toExternalString L_4 == "z_(2,2)*z_(3,1)");
assert(toExternalString L_5 == "z_(1,4)*z_(2,2)*z_(3,3)*z_(4,5)");
assert(toExternalString L_6 == "z_(1,3)^2*z_(2,4)*z_(3,2)*z_(4,5)");
assert(toExternalString L_7 == "z_(1,3)*z_(2,4)*z_(3,1)*z_(4,5)");
assert(toExternalString L_8 == "z_(1,4)*z_(2,5)*z_(3,1)*z_(4,2)");
assert(toExternalString L_9 == "z_(1,3)*z_(2,5)*z_(3,1)*z_(4,2)");
assert(toExternalString L_10 == "z_(1,3)*z_(2,4)*z_(3,1)*z_(4,2)");
assert(toExternalString L_11 == "z_(1,4)*z_(2,3)*z_(2,2)*z_(3,5)*z_(4,1)");
assert(toExternalString L_12 == "z_(1,4)*z_(2,2)^2*z_(3,5)*z_(4,1)");
assert(toExternalString L_13 == "z_(1,5)*z_(2,2)^2*z_(3,3)*z_(4,1)");
assert(toExternalString L_14 == "z_(1,4)*z_(2,2)^2*z_(3,3)*z_(4,1)");
assert(toExternalString L_15 == "z_(1,5)*z_(2,3)*z_(2,2)*z_(3,4)*z_(3,3)*z_(4,5)*z_(4,1)");
assert(toExternalString L_16 == "z_(1,4)*z_(1,3)*z_(2,4)*z_(2,3)*z_(3,5)*z_(3,2)*z_(4,5)*z_(4,1)");
///

--subwordComplex--
TEST ///
F = facets subwordComplex({4,3,2,1});
assert(toExternalString(F) == "{z_(1,4)*z_(2,3)*z_(2,4)*z_(3,2)*z_(3,3)*z_(3,4)*z_(4,1)*z_(4,2)*z_(4,3)*z_(4,4)}")
///

--entrywiseMinRankTable--
--Example in other file.

--entrywiseMaxRankTable--
--Example in other file.

TEST ///
--schubDecomposition--
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

assert(flatten schubDecomposition schubDetIdeal w == w)
assert(schubDecomposition schubDetIdeal I == {{3, 5, 1, 2, 4}, {5, 2, 3, 1, 4}, {4, 2, 5, 1, 3}, {3, 4, 1, 5, 2}, {4, 2, 3, 5, 1}})
assert(schubDecomposition schubDetIdeal PI == {{3, 6, 1, 2, 4, 5}, {6, 2, 3, 1, 4, 5}, {4, 2, 6, 1, 3, 5}, {3, 4, 1, 6, 2, 5}, {4, 2, 3, 6, 1, 5}})
///

TEST ///
--permOverASM--
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

assert(permOverASM I == {{3, 5, 1, 2, 4}, {5, 2, 3, 1, 4}, {4, 2, 5, 1, 3}, {3, 4, 1, 5, 2}, {4, 2, 3, 5, 1}})
///

TEST ///
--isIntersectionSchubIdeals--
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

assert(isIntersectionSchubIdeals schubDetIdeal w == true );
assert(isIntersectionSchubIdeals schubDetIdeal I == true );
assert(isIntersectionSchubIdeals schubDetIdeal PI == true);
///

TEST ///
--isASMIdeal--
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

assert(isASMIdeal schubDetIdeal w == true );
assert(isASMIdeal schubDetIdeal I == true );
assert(isASMIdeal schubDetIdeal PI == true);
///


--isASMUnion--
--Examples in other file

TEST ///
--getASM--
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

assert(getASM schubDetIdeal w == matrix{{0, 1, 0, 0, 0, 0}, {1, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 1}, {0, 0, 1, 0, 0, 0}, {0, 0, 0, 0, 1, 0}, {0, 0, 0, 1, 0, 0}} );
assert(getASM schubDetIdeal I == I );
assert(getASM schubDetIdeal PI == PI);
///

TEST ///
--isMinRankTable--
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

assert(isMinRankTable rankTable w == true );
assert(isMinRankTable rankTable I == true );
assert(isMinRankTable rankTable PI == true );
///

TEST ///
--rankTableToASM--
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

assert(rankTableToASM rankTable w == matrix{{0, 1, 0, 0, 0, 0}, {1, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 1}, {0, 0, 1, 0, 0, 0}, {0, 0, 0, 0, 1, 0}, {0, 0, 0, 1, 0, 0}});
assert(rankTableToASM rankTable I == I);
assert(rankTableToASM rankTable PI == PI);
///


--rankTableFromMatrix--
--Examples in other file

--schubIntersect--
--Examples in other file

--schubAdd--
--Examples in other file

TEST ///
--getPermFromASM
w = {2,1,6,3,5,4};
I = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,1},{0,0,0,1,0}};
PI = matrix{{0,0,1,0,0},{0,1,-1,1,0},{1,-1,1,0,0},{0,1,0,-1,0},{0,0,0,1,0}};

assert(getPermFromASM getASM schubDetIdeal w == w );
assert(getPermFromASM getASM schubDetIdeal I == {} );
assert(getPermFromASM getASM schubDetIdeal PI == {});
///


TEST ///
--ASM
--???
///

--NEED TESTS FOR isSchubCM