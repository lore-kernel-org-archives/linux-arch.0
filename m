From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Sat, 31 May 2008 20:27:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0805312026000.20941@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com>  <1212138752.12349.227.camel@twins>
  <Pine.LNX.4.64.0805301101490.14564@schroedinger.engr.sgi.com>
 <1212171574.24826.12.camel@lappy.programming.kicks-ass.net>
 <Pine.LNX.4.64.0805301126130.14781@schroedinger.engr.sgi.com>
 <1212173236.24826.29.camel@lappy.programming.kicks-ass.net>
 <Pine.LNX.4.64.0805301156530.16253@schroedinger.engr.sgi.com>
 <1212175315.24826.49.camel@lappy.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:45703 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753658AbYFAD1z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 31 May 2008 23:27:55 -0400
In-Reply-To: <1212175315.24826.49.camel@lappy.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

On Fri, 30 May 2008, Peter Zijlstra wrote:

> > > Also, it explicitly ties the preempt-off section to the data used in
> > > case of !rt, which in turn allows for the direct conversion to the
> > > locked version.
> > 
> > Ahh. Okay. This would make the lockless preemptless fastpath impossible 
> > because it would have to use some sort of locking to avoid access to the 
> > same percpu data from multiple processor?
> 
> TBH its been a while since I attempted slub-rt, but yes that got hairy.
> I think it can be done using cmpxchg and speculative page refs, but I
> can't quite recall.

Uhhh... Well I think you really need two different percpu sections. One 
that works like the upstream percpu section and another where it works 
with a spinlock. Basically its like a struct protected by an extra lock.

The one with a spinlock could not support the atomic percpu ops.
