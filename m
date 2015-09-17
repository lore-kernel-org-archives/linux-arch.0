From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] barriers: introduce smp_mb__release_acquire and update
 documentation
Date: Thu, 17 Sep 2015 19:00:01 +0100
Message-ID: <20150917180001.GR25634@arm.com>
References: <1442333610-16228-1-git-send-email-will.deacon@arm.com>
 <20150915174724.GP4029@linux.vnet.ibm.com>
 <20150916091452.GC3816@twins.programming.kicks-ass.net>
 <20150916102908.GA28771@arm.com>
 <20150916104314.GA3604@twins.programming.kicks-ass.net>
 <20150916110706.GF28771@arm.com>
 <20150917025012.GB4000@fixme-laptop.cn.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42769 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666AbbIQR76 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Sep 2015 13:59:58 -0400
Content-Disposition: inline
In-Reply-To: <20150917025012.GB4000@fixme-laptop.cn.ibm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Sep 17, 2015 at 03:50:12AM +0100, Boqun Feng wrote:
> On Wed, Sep 16, 2015 at 12:07:06PM +0100, Will Deacon wrote:
> > On Wed, Sep 16, 2015 at 11:43:14AM +0100, Peter Zijlstra wrote:
> > > On Wed, Sep 16, 2015 at 11:29:08AM +0100, Will Deacon wrote:
> > > > > Indeed, that is a hole in the definition, that I think we should close.
> > > 
> > > > I'm struggling to understand the hole, but here's my intuition. If an
> > > > ACQUIRE on CPUx reads from a RELEASE by CPUy, then I'd expect CPUx to
> > > > observe all memory accessed performed by CPUy prior to the RELEASE
> > > > before it observes the RELEASE itself, regardless of this new barrier.
> > > > I think this matches what we currently have in memory-barriers.txt (i.e.
> > > > acquire/release are neither transitive or multi-copy atomic).
> > > 
> > > Ah agreed. I seem to have gotten my brain in a tangle.
> > > 
> > > Basically where a program order release+acquire relies on an address
> > > dependency, a cross cpu release+acquire relies on causality. If we
> > > observe the release, we must also observe everything prior to it etc.
> > 
> > Yes, and crucially, the "everything prior to it" only encompasses accesses
> > made by the releasing CPU itself (in the absence of other barriers and
> > synchronisation).
> > 
> 
> Just want to make sure I understand you correctly, do you mean that in
> the following case:
> 
> CPU 1			CPU 2				CPU 3
> ==============		============================	===============
> { A = 0, B = 0 }
> WRITE_ONCE(A,1);	r1 = READ_ONCE(A);		r2 = smp_load_acquire(&B);
> 			smp_store_release(&B, 1);	r3 = READ_ONCE(A);
> 
> r1 == 1 && r2 == 1 && r3 == 0 is not prohibitted?
> 
> However, according to the discussion of Paul and Peter:
> 
> https://lkml.org/lkml/2015/9/15/707
> 
> I think that's prohibitted on architectures except s390 for sure. And
> for s390, we are waiting for the maintainers to verify this. If s390
> also prohibits this, then a release-acquire pair(on different CPUs) to
> the same variable does guarantee transitivity.
> 
> Did I misunderstand you or miss something here?

That certainly works on arm and arm64, so if it works everywhere else too,
then we can strengthen this (but see below).

> > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > index 46a85abb77c6..794d102d06df 100644
> > --- a/Documentation/memory-barriers.txt
> > +++ b/Documentation/memory-barriers.txt
> > @@ -1902,8 +1902,8 @@ the RELEASE would simply complete, thereby avoiding the deadlock.
> >  	a sleep-unlock race, but the locking primitive needs to resolve
> >  	such races properly in any case.
> >  
> > -If necessary, ordering can be enforced by use of an
> > -smp_mb__release_acquire() barrier:
> > +Where the RELEASE and ACQUIRE operations are performed by the same CPU,
> > +ordering can be enforced by use of an smp_mb__release_acquire() barrier:
> >  
> >  	*A = a;
> >  	RELEASE M
> > @@ -1916,6 +1916,10 @@ in which case, the only permitted sequences are:
> >  	STORE *A, RELEASE M, ACQUIRE N, STORE *B
> >  	STORE *A, ACQUIRE N, RELEASE M, STORE *B
> >  
> > +Note that smp_mb__release_acquire() has no effect on ACQUIRE or RELEASE
> > +operations performed by other CPUs, even if they are to the same variable.
> > +In cases where transitivity is required, smp_mb() should be used explicitly.
> > +
> 
> Then, IIRC, the memory order effect of RELEASE+ACQUIRE should be:

[updated from your reply]

> If an ACQUIRE loads the value of stored by a RELEASE, then after the
> ACQUIRE operation, the CPU executing the ACQUIRE operation will perceive
> all the memory operations that have been perceived by the CPU executing
> the RELEASE operation before the RELEASE operation. 
> 
> Which means a release+acquire pair to the same variable guarantees
> transitivity.

Almost, but on arm64 at least, "all the memory operations" above doesn't
include reads by other CPUs. I'm struggling to figure out whether that's
actually an issue.

Will
