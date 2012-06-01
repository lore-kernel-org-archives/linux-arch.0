From: David Howells <dhowells@redhat.com>
Subject: Pull UAPI split patches after -rc1?
Date: Fri, 01 Jun 2012 18:33:40 +0100
Message-ID: <17203.1338572020@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47481 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965696Ab2FATCy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 1 Jun 2012 15:02:54 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@osdl.org
Cc: dhowells@redhat.com, hpa@zytor.com, viro@ZenIV.linux.org.uk, linux-arch@vger.kernel.org


Hi Linus,

Are you feeling up to pulling a large header file cleanup after -rc1?  Or are
you still reeling from the fun with asm/system.h?

I'd like to request that you pull my UAPI patchset if you will.  I may need to
regenerate the patchset by running my scripts if any of the header files
change, but that doesn't take very long.

This disintegration shouldn't be as problematic as the asm/system.h since it
splits a number of header files in two and puts a #include from the remnant to
the extract.

The patches can be found here:

	http://git.infradead.org/users/dhowells/linux-headers.git

on the uapi-split branch.  There are signed tags on the branch.

I've tagged the previously sent cover message on below for reference.

David

===================================
BACKGROUND ON THE RECURSION PROBLEM
===================================

I occasionally run into a problem where I can't write an inline function in a
header file because I need to access something from another header that
includes this one.  Due to this, I end up writing it as a #define instead.

The problems are mainly due to inline functions.  If we split some headers
(linux/sched.h being the biggest culprit) to separate the inline functions from
the data structs (e.g. task_struct) then we could reduce the problems.  Other
splits and rearrangements could help also.

Quite often it's a case of an inline function in header A wanting a struct[*]
from header B, but header B already has an inline function that wants a struct
from header A.

	[*] or constant or whatever.

Recently someone tried to add a kernel-offsets file (an analogue to
asm-offsets) to deal with the problems of dealing with both linux/rcupdate.h
and linux/sched.h - each header needed to be included before the other.


=================
PLANNED PROCEDURE
=================

The planned steps are:

 (1) Split the Userspace API (UAPI) out of the kernel headers into its own
     header directories.

 (2) Move stuff out of the Kernel API (KAPI) headers that can be contained in
     individual directories as it is referenced by a single file or directory
     of files.

 (3) Make coherent what can be found in commmon arch headers.  asm/system.h has
     been done now, but there's probably other stuff.

 (4) Split some headers into definitions containers and inline function
     containers to clean up recursion problems.  The main culprit is very
     likely to be linux/sched.h, I think.

 (5) I'd like to split some headers (e.g. linux/security.h) to reduce the
     conditional recompilation burden.  linux/security.h could have, for
     instance, struct security_operations split out into a header file private
     to the stuff in the security/ directory as the wrappers of its function
     pointers are now out of lined in security/security.c.

 (6) Replace the traditional anti-reinclusion guards on header files with
     three-state anti-recursion guards that abort compilation if recursive
     inclusion is encountered.

 (7) Provide a script to go through and rejig the #includes of each source file
     to have just the ones that are actually required (a lot of cut'n'pasting
     goes on, and there are quite a few unnecessary #includes out there).

 (8) Provide a make target that tests all the KAPI and UAPI headers by simply
     passing them one at a time to the compiler and attempting to compile them.


===================
IMPLEMENTING STEP 1
===================

The patches actually posted here are the manual preparation for the UAPI split
in step (1) above.  I haven't posted the patches that do the actual splitting
by email as the largest of them is in excess of 120,000 lines.  However, the
patches are available through GIT:

	http://git.infradead.org/users/dhowells/linux-headers.git

All the development is on the uapi-split branch.  The patches posted here are
from the base of that branch up to the uapi-prep tag; the automated split
follows thereafter to the uapi-post-split tag.

The main aims of the split are:

 (1) To simplify the kernel headers by separating the UAPI from the KAPI.

 (2) You should be able to simply copy the UAPI directories to userspace with
     no processing, and they should just work.  Unfortunately, it's not quite
     that simple as some of the UAPI headers behave differently depending on
     whether __KERNEL__ is defined or not.

 (3) To eliminate the need for __KERNEL__.  After the split, __KERNEL__ can
     certainly be unifdef'd from the residual kernel headers - but this isn't
     quite true of the UAPI headers.

The main restrictions on how I've done the split are:

 (1) The GIT history must be maintained in both sides of a split header file.

 (2) I don't want to have to alter every #include directive in the kernel
     sources.

 (3) "make allyesconfig" should work after.  This is tricky to test as it
     doesn't necessarily work before.

With this in mind, the way things work is that #include is used for the KAPI
header to refer to the UAPI header, with the path prefixed with 'uapi/'.  The
UAPI header is placed in a subdir of *include/uapi/ that mirrors where the KAPI
file is under *include/.  For instance:

	include/linux/types.h		-> include/uapi/linux/types.h
	arch/x86/include/asm/unistd.h	-> arch/x86/include/uapi/asm/unistd.h

include/linux/types.h therefore #includes <uapi/linux/types.h>.

The uapi/ directories are also added with -I to the CPP flags after the
include/ directories so that if the KAPI file does not exist, the UAPI file
will be used directly.  This is not as elegant as using #include_next might be,
but it does work.

I've created one patch for each include directory that gets exported.  I'd
prefer to use a single patch per file to make GIT's life easier and more sure,
but that would mean a stack of >1100 patches.  I think the most important thing
from git-blame's point of view is to keep the arch header splits separated by
arch as there's a lot of similarity.


I've tested building make allyesconfig with x86_64 and MIPS.


======
ISSUES
======

There are some issues:

 (*) I'm not sure I have all the kernel scripts and Makefiles altered correctly
     - someone who knows the Kbuild magic should check things over.  However,
     headers do install correctly, so I think I've got things mostly right.

 (*) Documentation/vm/page-types.c directly refers to the magic.h file it wants
     to include using a path with '..' in it.  This is broken from the patch
     that alters the path until the header is split.

 (*) Is uapi/ the right name for the UAPI directories?  If not, it shouldn't be
     too hard to change as most of it is scripted.  It can't be put in usr/
     until the UAPI headers don't need any processing, and besides, the arch
     UAPI headers can't be put under there anyway without collision.

 (*) I'd also prefer to use #include_next and move the uapi/ directories out of
     the include/ directories:

	include/uapi/ -> uapi/
	arch/foo/include/uapi/ -> arch/foo/uapi/

     as it seems cleaner, especially as there's then no need to #include
     <uapi/...> anywhere - but various people object to the use of
     #include_next, though the kernel does already use it.
