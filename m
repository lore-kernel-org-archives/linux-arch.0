From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: on memory barriers and cachelines
Date: Fri, 10 Feb 2012 08:32:52 -0800
Message-ID: <20120210163252.GG2458@linux.vnet.ibm.com>
References: <1328088838.2760.21.camel@laptop>
 <20120201142218.GF2488@linux.vnet.ibm.com>
 <20120210025129.GA9135@jl-vm1.vm.bytemark.co.uk>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:45269 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308Ab2BJQdT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Feb 2012 11:33:19 -0500
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 10 Feb 2012 09:33:17 -0700
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com [9.17.195.107])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id CEA273E40036
	for <linux-arch@vger.kernel.org>; Fri, 10 Feb 2012 09:33:14 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q1AGWu0n105496
	for <linux-arch@vger.kernel.org>; Fri, 10 Feb 2012 09:33:01 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q1AGWriU002219
	for <linux-arch@vger.kernel.org>; Fri, 10 Feb 2012 09:32:55 -0700
Content-Disposition: inline
In-Reply-To: <20120210025129.GA9135@jl-vm1.vm.bytemark.co.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, benh <benh@kernel.crashing.org>, davem <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, Linux-Arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, dhowells <dhowells@redhat.com>

On Fri, Feb 10, 2012 at 02:51:29AM +0000, Jamie Lokier wrote:
> Paul E. McKenney wrote:
> > On Wed, Feb 01, 2012 at 10:33:58AM +0100, Peter Zijlstra wrote:
> > > Hi all,
> > > 
> > > So I was talking to Paul yesterday and he mentioned how the SRCU sync
> > > primitive has to use extra synchronize_sched() calls in order to avoid
> > > smp_rmb() calls in the srcu_read_{un,}lock() calls.
> > > 
> > > Now memory barriers are usually explained as observable order between
> > > two (or more) unrelated variables, as Documentation/memory-barriers.txt
> > > does in great detail.
> > > 
> > > What I couldn't find in there though, is what happens when both
> > > variables are on the same cacheline. The "The effects of the CPU cache"
> > > and "Cache coherency" sections are closest but leave me wanting on this
> > > point.
> > > 
> > > Can we get some implicit behaviour from being on the same cacheline? Or
> > > can this memory access queue still totally wreck the game?
> > 
> > I don't know of any guarantees in this area, but am checking with
> > hardware architects for a couple of architectures.
> 
> On a related note:
> 
>    - What's to stop the compiler optimising away a data dependency,
>      converting it to a speculative control dependency?  Here's a
>      contrived example:
> 
>          ORIGINAL:
> 
>              int func(int *p)
>              {
>                  int index = p[0], first = p[1];
>                  read_barrier_depends(); /* do..while(0) on most archs */
> 		 return max(first, p[index]);
>              }
> 
>          OPTIMISED:
> 
>              int func(int *p)
>              {
>                  int index = p[0], val = p[1];
>                  if (index != 1)
>                      val = max(val, p[index]);
>                  return val;
>              }
> 
>      A quick search of the GCC manual for "speculation" and
>      "speculative" comes up with quite a few hits.  I've no idea if
>      they are relevant.

Well, that would be one reason why I did all that work to get
memory_order_consume into C++11.  ;-)

More seriously, you can defeat some of the speculative optimizations
by using ACCESS_ONCE():

                 int index = ACCESS_ONCE(p[0]), first = ACCESS_ONCE(p[1]);

This forces a volatile access which should make the compiler at least
a bit more reluctant to apply speculation optimizations.  And using
rcu_dereference_index_check() in the kernel packages the ACCESS_ONCE()
and the smp_read_barrier_depends().

>    - If I understood correctly, IA64 has explicit special registers to
>      assist data-memory speculation by the compiler.  These would be
>      the ALAT registers.  I don't know if they are used in a way that
>      affects RCU, but they do appear in the GCC machine description,
>      and in the manual some kinds of "data speculative scheduling" are
>      enabled by default.  But read_barrier_depends() is a do {} while
>      on IA64.

As I understand it, the ALAT registers do respect dependency ordering.
But you would need to talk to an IA64 hardware architect and an IA64
compiler expert to get the whole story.

>    - The GCC manual mentions data speculation in conjunction with
>      Blackfin as well.  I have no idea if it's relevant, but Blackfin
>      does at least define read_barrier_depends() in an interesting way,
>      sometimes.

Are there SMP blackfin systems now?  There were not last I checked,
and these issues matter only on SMP.

>    - I read that ARM can do speculative memory loads these days.  It
>      complicates DMA.  But are they implemented by speculative
>      preloading into the cache, or by speculatively executing load
>      instructions whose results are predicated on a control path
>      taken?  If the latter, is an empty read_barrier_depends() still
>      ok on ARM?

But ARM does guarantee dependency ordering, so whatever it does to
speculate, it must validate -- the results must be as if the hardware
had done no speculation.

							Thanx, Paul
