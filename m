Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725907AbeIOJOM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 15 Sep 2018 05:14:12 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8F3rXxV008863
        for <linux-arch@vger.kernel.org>; Fri, 14 Sep 2018 23:56:42 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mgnrayudy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 14 Sep 2018 23:56:42 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 14 Sep 2018 23:56:41 -0400
Date: Fri, 14 Sep 2018 20:56:34 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH v5] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Reply-To: paulmck@linux.ibm.com
References: <20180914143752.GA7467@andrea>
 <Pine.LNX.4.44L0.1809141706310.1482-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1809141706310.1482-100000@iolanthe.rowland.org>
Message-ID: <20180915035634.GU652@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, Will Deacon <will.deacon@arm.com>, Kernel development list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, akiyks@gmail.com, Palmer Dabbelt <palmer@sifive.com>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20180915035634.XEv4eHtHJW7zV8EX3U1W5SUEqS_h3gAqyn_tBmThohQ@z>

On Fri, Sep 14, 2018 at 05:08:21PM -0400, Alan Stern wrote:
> More than one kernel developer has expressed the opinion that the LKMM
> should enforce ordering of writes by locking.  In other words, given
> the following code:
> 
> 	WRITE_ONCE(x, 1);
> 	spin_unlock(&s):
> 	spin_lock(&s);
> 	WRITE_ONCE(y, 1);

Applied and pushed, thank you all!

							Thanx, Paul

