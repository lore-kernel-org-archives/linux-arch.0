From: Jamie Lokier <jamie@shareable.org>
Subject: Re: on memory barriers and cachelines
Date: Fri, 10 Feb 2012 02:51:29 +0000
Message-ID: <20120210025129.GA9135@jl-vm1.vm.bytemark.co.uk>
References: <1328088838.2760.21.camel@laptop>
 <20120201142218.GF2488@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:47021 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932381Ab2BJCvi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Feb 2012 21:51:38 -0500
Content-Disposition: inline
In-Reply-To: <20120201142218.GF2488@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, benh <benh@kernel.crashing.org>, davem <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, Linux-Arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, dhowells <dhowells@redhat.com>

Paul E. McKenney wrote:
> On Wed, Feb 01, 2012 at 10:33:58AM +0100, Peter Zijlstra wrote:
> > Hi all,
> > 
> > So I was talking to Paul yesterday and he mentioned how the SRCU sync
> > primitive has to use extra synchronize_sched() calls in order to avoid
> > smp_rmb() calls in the srcu_read_{un,}lock() calls.
> > 
> > Now memory barriers are usually explained as observable order between
> > two (or more) unrelated variables, as Documentation/memory-barriers.txt
> > does in great detail.
> > 
> > What I couldn't find in there though, is what happens when both
> > variables are on the same cacheline. The "The effects of the CPU cache"
> > and "Cache coherency" sections are closest but leave me wanting on this
> > point.
> > 
> > Can we get some implicit behaviour from being on the same cacheline? Or
> > can this memory access queue still totally wreck the game?
> 
> I don't know of any guarantees in this area, but am checking with
> hardware architects for a couple of architectures.

On a related note:

   - What's to stop the compiler optimising away a data dependency,
     converting it to a speculative control dependency?  Here's a
     contrived example:

         ORIGINAL:

             int func(int *p)
             {
                 int index = p[0], first = p[1];
                 read_barrier_depends(); /* do..while(0) on most archs */
		 return max(first, p[index]);
             }

         OPTIMISED:

             int func(int *p)
             {
                 int index = p[0], val = p[1];
                 if (index != 1)
                     val = max(val, p[index]);
                 return val;
             }

     A quick search of the GCC manual for "speculation" and
     "speculative" comes up with quite a few hits.  I've no idea if
     they are relevant.

   - If I understood correctly, IA64 has explicit special registers to
     assist data-memory speculation by the compiler.  These would be
     the ALAT registers.  I don't know if they are used in a way that
     affects RCU, but they do appear in the GCC machine description,
     and in the manual some kinds of "data speculative scheduling" are
     enabled by default.  But read_barrier_depends() is a do {} while
     on IA64.

   - The GCC manual mentions data speculation in conjunction with
     Blackfin as well.  I have no idea if it's relevant, but Blackfin
     does at least define read_barrier_depends() in an interesting way,
     sometimes.

   - I read that ARM can do speculative memory loads these days.  It
     complicates DMA.  But are they implemented by speculative
     preloading into the cache, or by speculatively executing load
     instructions whose results are predicated on a control path
     taken?  If the latter, is an empty read_barrier_depends() still
     ok on ARM?

Thanks,
-- Jamie
