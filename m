Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268674AbUIGVqk@vger.kernel.org>
Received: from p508B7F50.dip.t-dialin.net ([80.139.127.80]:62235 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S268667AbUIGVoi
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 7 Sep 2004 17:44:38 -0400
Date: Tue, 7 Sep 2004 23:44:08 +0200
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
Message-ID: <20040907214408.GB27284@linux-mips.org>
References: <Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org> <20040904204850.48b7cfbd.pj@sgi.com> <Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org> <20040904211749.3f713a8a.pj@sgi.com> <20040904215205.0a067ab8.pj@sgi.com> <20040906182330.GA79122@muc.de> <Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org> <20040906141142.663941fb.pj@sgi.com> <Pine.LNX.4.58.0409070736100.2299@ppc970.osdl.org> <20040907144936.GD20981@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907144936.GD20981@wotan.suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Jackson <pj@sgi.com>, ak@muc.de, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Sep 07, 2004 at 04:49:36PM +0200, Andi Kleen wrote:

> ppc64 libnuma is not deployed - the current numactl releases
> still don't have the system call numbers and nobody told me 
> about hacking them in.
> 
> So for me breaking ppc64 would be no problem.

Same for mips64; to date the SGI IP27 (Origin 200 / 2000) is the only
supported NUMA system and it's not very widespread.  Embedded NUMA is
getting closer but as long as that's still NDA stuff I have no problem
with breaking ABIs.

> > So it's ppc64, sparc64, s390x and sh64. I suspect the breakage is 
> > basically zero, since not only aren't there _that_ many machines out 
> > there, the percentage of them that use setaffinity or mbind is likely not 
> > that high either.
> 
> For mbind() breaking existing ppc64 users is unlikely I agree.
> 
> For setaffinity I am not so sure. The system call is around
> for a long time and has been used in standard utilities
> in distributions also for quite some time.
> 
> Also it is commonly used in real time applications. 
> 
> So in short I think changing mbind to u32 would be fine,
> but I wouldn't do it for sched_setaffinity() 

Same situation here for mips64.  sched_setaffinity() is established and
being used in applications, including commercial products so changing is
not an option.  For mbind(2) the situation is the opposite; I just
noticed the syscall handler was actually pointing to sys_ni_syscall and
nobody did complain so far so that's clearly an ok for changing the
interface :-)

  Ralf
