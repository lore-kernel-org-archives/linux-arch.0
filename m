From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] Linux: Implement membarrier function
Date: Mon, 10 Dec 2018 10:25:16 -0800
Message-ID: <20181210182516.GV4170@linux.ibm.com>
References: <20181206215405.GL4170@linux.ibm.com>
 <Pine.LNX.4.44L0.1812101113430.1562-100000@iolanthe.rowland.org>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1812101113430.1562-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Goldblatt <davidtgoldblatt@gmail.com>, mathieu.desnoyers@efficios.com, Florian Weimer <fweimer@redhat.com>, triegel@redhat.com, libc-alpha@sourceware.org, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 10, 2018 at 11:22:31AM -0500, Alan Stern wrote:
> On Thu, 6 Dec 2018, Paul E. McKenney wrote:
> 
> > Hello, David,
> > 
> > I took a crack at extending LKMM to accommodate what I think would
> > support what you have in your paper.  Please see the very end of this
> > email for a patch against the "dev" branch of my -rcu tree.
> > 
> > This gives the expected result for the following three litmus tests,
> > but is probably deficient or otherwise misguided in other ways.  I have
> > added the LKMM maintainers on CC for their amusement.  ;-)
> > 
> > Thoughts?
> 
> Since sys_membarrier() provides a heavyweight barrier comparable to 
> synchronize_rcu(), the memory model should treat the two in the same 
> way.  That's what this patch does.
> 
> The corresponding critical section would be any region of code bounded
> by compiler barriers.  Since the LKMM doesn't currently handle plain
> accesses, the effect is the same as if a compiler barrier were present
> between each pair of instructions.  Basically, each instruction acts as
> its own critical section.  Therefore the patch below defines memb-rscsi
> as the trivial identity relation.  When plain accesses and compiler 
> barriers are added to the memory model, a different definition will be 
> needed.
> 
> This gives the correct results for the three C-Goldblat-memb-* litmus 
> tests in Paul's email.

Yow!!!

My first reaction was that this cannot possibly be correct because
sys_membarrier(), which is probably what we should call it, does not
wait for anything.  But your formulation has the corresponding readers
being "id", which as you say above is just a single event.

But what makes this work for the following litmus test?

------------------------------------------------------------------------

C membrcu

{
}

P0(intptr_t *x0, intptr_t *x1)
{
	WRITE_ONCE(*x0, 2);
	smp_memb();
	intptr_t r2 = READ_ONCE(*x1);
}


P1(intptr_t *x1, intptr_t *x2)
{
	WRITE_ONCE(*x1, 2);
	smp_memb();
	intptr_t r2 = READ_ONCE(*x2);
}


P2(intptr_t *x2, intptr_t *x3)
{
	WRITE_ONCE(*x2, 2);
	smp_memb();
	intptr_t r2 = READ_ONCE(*x3);
}


P3(intptr_t *x3, intptr_t *x4)
{
	rcu_read_lock();
	WRITE_ONCE(*x3, 2);
	intptr_t r2 = READ_ONCE(*x4);
	rcu_read_unlock();
}


P4(intptr_t *x4, intptr_t *x5)
{
	rcu_read_lock();
	WRITE_ONCE(*x4, 2);
	intptr_t r2 = READ_ONCE(*x5);
	rcu_read_unlock();
}


P5(intptr_t *x0, intptr_t *x5)
{
	rcu_read_lock();
	WRITE_ONCE(*x5, 2);
	intptr_t r2 = READ_ONCE(*x0);
	rcu_read_unlock();
}

exists
(5:r2=0 /\ 0:r2=0 /\ 1:r2=0 /\ 2:r2=0 /\ 3:r2=0 /\ 4:r2=0)

------------------------------------------------------------------------

For this, herd gives "Never".  Of course, if I reverse the write and
read in any of P3(), P4(), or P5(), I get "Sometimes", which does make
sense.  But what is preserving the order between P3() and P4() and
between P4() and P5()?  I am not immediately seeing how the analogy
with RCU carries over to this case.

							Thanx, Paul

