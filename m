From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 09:47:48 -0700
Message-ID: <20171011164748.GK3521@linux.vnet.ibm.com>
References: <20171011122217.GD11106@arm.com>
 <20171010155042.GD3521@linux.vnet.ibm.com>
 <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010001951.GA6476@linux.vnet.ibm.com>
 <8079.1507628146@warthog.procyon.org.uk>
 <26455.1507724399@warthog.procyon.org.uk>
 <6309.1507735045@warthog.procyon.org.uk>
 <20171011155948.GE3521@linux.vnet.ibm.com>
 <20171011161220.zqkdhynxerrcmvdd@hirez.programming.kicks-ass.net>
 <20171011162412.o6lmjiag7spwabge@hirez.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751659AbdJKQrz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Oct 2017 12:47:55 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9BGhnkD124123
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2017 12:47:54 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dhpgs1wp7-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 11 Oct 2017 12:47:54 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Oct 2017 12:47:54 -0400
Content-Disposition: inline
In-Reply-To: <20171011162412.o6lmjiag7spwabge@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>, dvyukov@google.com

On Wed, Oct 11, 2017 at 06:24:12PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 11, 2017 at 06:12:20PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 11, 2017 at 08:59:48AM -0700, Paul E. McKenney wrote:
> > > On Wed, Oct 11, 2017 at 04:17:25PM +0100, David Howells wrote:
> > > > I will, however, quibble with the appropriateness of the name READ_ONCE()...
> > > > I still think it's not sufficiently obvious that this is a barrier and the
> > > > barrier is after.  Maybe READ_AND_BARRIER()?
> > > 
> > > Linus was unhappy with READ_ONCE_CTRL() to tag control dependencies, but
> > > indicated that he might consider it if it helped code-analysis tools.
> > > Adding Dmitry Vyukov for his thoughts on whether tagging READ_ONCE()
> > > for dependencies would help.  Me, I would suggest READ_ONCE_DEP(), but
> > > let's figure out if the bikeshed needs to be painted before arguing over
> > > the color.  ;-)
> > 
> > Count me one vote for the READ_ONCE() name. This is about dependent
> > reads, which are nothing special on anything except Alpha.
> > 
> > We want to remove the exception/specialness from the memory model; and
> > therefore have to fix up all primitives that could possibly be used for
> > these reads to unconditionally issue the barrier (on Alpha). The
> > alternative is: rm -rf arch/alpha.
> > 
> > Adding something like READ_ONCE_DEP() does not rid us of the idea that
> > dependent reads are special and thus defeats the purpose, we might as
> > well retain lockless_dereference().
> > 
> > Now; any user of dependent reads must use READ_ONCE() in any case, to
> > avoid load tearing and reloads. So using READ_ONCE() for the dependent
> > reads is not extra or additional (note we'll also have to add the
> > barrier to all our relaxed and release atomics and anything else that
> > implies READ_ONCE and doesn't already imply smp_mb() after).
> 
> Add the per-cpu ops to that list, they imply READ_ONCE(). Consider for
> example this example:
> 
> 
> 	for_each_possible_cpu(cpu)
> 		smp_store_release(per_cpu_ptr(&foo, cpu), obj);
> 
> -vs-
> 
> 	obj = this_cpu_read(foo);
> 	if (obj->ponies)
> 		fart_rainbow(obj);

Interesting.  Do we currently have any dependencies headed by
this_cpu_read()?

							Thanx, Paul
