From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] clarify usage expectations for cnt32_to_63()
Date: Sat, 08 Nov 2008 21:54:04 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811082143320.13034@xanadu.home>
References: <20081106220530.5b0e3a96.akpm@linux-foundation.org>
 <alpine.LFD.2.00.0811070256450.13034@xanadu.home>
 <25363.1226056819@redhat.com> <20081107164758.GB22134@Krystal>
 <20081107201118.GB28600@flint.arm.linux.org.uk>
 <20081107213610.GC2654@Krystal> <9405.1226101315@redhat.com>
 <20081108001555.GE18378@flint.arm.linux.org.uk>
 <alpine.LFD.2.00.0811080939180.13034@xanadu.home>
 <alpine.LFD.2.00.0811081746060.13034@xanadu.home>
 <20081109022549.GA18508@Krystal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:54568 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562AbYKICyL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 8 Nov 2008 21:54:11 -0500
In-reply-to: <20081109022549.GA18508@Krystal>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Russell King <rmk+lkml@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, lkml <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, benh@kernel.crashing.org, paulus@samba.org, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org

On Sat, 8 Nov 2008, Mathieu Desnoyers wrote:

> > I used a rmb() so this is also safe for mixed usages in and out of 
> > interrupt context.  On the architecture I care about this is turned into
> > a simple compiler barrier and therefore doesn't make a difference, while 
> > smp_rmb() is a noop which isn't right.
> > 
> 
> Hum ? smp_rmb() is turned into a compiler barrier on !SMP architectures.
> Turning it into a NOP would be broken. Actually, ARM defines it as a
> barrier().

Oh, right. I got confused somehow with read_barrier_depends().

> I *think* that smp_rmb() would be enough, supposing the access to memory
> is done in program order wrt local interrupts in UP. This is basically
> Steven's question, which has not received any clear answer yet. I'd like
> to know what others think about it.

In the mean time a pure rmb() is the safest thing to do now.  Once we 
can convince ourselves that out-of-order reads are always rolled back 
upon the arrival of an interrupt then this could be relaxed.


Nicolas
