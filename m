From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 04/41] cpu ops: Core piece for generic atomic per cpu operations
Date: Tue, 10 Jun 2008 12:56:31 +1000
Message-ID: <200806101256.31615.rusty@rustcorp.com.au>
References: <20080530035620.587204923@sgi.com> <200806100927.48597.rusty@rustcorp.com.au> <Pine.LNX.4.64.0806091651390.9749@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:43668 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753266AbYFJC4q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 9 Jun 2008 22:56:46 -0400
In-Reply-To: <Pine.LNX.4.64.0806091651390.9749@schroedinger.engr.sgi.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Mike Travis <travis@sgi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>

On Tuesday 10 June 2008 09:54:09 Christoph Lameter wrote:
> On Tue, 10 Jun 2008, Rusty Russell wrote:
> > > > Yes, this should be fixed.  I thought i386 had optimized versions
> > > > pre-merge, but I was wrong (%gs for per-cpu came later, and noone
> > > > cleaned up these naive versions).  Did you want me to write them?
> > >
> > > How can that be fixed? You have no atomic instruction that calculates
> > > the per cpu address in one go.
> >
> > Huh?  "incl %fs:varname" does exactly this.
>
> Right that is what the cpu alloc patches do. So you could implement
> cpu_local_inc on top of some of the cpu alloc patches.

Or you could just implement it today as a standalone patch.

> > > And as long as that is the case you need to
> > > disable preempt. Otherwise you may increment the per cpu variable of
> > > another processor because the process was rescheduled after the address
> > > was calculated but before the increment was done.
> >
> > But of course, that is not a problem.  You make local_t an atomic_t, and
> > then it doesn't matter which CPU you incremented.
>
> But then the whole point of local_t is gone. Why not use atomic_t in the
> first place?

Because some archs can do better.

> > By definition if the caller cared, they would have had premption
> > disabled.
>
> There are numerous instances where the caller does not care about
> preemption. Its just important that one per cpu counter is increment in
> the least intrusive way. See f.e. the VM event counters.

Yes, and that's exactly the point.  The VM event counters are exactly a case 
where you should have used cpu_local_inc.

Rusty.
