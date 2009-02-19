From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Q: smp.c && barriers (Was: [PATCH 1/4] generic-smp: remove
 single ipi fallback for smp_call_function_many())
Date: Thu, 19 Feb 2009 17:47:20 +1100
Message-ID: <1235026040.8805.3.camel@pasglop>
References: <1234823097.30178.406.camel@laptop>
	 <20090216231946.GA12009@redhat.com> <1234862974.4744.31.camel@laptop>
	 <20090217101130.GA8660@wotan.suse.de> <1234866453.4744.58.camel@laptop>
	 <20090217112657.GE26402@wotan.suse.de> <20090217192810.GA4980@redhat.com>
	 <20090217213256.GJ6761@linux.vnet.ibm.com>
	 <20090217214518.GA13189@redhat.com>
	 <20090217223910.GM6761@linux.vnet.ibm.com>
	 <20090218135212.GB23125@wotan.suse.de>
	 <alpine.LFD.2.00.0902180744520.21686@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:43198 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753220AbZBSGtH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Feb 2009 01:49:07 -0500
In-Reply-To: <alpine.LFD.2.00.0902180744520.21686@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nick Piggin <npiggin@suse.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Jens Axboe <jens.axboe@oracle.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


> It might hide some architecture-specific implementation issue, of course, 
> so random amounts of "smp_mb()"s sprinkled around might well make some 
> architecture "work", but it's in no way guaranteed. A smp_mb() does not 
> guarantee that some separate IPI network is ordered - that may well take 
> some random machine-specific IO cycle.
> 
> That said, at least on x86, taking an interrupt should be a serializing 
> event, so there should be no reason for anything on the receiving side. 
> The _sending_ side might need to make sure that there is serialization 
> when generating the IPI (so that the IPI cannot happen while the writes 
> are still in some per-CPU write buffer and haven't become part of the 
> cache coherency domain).
> 
> And at least on x86 it's actually pretty hard to generate out-of-order 
> accesses to begin with (_regardless_ of any issues external to the CPU). 
> You have to work at it, and use a WC memory area, and I'm pretty sure we 
> use UC for the apic accesses.

On powerpc, I suspect an smp_mb() on the sender would be useful... it
mostly depends how the IPI is generated but in most case it's going to
be an MMIO write, ie non-cached write which isn't ordered vs. any
previous cached store except using a full sync (which is what smp_mb()
does).

Cheers,
Ben.
