From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Date: Fri, 14 Sep 2018 16:37:52 +0200
Message-ID: <20180914143752.GA7467@andrea>
References: <20180911200328.GA4225@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1809131300370.1382-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1809131300370.1382-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Daniel Lustig <dlustig@nvidia.com>, Will Deacon <will.deacon@arm.com>, Andrea Parri <parri.andrea@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, akiyks@gmail.com, Palmer Dabbelt <palmer@sifive.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 13, 2018 at 01:07:39PM -0400, Alan Stern wrote:
> Not having received any responses to the question about usages of RCtso
> locks, I have decided to post the newly updated version of the patch
> description for commit c8c5779c854f ("tools/memory-model: Add extra
> ordering for locks and remove it for ordinary release/acquire") in
> Paul's LKMM branch.  There are no changes to the patch itself.
> 
> Hopefully this includes all the important issues that people have 
> raised.  (Admittedly, some parts of the discussion have seemed less 
> consequential than others, and some parts I didn't understand at all.)
> 
> Alan
> 
> -----------------------------------------------------------------------------
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
> There are several arguments both for and against this change.  Let us
> refer to these enhanced ordering properties by saying that the LKMM
> would require locks to be RCtso (a bit of a misnomer, but analogous to
> RCpc and RCsc) and it would require ordinary acquire/release only to
> be RCpc.  (Note: In the following, the phrase "all supported
> architectures" does not include RISC-V, which is still somewhat in
> a state of flux.)

But "all supported architectures" does include RISC-V.


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

Pros for "RCpc-only ordinary (and atomic) acquire/release" should go
here.


> 
> Cons:
> 
> 	Andrea Parri and Luc Maranget feel that locks should have the
> 	same ordering properties as ordinary acquire/release (indeed,
> 	Luc points out that the names "acquire" and "release" derive
> 	from the usage of locks) and that having different ordering
> 	properties for different forms of acquires and releases would
> 	be confusing and unmaintainable.

s/unmaintainable/unneeded   ("confusing" should already convey the
fragility of these changes).


>Will and Linus, on the other
> 	hand, feel that architectures should be free to implement
> 	ordinary acquire/release using relatively weak RCpc machine
> 	instructions.  Linus points out that locks should be easy for
> 	people to use without worrying about memory consistency
> 	issues, since they are so pervasive in the kernel, whereas
> 	acquire/release is much more of an "expertss only" tool.
> 
> 	Locks are constructed from lower-level primitives, typically
> 	RMW-acquire (for locking) and ordinary release (for unlock).
> 	It is illogical to require stronger ordering properties from

s/It is illogical/It is detrimental to the LKMM's applicability


> 	the high-level operations than from the low-level operations
> 	they comprise.  Thus, this change would make
> 
> 		while (cmpxchg_acquire(&s, 0, 1) != 0)
> 			cpu_relax();
> 
> 	an incorrect implementation of spin_lock(&s)

... w.r.t. the LKMM (same for smp_cond_load_acquire).


>.  In theory this
> 	weakness can be ameliorated by changing the LKMM even further,
> 	requiring RMW-acquire/release also to be RCtso (which it
> 	already is on all supported architectures).
> 
> 	As far as I know, nobody has singled out any examples of code
> 	in the kernel that actually relies on locks being RCtso.
> 	(People mumble about RCU and the scheduler, but nobody has
> 	pointed to any actual code.  If there are any real cases,
> 	their number is likely quite small.)  If RCtso ordering is not
> 	needed, why require it?

Your patch and Paul said "opinions ranking".

  Andrea


> 
> 	A handful of locking constructs (qspinlocks, qrwlocks, and
> 	mcs_spinlocks) are built on top of smp_cond_load_acquire()
> 	instead of an RMW-acquire instruction.  It currently provides
> 	only the ordinary acquire semantics, not the stronger ordering
> 	this patch would require of locks.  In theory this could be
> 	ameliorated by requiring smp_cond_load_acquire() in
> 	combination with ordinary release also to be RCtso (which is
> 	currently true in all supported architectures).
> 
> 	On future weakly ordered architectures, people may be able to
> 	implement locks in a non-RCtso fashion with significant
> 	performance improvement.  Meeting the RCtso requirement would
> 	necessarily add run-time overhead.
> 
> Overall, the technical aspects of these arguments seem relatively
> minor, and it appears mostly to boil down to a matter of opinion.
> Since the opinions of long-time kernel developers such as Linus,
> Peter, and Will carry more weight than those of Luc and Andrea, this
> patch changes the model in accordance with the developers' wishes.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ---
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
