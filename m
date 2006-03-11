Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtp.tele.dk ([193.162.159.95]:56324 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751426AbWCKS1c (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 11 Mar 2006 13:27:32 -0500
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id AF8121EC305
	for <linux-arch@vger.kernel.org>; Sat, 11 Mar 2006 19:27:31 +0100 (CET)
Date: Sat, 11 Mar 2006 19:27:25 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC PATCH] get rid of duplicate exports from string.h
Message-ID: <20060311182725.GB21132@mars.ravnborg.org>
References: <20060311161106.GA19455@mars.ravnborg.org> <20060311175101.GA31096@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060311175101.GA31096@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, Mar 11, 2006 at 05:51:01PM +0000, Russell King wrote:
> On Sat, Mar 11, 2006 at 05:11:06PM +0100, Sam Ravnborg wrote:
> > In lib/string.c export all symbols that are not defines.
> >...
> > As an example I've done it for sparc64 but the same applies
> > for most architectures.
> 
> A few comments:
> 
> 1. it'd be nice to use #ifndef blah instead of #if !defined(blah)
OK

> 2. I don't think we normally indent for preprocessor conditionals -
>    if we did, would we not have these function definitions indented?
OK

> 3. I don't understand how these !defined things are supposed to solve
>    the problem.  There are three cases, and use strcpy as an example:
> 
>    a) an architecture decides to override the lib/string.c definition
>       with its own static inline function.  In this case, it must
>       define __HAVE_ARCH_STRCPY to exclude the lib/string.c version.
> 
>       In this case, the architecture may decide against exporting the
>       named function because it'll always be inlined.
> 
>    b) an architecture decides to override the lib/string.c definition
>       with its own macro version.  This case is essentially the same
>       as case (a).
> 
>    c) an architecture decides to override the lib/string.c definition
>       with its own out of line version.  It must define
>       __HAVE_ARCH_STRCPY as per (a), but it wants an export.
> 
>    d) an architecture wishes to use the lib/string.c definition.  It
>       must not define __HAVE_ARCH_STRCPY.
> 
>    With these changes, case (a) requires an additional #define strcpy strcpy
>    to prevent the EXPORT_SYMBOL being used.
I did not consider the a) case at all. Did not hit it with sparc64 that
I'm playing with,

> 
>    Since we have case (a) in the kernel sources, I don't see any additional
>    #defines being added to prevent these exports.  Maybe you decided to
>    always cause lib/string.c to export them except for case (b) ?
> 
> All in all, I think this is a complex solution to something which should
> be simple.  We have the general rule that EXPORT_SYMBOLs should be local
> to the code which provides the function - at least within the same file.
> This change seems to be a step away from that.
Thought of it as the exception from the rule thing.

> 
> I much prefer the current implementation where, if you define __HAVE_ARCH_foo
> then foo is not defined nor exported by the core kernel.
I will go for this one and submit changes to lkml+arch maintainer as I
get crosscompile suites up and running.

Thanks for the feedback!

	Sam
