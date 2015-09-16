From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] barriers: introduce smp_mb__release_acquire and update
 documentation
Date: Wed, 16 Sep 2015 12:07:06 +0100
Message-ID: <20150916110706.GF28771@arm.com>
References: <1442333610-16228-1-git-send-email-will.deacon@arm.com>
 <20150915174724.GP4029@linux.vnet.ibm.com>
 <20150916091452.GC3816@twins.programming.kicks-ass.net>
 <20150916102908.GA28771@arm.com>
 <20150916104314.GA3604@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150916104314.GA3604@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 16, 2015 at 11:43:14AM +0100, Peter Zijlstra wrote:
> On Wed, Sep 16, 2015 at 11:29:08AM +0100, Will Deacon wrote:
> > > Indeed, that is a hole in the definition, that I think we should close.
> 
> > I'm struggling to understand the hole, but here's my intuition. If an
> > ACQUIRE on CPUx reads from a RELEASE by CPUy, then I'd expect CPUx to
> > observe all memory accessed performed by CPUy prior to the RELEASE
> > before it observes the RELEASE itself, regardless of this new barrier.
> > I think this matches what we currently have in memory-barriers.txt (i.e.
> > acquire/release are neither transitive or multi-copy atomic).
> 
> Ah agreed. I seem to have gotten my brain in a tangle.
> 
> Basically where a program order release+acquire relies on an address
> dependency, a cross cpu release+acquire relies on causality. If we
> observe the release, we must also observe everything prior to it etc.

Yes, and crucially, the "everything prior to it" only encompasses accesses
made by the releasing CPU itself (in the absence of other barriers and
synchronisation).

Given that we managed to get confused, it doesn't hurt to call this out
explicitly in the doc, so I can add the following extra text.

Will

--->8

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 46a85abb77c6..794d102d06df 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1902,8 +1902,8 @@ the RELEASE would simply complete, thereby avoiding the deadlock.
 	a sleep-unlock race, but the locking primitive needs to resolve
 	such races properly in any case.
 
-If necessary, ordering can be enforced by use of an
-smp_mb__release_acquire() barrier:
+Where the RELEASE and ACQUIRE operations are performed by the same CPU,
+ordering can be enforced by use of an smp_mb__release_acquire() barrier:
 
 	*A = a;
 	RELEASE M
@@ -1916,6 +1916,10 @@ in which case, the only permitted sequences are:
 	STORE *A, RELEASE M, ACQUIRE N, STORE *B
 	STORE *A, ACQUIRE N, RELEASE M, STORE *B
 
+Note that smp_mb__release_acquire() has no effect on ACQUIRE or RELEASE
+operations performed by other CPUs, even if they are to the same variable.
+In cases where transitivity is required, smp_mb() should be used explicitly.
+
 Locks and semaphores may not provide any guarantee of ordering on UP compiled
 systems, and so cannot be counted on in such a situation to actually achieve
 anything at all - especially with respect to I/O accesses - unless combined
