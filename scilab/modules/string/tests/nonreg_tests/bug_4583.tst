// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2010 - INRIA - Serge Steer <serge.steer@inria.fr>
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- Non-regression test for bug 4583 -->
//
// <-- CLI SHELL MODE -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=4583
//
// <-- Short Description -->
// Default value for string array assignment was " " instead of an empty string
t=[];t(3)="foo";
if or(length(t)<>[0;0;3]) then pause,end

t='x';t(2,3)="foo";
if or(length(t)<>[1 0 0;0 0 3]) then pause,end

t(2,3,2)='yy';
if or(length(t(:))<>[1;0;0;0;0;3;0;0;0;0;0;2]) then pause,end
