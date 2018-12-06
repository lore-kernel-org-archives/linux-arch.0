From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] Linux: Implement membarrier function
Date: Thu, 6 Dec 2018 13:54:05 -0800
Message-ID: <20181206215405.GL4170@linux.ibm.com>
References: <8736rldyzm.fsf@oldenburg.str.redhat.com>
 <1543444466.5493.220.camel@redhat.com>
 <87y39c2dsg.fsf@oldenburg.str.redhat.com>
 <1689938209.14804.1543502662882.JavaMail.zimbra@efficios.com>
 <20181129150433.GH4170@linux.ibm.com>
 <CAHD6eXcvx1bskbp-X+vuMYoMQiCLOt0PiCZ5FT1yFsda9Ud-yA@mail.gmail.com>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <libc-alpha-return-98065-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
Content-Disposition: inline
In-Reply-To: <CAHD6eXcvx1bskbp-X+vuMYoMQiCLOt0PiCZ5FT1yFsda9Ud-yA@mail.gmail.com>
To: David Goldblatt <davidtgoldblatt@gmail.com>
Cc: mathieu.desnoyers@efficios.com, Florian Weimer <fweimer@redhat.com>, triegel@redhat.com, libc-alpha@sourceware.org, stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hello, David,

I took a crack at extending LKMM to accommodate what I think would
support what you have in your paper.  Please see the very end of this
email for a patch against the "dev" branch of my -rcu tree.

This gives the expected result for the following three litmus tests,
but is probably deficient or otherwise misguided in other ways.  I have
added the LKMM maintainers on CC for their amusement.  ;-)

Thoughts?

						Thanx, Paul

------------------------------------------------------------------------

C C-Goldblat-memb-1
{
}

P0(int *x0, int *x1)
{
	WRITE_ONCE(*x0, 1);
	r1 = READ_ONCE(*x1);
}


P1(int *x0, int *x1)
{
	WRITE_ONCE(*x1, 1);
	smp_memb();
	r2 = READ_ONCE(*x0);
}

exists (0:r1=0 /\ 1:r2=0)

------------------------------------------------------------------------

C C-Goldblat-memb-2
{
}

P0(int *x0, int *x1)
{
	WRITE_ONCE(*x0, 1);
	r1 = READ_ONCE(*x1);
}


P1(int *x1, int *x2)
{
	WRITE_ONCE(*x1, 1);
	smp_memb();
	r1 = READ_ONCE(*x2);
}

P2(int *x2, int *x0)
{
	WRITE_ONCE(*x2, 1);
	r1 = READ_ONCE(*x0);
}

exists (0:r1=0 /\ 1:r1=0 /\ 2:r1=0)

------------------------------------------------------------------------

C C-Goldblat-memb-3
{
}

P0(int *x0, int *x1)
{
	WRITE_ONCE(*x0, 1);
	r1 = READ_ONCE(*x1);
}


P1(int *x1, int *x2)
{
	WRITE_ONCE(*x1, 1);
	smp_memb();
	r1 = READ_ONCE(*x2);
}

P2(int *x2, int *x3)
{
	WRITE_ONCE(*x2, 1);
	r1 = READ_ONCE(*x3);
}

P3(int *x3, int *x0)
{
	WRITE_ONCE(*x3, 1);
	smp_memb();
	r1 = READ_ONCE(*x0);
}

exists (0:r1=0 /\ 1:r1=0 /\ 2:r1=0 /\ 3:r1=0)

------------------------------------------------------------------------

