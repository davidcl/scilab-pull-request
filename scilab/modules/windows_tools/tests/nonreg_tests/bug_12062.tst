// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2012 - Scilab Enterprises - Vincent COUVERT
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- CLI SHELL MODE -->
//
// <-- Non-regression test for bug 12062 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=12062
//
// <-- Short Description -->
// getsystemmetrics() failed for some properties such as 'SM_CXMAXIMIZED'.

ierr = execstr("getsystemmetrics(""SM_CXMAXIMIZED"")", "errcatch");
assert_checkequal(ierr, 0);
