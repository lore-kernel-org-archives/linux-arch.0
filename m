From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: futex_init() vs. KERNEL_DS, was Re: Boot crash on 68030
Date: Fri, 28 Feb 2014 08:48:06 +0100
Message-ID: <20140228074806.GA4216@osiris>
References: <20793.61385.652975.797741@pilspetsen.it.uu.se>
 <alpine.LNX.2.00.1312101000250.10258@nippy.intranet>
 <87iouxzju3.fsf@igel.home>
 <alpine.LNX.2.00.1312101141250.17926@nippy.intranet>
 <CAMuHMdVB3w3JpNSrdZXPk+xrDXyhm-CgDHX5XW_1CUKn8pQmtA@mail.gmail.com>
 <mvmy53t6mac.fsf@hawking.suse.de>
 <alpine.LNX.2.00.1402281202180.21491@nippy.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1402281202180.21491@nippy.intranet>
Sender: linux-m68k-owner@vger.kernel.org
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Linux-m68k <linux-m68k@vger.kernel.org>, Linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 28, 2014 at 02:12:22PM +1100, Finn Thain wrote:
> > >> Data read fault at 0x00000000 in Super Data (pc=0x3afec) BAD KERNEL 
> > >> BUSERR
> > 
> > I think futex_init needs to do set_fs(USER_DS), since futex is about 
> > user data.
> 
> Rhetorical question: does it make sense to explicitly switch to USER_DS 
> when we know that current->mm may be invalid at the time?
> 
> Given that the presence of USER_DS or KERNEL_DS at initcall-time varies 
> between architectures, perhaps this question must be left to arch 
> implementors.

All architectures start with KERNEL_DS, otherwise the first couple of system
calls within kernel_init() would all fail and the system wouldn't boot.

> Moreover, architectures that have no need for a run-time test for usable 
> futex_value ops have no real interest in such questions. AFAICT, only mips 
> needs the run-time test.
> 
> For every other arch the availability of futex_value ops is known at 
> compile-time. We don't need to pursue universal answers to questions like 
> these:
> 
> 1) the correctness of switching to USER_DS with mm->current == NULL [1]

I "fixed" s390, so it should survive an early switch to USER_DS and a
subsequent failing user space access now.

Anyway,

> The discussion of these questions in various threads on various lists did 
> not resolve anything. Again, this is probably because all of these 
> questions are actually arch implementation issues.
> 
> So it seems to me that the solution to the futex_init() problem is to 
> evaluate the futex_cmpxchg_enabled assignment at compile-time where 
> possible, and use the run-time test only on mips. Thoughts?

Such a patch exists already (bottom of message):

http://marc.info/?l=linux-next&m=138875880028607&w=2
