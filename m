From: Ingo Molnar <mingo@elte.hu>
Subject: Re: smp.c && barriers (Was: [PATCH 1/4] generic-smp: remove single
	ipi fallback for smp_call_function_many())
Date: Fri, 20 Feb 2009 20:40:54 +0100
Message-ID: <20090220194054.GA2444@elte.hu>
References: <20090217112657.GE26402@wotan.suse.de> <1234923702.29823.7.camel@vayu> <20090218135945.GC23125@wotan.suse.de> <1234982620.29823.22.camel@vayu> <20090218191757.GD8889@elte.hu> <1235001314.14523.2.camel@vayu> <20090219122031.GC1703@elte.hu> <1235080824.14523.19.camel@vayu> <20090220105640.GE28581@elte.hu> <1235156214.14523.54.camel@vayu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:60409 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbZBTTlk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Feb 2009 14:41:40 -0500
Content-Disposition: inline
In-Reply-To: <1235156214.14523.54.camel@vayu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Nick Piggin <npiggin@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Oleg Nesterov <oleg@redhat.com>, Jens Axboe <jens.axboe@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, steiner@sgi.com


* Suresh Siddha <suresh.b.siddha@intel.com> wrote:

> > So the question is, is an SFENCE there enough to serialize 
> > the WRMSR with previous memory-writes? It's not specified in 
> > the x2apic docs as far as i could see.
> 
> No. sfence is not enough (wrmsr to x2apic regs was still 
> passing ahead). We have done a small experiment to demonstrate 
> the issue and adding mfence fixes the issue but not sfence. We 
> need a serializing instruction or mfence. I will try to get 
> the SDM updated.

Fair enough!

	Ingo
