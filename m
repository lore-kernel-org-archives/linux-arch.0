From: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: futex_init() vs. KERNEL_DS, was Re: Boot crash on 68030
Date: Fri, 28 Feb 2014 21:30:29 +1100 (EST)
Message-ID: <alpine.LNX.2.00.1402282054280.2697@nippy.intranet>
References: <20793.61385.652975.797741@pilspetsen.it.uu.se> <alpine.LNX.2.00.1312101000250.10258@nippy.intranet> <87iouxzju3.fsf@igel.home> <alpine.LNX.2.00.1312101141250.17926@nippy.intranet> <CAMuHMdVB3w3JpNSrdZXPk+xrDXyhm-CgDHX5XW_1CUKn8pQmtA@mail.gmail.com>
 <mvmy53t6mac.fsf@hawking.suse.de> <alpine.LNX.2.00.1402281202180.21491@nippy.intranet> <20140228074806.GA4216@osiris>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:32953 "EHLO
	kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbaB1KbC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Feb 2014 05:31:02 -0500
In-Reply-To: <20140228074806.GA4216@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Linux-m68k <linux-m68k@vger.kernel.org>, Linux-arch <linux-arch@vger.kernel.org>


On Fri, 28 Feb 2014, Heiko Carstens wrote:

> On Fri, Feb 28, 2014 at 02:12:22PM +1100, Finn Thain wrote:
> > > > > Data read fault at 0x00000000 in Super Data (pc=0x3afec) BAD 
> > > > > KERNEL BUSERR
> > > 
> > > I think futex_init needs to do set_fs(USER_DS), since futex is about 
> > > user data.
> > 
> > Rhetorical question: does it make sense to explicitly switch to 
> > USER_DS when we know that current->mm may be invalid at the time?
> > 
> > Given that the presence of USER_DS or KERNEL_DS at initcall-time 
> > varies between architectures, perhaps this question must be left to 
> > arch implementors.
> 
> All architectures start with KERNEL_DS, otherwise the first couple of 
> system calls within kernel_init() would all fail and the system wouldn't 
> boot.

I was alluding to the assertion that "USER_DS is the normal operating 
state": https://lkml.org/lkml/2014/1/15/476

> 
> > Moreover, architectures that have no need for a run-time test for 
> > usable futex_value ops have no real interest in such questions. 
> > AFAICT, only mips needs the run-time test.
> > 
> > For every other arch the availability of futex_value ops is known at 
> > compile-time. We don't need to pursue universal answers to questions 
> > like these:
> > 
> > 1) the correctness of switching to USER_DS with mm->current == NULL
> 
> I "fixed" s390, so it should survive an early switch to USER_DS and a 
> subsequent failing user space access now.
> 
> Anyway,
> 
> > The discussion of these questions in various threads on various lists 
> > did not resolve anything. Again, this is probably because all of these 
> > questions are actually arch implementation issues.
> > 
> > So it seems to me that the solution to the futex_init() problem is to 
> > evaluate the futex_cmpxchg_enabled assignment at compile-time where 
> > possible, and use the run-time test only on mips. Thoughts?
> 
> Such a patch exists already (bottom of message):
> 
> http://marc.info/?l=linux-next&m=138875880028607&w=2
> 

Thanks. I gather that you don't need this patch on s390 any more. Though 
it does promise to save some cycles on any architecture that can optimize 
away all the "if (!futex_cmpxchg_enabled) return" tests.

With your patch, the nak'd patch* from Geert would be obsolete unless it 
was useful to mips (or deemed correct by fiat).

Finn


* http://marc.info/?l=linux-kernel&m=138675863423989&w=2
