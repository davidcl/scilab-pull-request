// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2012 - SCILAB ENTERPRISES - Simon GARESTE
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
// <-- ENGLISH IMPOSED -->
// <-- CLI SHELL MODE -->

msgerr = msprintf(gettext("%s: Wrong number of input argument(s): 2 to 4 expected."), "h5mv");
assert_checkerror("h5mv()",msgerr,77);
msgerr = msprintf(gettext("%s: Wrong type for input argument #1: A string expected."), "h5mv");
assert_checkerror("h5mv(42,42)",msgerr,999);
msgerr = msprintf(gettext("%s: Invalid number of arguments: more than 2 expected."), "h5mv");
assert_checkerror("h5mv(""42"",42)",msgerr,999);
msgerr = msprintf(gettext("%s: Wrong type for input argument #2: A string expected."), "h5mv");
assert_checkerror("h5mv(""42"",42,42)",msgerr,999);
msgerr = msprintf(gettext("%s: Wrong type for input argument #3: A string expected."), "h5mv");
assert_checkerror("h5mv(""42"",""42"",42)",msgerr,999);
msgerr = msprintf(gettext("%s: Invalid hdf5 file: %s."), "h5mv","42");
assert_checkerror("h5mv(""42"",""42"",""42"")",msgerr,999);

a = h5open(TMPDIR + "/test.h5");

msgerr = msprintf(gettext("%s: Invalid hdf5 file: %s."), "h5mv","42");
assert_checkerror("h5mv(a,""42"",""42"")",msgerr,999);
msgerr = msprintf(gettext("%s: Cannot copy object.\nHDF5 description: object ''%s'' doesn''t exist."), "h5mv", "42");
assert_checkerror("h5mv(a,""42"",a)",msgerr,999);

b = h5open(TMPDIR + "/test1.h5");
c = h5open(TMPDIR + "/test2.h5");
h5group(a, "Grp_1");
h5write(a.root.Grp_1, "Dset_1", [1 2 ; 3 4]);
h5flush(a);
h5group(b, "BGrp");
h5write(b("/BGrp"), "BDset", 11:18);
h5close(b)
h5group(c,"CGrp");
h5write(c("/CGrp"),"CDset",(8:12)')
h5close(c);

msgerr = msprintf(gettext("%s: Invalid hdf5 file: %s."), "h5mv", TMPDIR+"/test12.h5");
assert_checkerror("h5mv(a.root.Grp_1,TMPDIR+""/test12.h5"",""/mnt"")",msgerr,999);

h5mv(a.root.Grp_1, "Dset_1", a, "Dset_2")
assert_checkequal(a.root.Datasets,"Dset_2");
assert_checkequal(a.root.Dset_2.data,[1 2;3 4]');

msgerr = msprintf(gettext("%s: Cannot copy object."), "h5mv");
assert_checkerror("h5mv(a,a)",msgerr,999);

msgerr = msprintf(gettext("%s: Invalid number of arguments: more than 2 expected."), "h5mv");
assert_checkerror("h5mv(a,12.0)",msgerr,999);

msgerr = msprintf(gettext("%s: Wrong type for input argument #1: A string expected."), "h5mv");
assert_checkerror("h5mv(12.0,a)",msgerr,999);

msgerr = msprintf(gettext("Undefined variable: %s"), "d");
assert_checkerror("h5mv(a,d)",msgerr,4);

msgerr = msprintf(gettext("%s: Invalid H5Object."), "h5mv");
assert_checkerror("h5mv(a,c)",msgerr,999);

msgerr = msprintf(gettext("%s: Invalid number of arguments: more than 2 expected."), "h5mv");
assert_checkerror("h5mv(a,""d"")",msgerr,999);
h5mv(TMPDIR  +"/test1.h5", "/BGrp/BDset", a.root.Grp_1)
assert_checkequal(a.root.Grp_1.BDset.data,(11:18)');
assert_checkequal(a.root.Datasets,"Dset_2");
h5close(a);

h5mv(TMPDIR+"/test.h5","/Grp_1",TMPDIR+"/test1.h5","/grp2");
assert_checkequal(h5ls(TMPDIR+"/test1.h5"),["BGrp" "group";"grp2" "group"]);
a=h5open(TMPDIR+"/test.h5","a");
msgerr = msprintf(gettext("%s: Error in retrieving field content:\nInvalid field: %s"), "%H5Object_e", "Group_1");
assert_checkerror("h5ls(a.root.Group_1)",msgerr,999);
assert_checkequal(h5ls(TMPDIR+"/test1.h5"),["BGrp" "group" ; "grp2" "group"]);