> the stores to x and y should be propagated in order to all other CPUs,
> even though those other CPUs might not access the lock s.  In terms of
> the memory model, this means expanding the cumul-fence relation.
> 
> Locks should also provide read-read (and read-write) ordering in a
> similar way.  Given:
> 
> 	READ_ONCE(x);
> 	spin_unlock(&s);
> 	spin_lock(&s);
> 	READ_ONCE(y);		// or WRITE_ONCE(y, 1);
> 
> the load of x should be executed before the load of (or store to) y.
> The LKMM already provides this ordering, but it provides it even in
> the case where the two accesses are separated by a release/acquire
> pair of fences rather than unlock/lock.  This would prevent
> architectures from using weakly ordered implementations of release and
> acquire, which seems like an unnecessary restriction.  The patch
> therefore removes the ordering requirement from the LKMM for that
> case.
> 
> There are several arguments both for and against this change.  Let us
> refer to these enhanced ordering properties by saying that the LKMM
> would require locks to be RCtso (a bit of a misnomer, but analogous to
> RCpc and RCsc) and it would require ordinary acquire/release only to
> be RCpc.  (Note: In the following, the phrase "all supported
> architectures" is meant not to include RISC-V.  Although RISC-V is
> indeed supported by the kernel, the implementation is still somewhat
> in a state of flux and therefore statements about it would be
> premature.)
> 
> Pros:
> 
> 	The kernel already provides RCtso ordering for locks on all
> 	supported architectures, even though this is not stated
> 	explicitly anywhere.  Therefore the LKMM should formalize it.
> 
> 	In theory, guaranteeing RCtso ordering would reduce the need
> 	for additional barrier-like constructs meant to increase the
> 	ordering strength of locks.
> 
> 	Will Deacon and Peter Zijlstra are strongly in favor of
> 	formalizing the RCtso requirement.  Linus Torvalds and Will
> 	would like to go even further, requiring locks to have RCsc
> 	behavior (ordering preceding writes against later reads), but
> 	they recognize that this would incur a noticeable performance
> 	degradation on the POWER architecture.  Linus also points out
> 	that people have made the mistake, in the past, of assuming
> 	that locking has stronger ordering properties than is
> 	currently guaranteed, and this change would reduce the
> 	likelihood of such mistakes.
> 
> 	Not requiring ordinary acquire/release to be any stronger than
> 	RCpc may prove advantageous for future architectures, allowing
> 	them to implement smp_load_acquire() and smp_store_release()
> 	with more efficient machine instructions than would be
> 	possible if the operations had to be RCtso.  Will and Linus
> 	approve this rationale, hypothetical though it is at the
> 	moment (it may end up affecting the RISC-V implementation).
> 	The same argument may or may not apply to RMW-acquire/release;
> 	see also the second Con entry below.
> 
> 	Linus feels that locks should be easy for people to use
> 	without worrying about memory consistency issues, since they
> 	are so pervasive in the kernel, whereas acquire/release is
> 	much more of an "experts only" tool.  Requiring locks to be
> 	RCtso is a step in this direction.
> 
> Cons:
> 
> 	Andrea Parri and Luc Maranget think that locks should have the
> 	same ordering properties as ordinary acquire/release (indeed,
> 	Luc points out that the names "acquire" and "release" derive
> 	from the usage of locks).  Andrea points out that having
> 	different ordering properties for different forms of acquires
> 	and releases is not only unnecessary, it would also be
> 	confusing and unmaintainable.
> 
> 	Locks are constructed from lower-level primitives, typically
> 	RMW-acquire (for locking) and ordinary release (for unlock).
> 	It is illogical to require stronger ordering properties from
> 	the high-level operations than from the low-level operations
> 	they comprise.  Thus, this change would make
> 
> 		while (cmpxchg_acquire(&s, 0, 1) != 0)
> 			cpu_relax();
> 
> 	an incorrect implementation of spin_lock(&s) as far as the
> 	LKMM is concerned.  In theory this weakness can be ameliorated
> 	by changing the LKMM even further, requiring
> 	RMW-acquire/release also to be RCtso (which it already is on
> 	all supported architectures).
> 
> 	As far as I know, nobody has singled out any examples of code
> 	in the kernel that actually relies on locks being RCtso.
> 	(People mumble about RCU and the scheduler, but nobody has
> 	pointed to any actual code.  If there are any real cases,
> 	their number is likely quite small.)  If RCtso ordering is not
> 	needed, why require it?
> 
> 	A handful of locking constructs (qspinlocks, qrwlocks, and
> 	mcs_spinlocks) are built on top of smp_cond_load_acquire()
> 	instead of an RMW-acquire instruction.  It currently provides
> 	only the ordinary acquire semantics, not the stronger ordering
> 	this patch would require of locks.  In theory this could be
> 	ameliorated by requiring smp_cond_load_acquire() in
> 	combination with ordinary release also to be RCtso (which is
> 	currently true on all supported architectures).
> 
> 	On future weakly ordered architectures, people may be able to
> 	implement locks in a non-RCtso fashion with significant
> 	performance improvement.  Meeting the RCtso requirement would
> 	necessarily add run-time overhead.
> 
> Overall, the technical aspects of these arguments seem relatively
> minor, and it appears mostly to boil down to a matter of opinion.
> Since the opinions of senior kernel maintainers such as Linus,
> Peter, and Will carry more weight than those of Luc and Andrea, this
> patch changes the model in accordance with the maintainers' wishes.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Reviewed-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> 
> ---
> 
> v.5: Incorporated feedback from Andrea regarding the updated Changelog.
> 
> v.4: Added pros and cons discussion to the Changelog.
> 
> v.3: Rebased against the dev branch of Paul's linux-rcu tree.
> Changed unlock-rf-lock-po to po-unlock-rf-lock-po, making it more
> symmetrical and more in accordance with the use of fence.tso for
> the release on RISC-V.
> 
> v.2: Restrict the ordering to lock operations, not general release
> and acquire fences.
> 
> 
> [as1871e]
> 
> 
>  tools/memory-model/Documentation/explanation.txt                           |  186 +++++++---
>  tools/memory-model/linux-kernel.cat                                        |    8 
>  tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus |    7 
>  3 files changed, 150 insertions(+), 51 deletions(-)
> 
> Index: usb-4.x/tools/memory-model/linux-kernel.cat
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/linux-kernel.cat
> +++ usb-4.x/tools/memory-model/linux-kernel.cat
> @@ -38,7 +38,7 @@ let strong-fence = mb | gp
>  (* Release Acquire *)
>  let acq-po = [Acquire] ; po ; [M]
>  let po-rel = [M] ; po ; [Release]
> -let rfi-rel-acq = [Release] ; rfi ; [Acquire]
> +let po-unlock-rf-lock-po = po ; [UL] ; rf ; [LKR] ; po
> 
>  (**********************************)
>  (* Fundamental coherence ordering *)
> @@ -60,13 +60,13 @@ let dep = addr | data
>  let rwdep = (dep | ctrl) ; [W]
>  let overwrite = co | fr
>  let to-w = rwdep | (overwrite & int)
> -let to-r = addr | (dep ; rfi) | rfi-rel-acq
> +let to-r = addr | (dep ; rfi)
>  let fence = strong-fence | wmb | po-rel | rmb | acq-po
> -let ppo = to-r | to-w | fence
> +let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
> 
>  (* Propagation: Ordering from release operations and strong fences. *)
>  let A-cumul(r) = rfe? ; r
> -let cumul-fence = A-cumul(strong-fence | po-rel) | wmb
> +let cumul-fence = A-cumul(strong-fence | po-rel) | wmb | po-unlock-rf-lock-po
>  let prop = (overwrite & ext)? ; cumul-fence* ; rfe?
> 
>  (*
> Index: usb-4.x/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> +++ usb-4.x/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> @@ -1,11 +1,10 @@
>  C ISA2+pooncelock+pooncelock+pombonce
> 
>  (*
> - * Result: Sometimes
> + * Result: Never
>   *
> - * This test shows that the ordering provided by a lock-protected S
> - * litmus test (P0() and P1()) are not visible to external process P2().
> - * This is likely to change soon.
> + * This test shows that write-write ordering provided by locks
> + * (in P0() and P1()) is visible to external process P2().
>   *)
> 
>  {}
> Index: usb-4.x/tools/memory-model/Documentation/explanation.txt
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/Documentation/explanation.txt
> +++ usb-4.x/tools/memory-model/Documentation/explanation.txt
> @@ -28,7 +28,8 @@ Explanation of the Linux-Kernel Memory C
>    20. THE HAPPENS-BEFORE RELATION: hb
>    21. THE PROPAGATES-BEFORE RELATION: pb
>    22. RCU RELATIONS: rcu-link, gp, rscs, rcu-fence, and rb
> -  23. ODDS AND ENDS
> +  23. LOCKING
> +  24. ODDS AND ENDS
> 
> 
> 
> @@ -1067,28 +1068,6 @@ allowing out-of-order writes like this t
>  violating the write-write coherence rule by requiring the CPU not to
>  send the W write to the memory subsystem at all!)
> 
> -There is one last example of preserved program order in the LKMM: when
> -a load-acquire reads from an earlier store-release.  For example:
> -
> -	smp_store_release(&x, 123);
> -	r1 = smp_load_acquire(&x);
> -
> -If the smp_load_acquire() ends up obtaining the 123 value that was
> -stored by the smp_store_release(), the LKMM says that the load must be
> -executed after the store; the store cannot be forwarded to the load.
> -This requirement does not arise from the operational model, but it
> -yields correct predictions on all architectures supported by the Linux
> -kernel, although for differing reasons.
> -
> -On some architectures, including x86 and ARMv8, it is true that the
> -store cannot be forwarded to the load.  On others, including PowerPC
> -and ARMv7, smp_store_release() generates object code that starts with
> -a fence and smp_load_acquire() generates object code that ends with a
> -fence.  The upshot is that even though the store may be forwarded to
> -the load, it is still true that any instruction preceding the store
> -will be executed before the load or any following instructions, and
> -the store will be executed before any instruction following the load.
> -
> 
>  AND THEN THERE WAS ALPHA
>  ------------------------
> @@ -1766,6 +1745,147 @@ before it does, and the critical section
>  grace period does and ends after it does.
> 
> 
> +LOCKING
> +-------
> +
> +The LKMM includes locking.  In fact, there is special code for locking
> +in the formal model, added in order to make tools run faster.
> +However, this special code is intended to be more or less equivalent
> +to concepts we have already covered.  A spinlock_t variable is treated
> +the same as an int, and spin_lock(&s) is treated almost the same as:
> +
> +	while (cmpxchg_acquire(&s, 0, 1) != 0)
> +		cpu_relax();
> +
> +This waits until s is equal to 0 and then atomically sets it to 1,
> +and the read part of the cmpxchg operation acts as an acquire fence.
> +An alternate way to express the same thing would be:
> +
> +	r = xchg_acquire(&s, 1);
> +
> +along with a requirement that at the end, r = 0.  Similarly,
> +spin_trylock(&s) is treated almost the same as:
> +
> +	return !cmpxchg_acquire(&s, 0, 1);
> +
> +which atomically sets s to 1 if it is currently equal to 0 and returns
> +true if it succeeds (the read part of the cmpxchg operation acts as an
> +acquire fence only if the operation is successful).  spin_unlock(&s)
> +is treated almost the same as:
> +
> +	smp_store_release(&s, 0);
> +
> +The "almost" qualifiers above need some explanation.  In the LKMM, the
> +store-release in a spin_unlock() and the load-acquire which forms the
> +first half of the atomic rmw update in a spin_lock() or a successful
> +spin_trylock() -- we can call these things lock-releases and
> +lock-acquires -- have two properties beyond those of ordinary releases
> +and acquires.
> +
> +First, when a lock-acquire reads from a lock-release, the LKMM
> +requires that every instruction po-before the lock-release must
> +execute before any instruction po-after the lock-acquire.  This would
> +naturally hold if the release and acquire operations were on different
> +CPUs, but the LKMM says it holds even when they are on the same CPU.
> +For example:
> +
> +	int x, y;
> +	spinlock_t s;
> +
> +	P0()
> +	{
> +		int r1, r2;
> +
> +		spin_lock(&s);
> +		r1 = READ_ONCE(x);
> +		spin_unlock(&s);
> +		spin_lock(&s);
> +		r2 = READ_ONCE(y);
> +		spin_unlock(&s);
> +	}
> +
> +	P1()
> +	{
> +		WRITE_ONCE(y, 1);
> +		smp_wmb();
> +		WRITE_ONCE(x, 1);
> +	}
> +
> +Here the second spin_lock() reads from the first spin_unlock(), and
> +therefore the load of x must execute before the load of y.  Thus we
> +cannot have r1 = 1 and r2 = 0 at the end (this is an instance of the
> +MP pattern).
> +
> +This requirement does not apply to ordinary release and acquire
> +fences, only to lock-related operations.  For instance, suppose P0()
> +in the example had been written as:
> +
> +	P0()
> +	{
> +		int r1, r2, r3;
> +
> +		r1 = READ_ONCE(x);
> +		smp_store_release(&s, 1);
> +		r3 = smp_load_acquire(&s);
> +		r2 = READ_ONCE(y);
> +	}
> +
> +Then the CPU would be allowed to forward the s = 1 value from the
> +smp_store_release() to the smp_load_acquire(), executing the
> +instructions in the following order:
> +
> +		r3 = smp_load_acquire(&s);	// Obtains r3 = 1
> +		r2 = READ_ONCE(y);
> +		r1 = READ_ONCE(x);
> +		smp_store_release(&s, 1);	// Value is forwarded
> +
> +and thus it could load y before x, obtaining r2 = 0 and r1 = 1.
> +
> +Second, when a lock-acquire reads from a lock-release, and some other
> +stores W and W' occur po-before the lock-release and po-after the
> +lock-acquire respectively, the LKMM requires that W must propagate to
> +each CPU before W' does.  For example, consider:
> +
> +	int x, y;
> +	spinlock_t x;
> +
> +	P0()
> +	{
> +		spin_lock(&s);
> +		WRITE_ONCE(x, 1);
> +		spin_unlock(&s);
> +	}
> +
> +	P1()
> +	{
> +		int r1;
> +
> +		spin_lock(&s);
> +		r1 = READ_ONCE(x);
> +		WRITE_ONCE(y, 1);
> +		spin_unlock(&s);
> +	}
> +
> +	P2()
> +	{
> +		int r2, r3;
> +
> +		r2 = READ_ONCE(y);
> +		smp_rmb();
> +		r3 = READ_ONCE(x);
> +	}
> +
> +If r1 = 1 at the end then the spin_lock() in P1 must have read from
> +the spin_unlock() in P0.  Hence the store to x must propagate to P2
> +before the store to y does, so we cannot have r2 = 1 and r3 = 0.
> +
> +These two special requirements for lock-release and lock-acquire do
> +not arise from the operational model.  Nevertheless, kernel developers
> +have come to expect and rely on them because they do hold on all
> +architectures supported by the Linux kernel, albeit for various
> +differing reasons.
> +
> +
>  ODDS AND ENDS
>  -------------
> 
> @@ -1831,26 +1951,6 @@ they behave as follows:
>  	events and the events preceding them against all po-later
>  	events.
> 
> -The LKMM includes locking.  In fact, there is special code for locking
> -in the formal model, added in order to make tools run faster.
> -However, this special code is intended to be exactly equivalent to
> -concepts we have already covered.  A spinlock_t variable is treated
> -the same as an int, and spin_lock(&s) is treated the same as:
> -
> -	while (cmpxchg_acquire(&s, 0, 1) != 0)
> -		cpu_relax();
> -
> -which waits until s is equal to 0 and then atomically sets it to 1,
> -and where the read part of the atomic update is also an acquire fence.
> -An alternate way to express the same thing would be:
> -
> -	r = xchg_acquire(&s, 1);
> -
> -along with a requirement that at the end, r = 0.  spin_unlock(&s) is
> -treated the same as:
> -
> -	smp_store_release(&s, 0);
> -
>  Interestingly, RCU and locking each introduce the possibility of
>  deadlock.  When faced with code sequences such as:
> 
> 
