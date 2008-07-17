From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 1/2] byteorder: add a new include/linux/swab.h to
	define byteswapping functions
Date: Thu, 17 Jul 2008 16:23:03 -0700
Message-ID: <1216336983.6029.62.camel@brick>
References: <1216148509.6610.14.camel@brick>
	 <20080717155953.5cddc48d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:51885 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758658AbYGQXXF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jul 2008 19:23:05 -0400
Received: by yw-out-2324.google.com with SMTP id 9so12650ywe.1
        for <linux-arch@vger.kernel.org>; Thu, 17 Jul 2008 16:23:04 -0700 (PDT)
In-Reply-To: <20080717155953.5cddc48d.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: torvalds@linux-foundation.org, linux-arch@vger.kernel.org

On Thu, 2008-07-17 at 15:59 -0700, Andrew Morton wrote:
> On Tue, 15 Jul 2008 12:01:49 -0700
> Harvey Harrison <harvey.harrison@gmail.com> wrote:
> 
> > Collect the implementations from include/linux/byteorder/swab.h, swabb.h
> > in swab.h
> 
> I'm afraid I've been basically ignoring the storm of byteorder and
> related patches simply because I do not have a large enough brain to
> work out wth is going on.
> 
> I get the impression that there's a great storm of random patches, some
> of which are repeats, with a distressing number of updates all with no
> overall plan.  Probably I'm wrong about that, but making it all not
> _look_ like that would really help.
> 
> So ho hum.  I merged these two into -mm, at the tail of the queue, in a
> new "byteorder" "tree", probably for 2.6.28.  We could bump them up
> into 2.6.27-rc1 if that would help merging followup stuff out into the
> subsystem trees during the 2.6.27-rcX cycle.
> 
> But please be aware that this ongoing patchstorm is quite confusing
> from where I sit, and I just haven't been able to justify expending all
> the time which it seems that it requires for me to work out just what
> the heck is going on.
> 
> So please, send the patches less frequently, in larger batches, after
> lots of testing.  Each series should have some overall theme which is
> clearly explained in an easy-to-follow fashion.

A little context then:

With these two merged, I can start moving each arch over to the new byteorder
headers one at a time through the arch maintainers, so I would appreciate it
if they went upstream soonish.

The new headers are not used, and nothing at all changes for arches than do
not opt-in.

The advantage of the new headers are that:
1) there is a _standard_ way for each arch to provide optimized byteswapping
routines (swab etc), and all of the endian-dependant helpers cpu_to_* are
pulled up into linux/byteorder.h

2) we can now rely on __LITTLE_ENDIAN/_BIG_ENDIAN being defined in one place
and the checks for setting both/neither are unified in the linux/ header.

3) The linux/byteorder/ folder is consolidated now and removed, with a few
includes that were directly including byteorder/swabb.h removed as the implementation
now unconditionally provides this functionality.

4) With the implementation all moving to linux/byteorder, asm/byteorder no longer
is the best include, so I have a series that replaces all asm/ with linux/
compatibly, there is no flag day, once all the asm/ includes are gone
we can remove one include in the linux/ header.

5) The new implementation of cpu_to_*, etc does compile-time constant folding,
removing the need for all of the __constant_* versions which another series
then removes.  Again, no flag day, can proceed at its own pace without breaking anything.

6) Checks throughout the tree for __BIG_ENDIAN/__LITTLE_ENDIAN can be removed/simplified
as the linux header now does this check centrally.

I've been rebasing the 65 patch series against linux-next each day, let me know when you
want it, but it breaks down to:

2 patches which you just merged
1 patch wiring all the arches...can be easily split.
<nothing further until all arches have moved over>
1 patch removing direct includes of linux/byteorder/swabb.h
1 patch removing linux/byteorder/*
2 patches consolidating endian tests/adding an include to linux/byteorder.h to make
_either_ asm or linux/ ok to include directly
36 patches changing asm/byteorder to linux/byteorder throughout the tree and
finally making linux/byteorder.h the intended header for direct includes.

The rest of the patches are removals of the __constant_* endian helpers
replacing them with the regular versions that now do compile-time
folding, and finally removing the __constant versions entirely.


Cheers,

Harvey
