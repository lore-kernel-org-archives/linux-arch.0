From: Finn Thain <fthain@telegraphics.com.au>
Subject: futex_init() vs. KERNEL_DS, was Re: Boot crash on 68030
Date: Fri, 28 Feb 2014 14:12:22 +1100 (EST)
Message-ID: <alpine.LNX.2.00.1402281202180.21491@nippy.intranet>
References: <20793.61385.652975.797741@pilspetsen.it.uu.se> <alpine.LNX.2.00.1312101000250.10258@nippy.intranet> <87iouxzju3.fsf@igel.home> <alpine.LNX.2.00.1312101141250.17926@nippy.intranet> <CAMuHMdVB3w3JpNSrdZXPk+xrDXyhm-CgDHX5XW_1CUKn8pQmtA@mail.gmail.com>
 <mvmy53t6mac.fsf@hawking.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <mvmy53t6mac.fsf@hawking.suse.de>
Sender: linux-m68k-owner@vger.kernel.org
To: Linux-m68k <linux-m68k@vger.kernel.org>, Linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


On Tue, 10 Dec 2013, Andreas Schwab wrote:

> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> 
> >> Data read fault at 0x00000000 in Super Data (pc=0x3afec) BAD KERNEL 
> >> BUSERR
> 
> I think futex_init needs to do set_fs(USER_DS), since futex is about 
> user data.

Rhetorical question: does it make sense to explicitly switch to USER_DS 
when we know that current->mm may be invalid at the time?

Given that the presence of USER_DS or KERNEL_DS at initcall-time varies 
between architectures, perhaps this question must be left to arch 
implementors.

Moreover, architectures that have no need for a run-time test for usable 
futex_value ops have no real interest in such questions. AFAICT, only mips 
needs the run-time test.

For every other arch the availability of futex_value ops is known at 
compile-time. We don't need to pursue universal answers to questions like 
these:

1) the correctness of switching to USER_DS with mm->current == NULL [1]

2) the correctness of USER_DS vs. KERNEL_DS for (all) initcalls [2]

3) the correctness of allowing faults when get_fs() == KERNEL_DS [3]

4) the proposition that "[futex_value ops] explicitly take a __user 
   pointer and are expected to do whatever is needed to perform the 
   operation"  ... even during kernel initialization. [4]

The discussion of these questions in various threads on various lists did 
not resolve anything. Again, this is probably because all of these 
questions are actually arch implementation issues.

So it seems to me that the solution to the futex_init() problem is to 
evaluate the futex_cmpxchg_enabled assignment at compile-time where 
possible, and use the run-time test only on mips. Thoughts?

Finn


[1] http://marc.info/?l=linux-next&m=138876015228975&w=2

[2] https://lkml.org/lkml/2014/1/15/476
    http://marc.info/?l=linux-kernel&m=138971456630101&w=2

[3] http://marc.info/?l=linux-next&m=138876367730190&w=2

[4] http://marc.info/?l=linux-kernel&m=138970641726884&w=2