On Thu, Nov 29, 2018 at 11:02:17AM -0800, David Goldblatt wrote:
> One note with the suggested patch is that
> `atomic_thread_fence(memory_order_acq_rel)` should probably be
> `atomic_thread_fence (memory_order_seq_cst)` (otherwise the call would
> be a no-op on, say, x86, which it very much isn't).
> 
> The non-transitivity thing makes the resulting description arguably
> incorrect, but this is informal enough that it might not be a big deal
> to add something after "For these threads, the membarrier function
> call turns an existing compiler barrier (see above) executed by these
> threads into full memory barriers" that clarifies it. E.g. you could
> make it into "turns an existing compiler barrier [...] into full
> memory barriers, with respect to the calling thread".
> 
> Since this is targeting the description of the OS call (and doesn't
> have to concern itself with also being implementable by other
> asymmetric techniques or degrading to architectural barriers), I think
> that the description in "approach 2" in P1202 would also make sense
> for a formal description of the syscall. (Of course, without the
> kernel itself committing to a rigorous semantics, anything specified
> on top of it will be on slightly shaky ground).
> 
> - David
> 
> On Thu, Nov 29, 2018 at 7:04 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> >
> > On Thu, Nov 29, 2018 at 09:44:22AM -0500, Mathieu Desnoyers wrote:
> > > ----- On Nov 29, 2018, at 8:50 AM, Florian Weimer fweimer@redhat.com wrote:
> > >
> > > > * Torvald Riegel:
> > > >
> > > >> On Wed, 2018-11-28 at 16:05 +0100, Florian Weimer wrote:
> > > >>> This is essentially a repost of last year's patch, rebased to the glibc
> > > >>> 2.29 symbol version and reflecting the introduction of
> > > >>> MEMBARRIER_CMD_GLOBAL.
> > > >>>
> > > >>> I'm not including any changes to manual/ here because the set of
> > > >>> supported operations is evolving rapidly, we could not get consensus for
> > > >>> the language I proposed the last time, and I do not want to contribute
> > > >>> to the manual for the time being.
> > > >>
> > > >> Fair enough.  Nonetheless, can you summarize how far you're along with
> > > >> properly defining the semantics (eg, based on the C/C++ memory model)?
> > > >
> > > > I wrote down what you could, but no one liked it.
> > > >
> > > > <https://sourceware.org/ml/libc-alpha/2017-12/msg00796.html>
> > > >
> > > > I expect that a formalization would interact in non-trivial ways with
> > > > any potential formalization of usable relaxed memory order semantics,
> > > > and I'm not sure if anyone knows how to do the latter today.
> > >
> > > Adding Paul E. McKenney in CC.
> >
> > There is some prototype C++ memory model wording from David Goldblatt (CCed)
> > here (search for "Standarese"):
> >
> > http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p1202r0.pdf
> >
> > David's key insight is that (in Linuxese) light fences cannot pair with
> > each other.

------------------------------------------------------------------------

commit 17e3b6b60e57d1cb791f68a1a6a36e942cb2baad
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Thu Dec 6 13:40:40 2018 -0800

    EXP tools/memory-model: Add semantics for sys_membarrier()
    
    This prototype commit extends LKMM to accommodate sys_membarrier(),
    which is a asymmetric barrier with a limited ability to insert full
    ordering into tasks that provide only compiler ordering.  This commit
    currently uses the "po" relation for this purpose, but something more
    sophisticated will be required when plain accesses are added, which
    the compiler can reorder.
    
    For more detail, please see David Goldblatt's C++ working paper:
    http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p1202r0.pdf
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 9c42cd9ddcb4..4ef41453f569 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -24,6 +24,7 @@ instructions RMW[{'once,'acquire,'release}]
 enum Barriers = 'wmb (*smp_wmb*) ||
 		'rmb (*smp_rmb*) ||
 		'mb (*smp_mb*) ||
+		'memb (*sys_membarrier*) ||
 		'rcu-lock (*rcu_read_lock*)  ||
 		'rcu-unlock (*rcu_read_unlock*) ||
 		'sync-rcu (*synchronize_rcu*) ||
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 8dcb37835b61..837c3ee20bea 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -33,9 +33,10 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
 	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
 	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
 		fencerel(After-unlock-lock) ; [M])
+let memb = [M] ; fencerel(Memb) ; [M]
 let gp = po ; [Sync-rcu | Sync-srcu] ; po?
 
-let strong-fence = mb | gp
+let strong-fence = mb | gp | memb
 
 (* Release Acquire *)
 let acq-po = [Acquire] ; po ; [M]
@@ -86,6 +87,13 @@ acyclic hb as happens-before
 let pb = prop ; strong-fence ; hb*
 acyclic pb as propagation
 
+(********************)
+(* sys_membarrier() *)
+(********************)
+
+let memb-step = ( prop ; po ; prop )? ; memb
+acyclic memb-step as memb-before
+
 (*******)
 (* RCU *)
 (*******)
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 1d6a120cde14..9ff0691c5f2c 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -17,6 +17,7 @@ rcu_dereference(X) __load{once}(X)
 smp_store_mb(X,V) { __store{once}(X,V); __fence{mb}; }
 
 // Fences
+smp_memb() { __fence{memb}; }
 smp_mb() { __fence{mb}; }
 smp_rmb() { __fence{rmb}; }
 smp_wmb() { __fence{wmb}; }
