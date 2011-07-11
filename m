From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 00/39] UAPI header file split [ver #2]
Date: Mon, 11 Jul 2011 15:38:10 +0100
Message-ID: <17749.1310395090@redhat.com>
References: <20110710213827.2779b0c3.rdunlap@xenotime.net> <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54917 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754892Ab1GKOiY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Jul 2011 10:38:24 -0400
In-Reply-To: <20110710213827.2779b0c3.rdunlap@xenotime.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: dhowells@redhat.com, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org, ralf@linux-mips.org

Randy Dunlap <rdunlap@xenotime.net> wrote:

> Could you give a small bit of background on the "recursion problems," please?

Well, I occasionally run into a problem where I can't write an inline function
in a header file because I need to access something from another headerfile
that includes this one.  Due to this, I end up writing it as a #define instead.

The problems are mainly due to inline functions.  If we split some headers
(linux/sched.h being the biggest culprit) to separate the inline functions from
the data structs (e.g. task_struct) then we could reduce the problems.

Quite often it's a case of an inline function in header A wanting a struct[*]
from header B, but header B already has an inline function that wants a struct
from header A.

[*] or constant or whatever.


Recently someone tried to add a kernel-offsets file (an analogue to
asm-offsets) to deal with the problems of dealing with both linux/rcupdate.h
and linux/sched.h.

> > (7) Provide a script to go through and rejig the #includes of each source
> >     file to have just the ones that are actually required.
> 
> How is "actually required" defined?
> We traditionally want to see #include <hdrfile> for any interfaces that are
> used, even if other header files suck in some other needed header files.

Yes, but with the amount of copy'n'paste going on, there are quite a lot of
unnecessary #includes in the codebase.  Furthermore, headers sometimes get
rearranged and new #includes added - and sometimes obsolete ones don't get
removed.

Whilst these aren't strictly a part of the recursion problem, what they do do
is slow down recompilation by causing recompilation of things that didn't
actually need it.

> >  (8) Provide a make target that tests all the KAPI and UAPI headers by
> >      simply passing them one at a time to the compiler and attempting to
> >      compile them.
> 
> Interesting.

If gcc can have its sources piped in, then this should be fairly
straightforward.  Admittedly, there may be some headers that can't go through
this process as they're meant to be #included after #defining some parameters,
but those can be flagged in some way.

> > The uapi/ directories are also added with -I to the CPP flags after the
> > include/ directories so that if the KAPI file does not exist, the UAPI file
> > will be used directly.  This is not as elegant as using #include_next might
> > be, but it does work.
> 
> Is this v2 patchset meant to avoid the use of #include_next?
> I don't see that used, but patch 22 description refers to #include_next.

Yeah...  I need to vet the patch descriptions.

Btw, what's your reason for disliking #include_next?  Note that the kernel
already uses it in places.

David
