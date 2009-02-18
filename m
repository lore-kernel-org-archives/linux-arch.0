From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: smp.c && barriers (Was: [PATCH 1/4] generic-smp: remove single
 ipi fallback for smp_call_function_many())
Date: Wed, 18 Feb 2009 08:19:29 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902180812500.21686@localhost.localdomain>
References: <20090216213205.GA9098@redhat.com> <1234820704.30178.396.camel@laptop> <20090216220214.GA10093@redhat.com> <1234823097.30178.406.camel@laptop> <20090216231946.GA12009@redhat.com> <1234862974.4744.31.camel@laptop> <20090217101130.GA8660@wotan.suse.de>
 <1234866453.4744.58.camel@laptop> <20090217112657.GE26402@wotan.suse.de> <1234923702.29823.7.camel@vayu> <20090218135945.GC23125@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38826 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751868AbZBRQWK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Feb 2009 11:22:10 -0500
In-Reply-To: <20090218135945.GC23125@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Oleg Nesterov <oleg@redhat.com>, Jens Axboe <jens.axboe@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>



On Wed, 18 Feb 2009, Nick Piggin wrote:
> > 
> > x2apic register reads/writes don't have serializing semantics, as
> > opposed to uncached xapic accesses, which are inherently serializing.
> > 
> > With this patch, we need to fix the corresponding x2apic IPI operations.
> > I will take a look at it.
> 
> You're saying the problem is in generic_exec_single because I've
> removed the smp_mb that inadvertently also serialises memory with
> the x2apic on x86?

I think Suresh is wrong on this.

The x2apic is using "wrmsr" to write events, and that's a serializing 
instruction. 

I really don't know of any way to get unordered information out of a x86 
core, except for playing games with WC memory, and WC memory would not be 
appropriate for something like an interrupt controller.

Of course, it's possible that Intel made the x2apic MSR's magic, and that 
they don't serialize, but that's very much against some very explicit 
Intel documentation. wrmsr is one of the (few) instructions that is 
mentioned all ove the documentation as being serializing.

			Linus
