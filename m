Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268182AbUIGPC5@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:6039 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268200AbUIGOtn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Sep 2004 10:49:43 -0400
Date: Tue, 7 Sep 2004 16:49:36 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
Message-ID: <20040907144936.GD20981@wotan.suse.de>
References: <20040904180548.2dcdd488.pj@sgi.com> <Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org> <20040904204850.48b7cfbd.pj@sgi.com> <Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org> <20040904211749.3f713a8a.pj@sgi.com> <20040904215205.0a067ab8.pj@sgi.com> <20040906182330.GA79122@muc.de> <Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org> <20040906141142.663941fb.pj@sgi.com> <Pine.LNX.4.58.0409070736100.2299@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409070736100.2299@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, ak@muc.de, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Sep 07, 2004 at 07:40:53AM -0700, Linus Torvalds wrote:
> >     No doubt Andi will veto this for mbind/mempolicy, because it breaks
> >     libnuma's he has in the field - a reasonable concern. 
> 
> Now, it will _only_ break systems that are _both_ 64-bit _and_ big-endian. 
> Little-endian or 32-bit boxes will never care.
> 
> There aren't that many of those machines. I've got one right here (ppc64), 
> but that particular one is guaranteed not to break if only because it's 
> running a 32-bit user space.

ppc64 libnuma is not deployed - the current numactl releases
still don't have the system call numbers and nobody told me 
about hacking them in.

So for me breaking ppc64 would be no problem.

> 
> So it's ppc64, sparc64, s390x and sh64. I suspect the breakage is 
> basically zero, since not only aren't there _that_ many machines out 
> there, the percentage of them that use setaffinity or mbind is likely not 
> that high either.

For mbind() breaking existing ppc64 users is unlikely I agree.

For setaffinity I am not so sure. The system call is around
for a long time and has been used in standard utilities
in distributions also for quite some time.

Also it is commonly used in real time applications. 

So in short I think changing mbind to u32 would be fine,
but I wouldn't do it for sched_setaffinity() 

-Andi