> Alan
> 
> PS: The patch below is meant to apply on top of the SRCU patches, which
> are not yet in the mainline kernel.
> 
> 
> 
> Index: usb-4.x/tools/memory-model/linux-kernel.bell
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/linux-kernel.bell
> +++ usb-4.x/tools/memory-model/linux-kernel.bell
> @@ -24,6 +24,7 @@ instructions RMW[{'once,'acquire,'releas
>  enum Barriers = 'wmb (*smp_wmb*) ||
>  		'rmb (*smp_rmb*) ||
>  		'mb (*smp_mb*) ||
> +		'memb (*sys_membarrier*) ||
>  		'rcu-lock (*rcu_read_lock*)  ||
>  		'rcu-unlock (*rcu_read_unlock*) ||
>  		'sync-rcu (*synchronize_rcu*) ||
> Index: usb-4.x/tools/memory-model/linux-kernel.cat
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/linux-kernel.cat
> +++ usb-4.x/tools/memory-model/linux-kernel.cat
> @@ -33,7 +33,7 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
>  	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
>  	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
>  		fencerel(After-unlock-lock) ; [M])
> -let gp = po ; [Sync-rcu | Sync-srcu] ; po?
> +let gp = po ; [Sync-rcu | Sync-srcu | Memb] ; po?
>  
>  let strong-fence = mb | gp
>  
> @@ -102,8 +102,10 @@ acyclic pb as propagation
>   *)
>  let rcu-gp = [Sync-rcu]		(* Compare with gp *)
>  let srcu-gp = [Sync-srcu]
> +let memb-gp = [Memb]
>  let rcu-rscsi = rcu-rscs^-1
>  let srcu-rscsi = srcu-rscs^-1
> +let memb-rscsi = id
>  
>  (*
>   * The synchronize_rcu() strong fence is special in that it can order not
> @@ -119,15 +121,19 @@ let rcu-link = po? ; hb* ; pb* ; prop ;
>   * the synchronize_srcu() and srcu_read_[un]lock() calls refer to the same
>   * struct srcu_struct location.
>   *)
> -let rec rcu-fence = rcu-gp | srcu-gp |
> +let rec rcu-fence = rcu-gp | srcu-gp | memb-gp |
>  	(rcu-gp ; rcu-link ; rcu-rscsi) |
>  	((srcu-gp ; rcu-link ; srcu-rscsi) & loc) |
> +	(memb-gp ; rcu-link ; memb-rscsi) |
>  	(rcu-rscsi ; rcu-link ; rcu-gp) |
>  	((srcu-rscsi ; rcu-link ; srcu-gp) & loc) |
> +	(memb-rscsi ; rcu-link ; memb-gp) |
>  	(rcu-gp ; rcu-link ; rcu-fence ; rcu-link ; rcu-rscsi) |
>  	((srcu-gp ; rcu-link ; rcu-fence ; rcu-link ; srcu-rscsi) & loc) |
> +	(memb-gp ; rcu-link ; rcu-fence ; rcu-link ; memb-rscsi) |
>  	(rcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; rcu-gp) |
>  	((srcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; srcu-gp) & loc) |
> +	(memb-rscsi ; rcu-link ; rcu-fence ; rcu-link ; memb-gp) |
>  	(rcu-fence ; rcu-link ; rcu-fence)
>  
>  (* rb orders instructions just as pb does *)
> Index: usb-4.x/tools/memory-model/linux-kernel.def
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/linux-kernel.def
> +++ usb-4.x/tools/memory-model/linux-kernel.def
> @@ -20,6 +20,7 @@ smp_store_mb(X,V) { __store{once}(X,V);
>  smp_mb() { __fence{mb}; }
>  smp_rmb() { __fence{rmb}; }
>  smp_wmb() { __fence{wmb}; }
> +smp_memb() { __fence{memb}; }
>  smp_mb__before_atomic() { __fence{before-atomic}; }
>  smp_mb__after_atomic() { __fence{after-atomic}; }
>  smp_mb__after_spinlock() { __fence{after-spinlock}; }
> 
