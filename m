From: Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Date: Thu, 30 Aug 2018 14:50:45 +0200
Message-ID: <20180830125045.GA6936@andrea>
References: <20180829211018.GA19646@linux.vnet.ibm.com>
 <20180829211053.20531-1-paulmck@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180829211053.20531-1-paulmck@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 29, 2018 at 02:10:47PM -0700, Paul E. McKenney wrote:
> From: Alan Stern <stern@rowland.harvard.edu>
> 
> More than one kernel developer has expressed the opinion that the LKMM
> should enforce ordering of writes by locking.  In other words, given
> the following code:
> 
> 	WRITE_ONCE(x, 1);
> 	spin_unlock(&s):
> 	spin_lock(&s);
> 	WRITE_ONCE(y, 1);
> 
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
> All the architectures supported by the Linux kernel (including RISC-V)
> do provide this ordering for locks, albeit for varying reasons.
> Therefore this patch changes the model in accordance with the
> developers' wishes.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Reviewed-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Round 2 ;-), I guess...  Let me start from the uncontroversial points:

  1) being able to use the LKMM to reason about generic locking code
     is useful and desirable (paraphrasing Peter in [1]);

  2) strengthening the ordering requirements of such code isn't going
     to boost performance (that's "real maths").

This patch is taking (1) away from us and it is formalizing (2), with
almost _no_ reason (no reason at all, if we stick to the commit msg.).

In [2], Will wrote:

  "[...] having them [the RMWs] closer to RCsc[/to the semantics of
   locks] would make it easier to implement and reason about generic
   locking implementations (i.e. reduce the number of special ordering
   cases and/or magic barrier macros)"

"magic barrier macros" as in "mmh, if we accept this patch, we _should_
be auditing the various implementations/code to decide where to place a

  smp_barrier_promote_ordinary_release_acquire_to_unlock_lock()" ;-)

or the like, and "special ordering cases" as in "arrgh, (otherwise) we
are forced to reason on a per-arch basis while looking at generic code".

(Remark: ordinary release/acquire are building blocks for code such as
 qspinlock, (q)rwlock, mutex, rwsem, ... and what else??).

To avoid further repetition, I conclude by confirming all the concerns
and my assessment of this patch as pointed out in [3]; the subsequent
discussion, although not conclusive, presented several suggestions for
improvement (IMO).

  Andrea

[1] http://lkml.kernel.org/r/20180712134821.GT2494@hirez.programming.kicks-ass.net
[2] http://lkml.kernel.org/r/20180713093524.GC32020@arm.com
[3] http://lkml.kernel.org/r/20180710093821.GA5414@andrea
    http://lkml.kernel.org/r/20180711161717.GA14635@andrea


> ---
>  .../Documentation/explanation.txt             | 186 ++++++++++++++----
>  tools/memory-model/linux-kernel.cat           |   8 +-
>  ...ISA2+pooncelock+pooncelock+pombonce.litmus |   7 +-
>  3 files changed, 150 insertions(+), 51 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index 0cbd1ef8f86d..35bff92cc773 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -28,7 +28,8 @@ Explanation of the Linux-Kernel Memory Consistency Model
>    20. THE HAPPENS-BEFORE RELATION: hb
>    21. THE PROPAGATES-BEFORE RELATION: pb
>    22. RCU RELATIONS: rcu-link, gp, rscs, rcu-fence, and rb
> -  23. ODDS AND ENDS
> +  23. LOCKING
> +  24. ODDS AND ENDS
>  
>  
>  
> @@ -1067,28 +1068,6 @@ allowing out-of-order writes like this to occur.  The model avoided
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
> @@ -1766,6 +1745,147 @@ before it does, and the critical section in P2 both starts after P1's
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
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 59b5cbe6b624..882fc33274ac 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
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
> diff --git a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> index 0f749e419b34..094d58df7789 100644
> --- a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> +++ b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
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
> -- 
> 2.17.1
> 
