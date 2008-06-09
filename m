From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 04/41] cpu ops: Core piece for generic atomic per cpu
 operations
Date: Mon, 9 Jun 2008 16:54:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0806091651390.9749@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com> <200806060959.13362.rusty@rustcorp.com.au>
 <Pine.LNX.4.64.0806091158020.30776@schroedinger.engr.sgi.com>
 <200806100927.48597.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:44690 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753190AbYFIXyK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 9 Jun 2008 19:54:10 -0400
In-Reply-To: <200806100927.48597.rusty@rustcorp.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Mike Travis <travis@sgi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>

On Tue, 10 Jun 2008, Rusty Russell wrote:

> > > Yes, this should be fixed.  I thought i386 had optimized versions
> > > pre-merge, but I was wrong (%gs for per-cpu came later, and noone cleaned
> > > up these naive versions).  Did you want me to write them?
> >
> > How can that be fixed? You have no atomic instruction that calculates the
> > per cpu address in one go.
> 
> Huh?  "incl %fs:varname" does exactly this.

Right that is what the cpu alloc patches do. So you could implement 
cpu_local_inc on top of some of the cpu alloc patches.

> > And as long as that is the case you need to 
> > disable preempt. Otherwise you may increment the per cpu variable of
> > another processor because the process was rescheduled after the address
> > was calculated but before the increment was done.
> 
> But of course, that is not a problem.  You make local_t an atomic_t, and then 
> it doesn't matter which CPU you incremented.

But then the whole point of local_t is gone. Why not use atomic_t in the 
first place?
 
> By definition if the caller cared, they would have had premption disabled.

There are numerous instances where the caller does not care about 
preemption. Its just important that one per cpu counter is increment in 
the least intrusive way. See f.e. the VM event counters.
