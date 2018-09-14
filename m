Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44978 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728172AbeINVoV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Sep 2018 17:44:21 -0400
Date: Fri, 14 Sep 2018 12:29:06 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
In-Reply-To: <20180914143752.GA7467@andrea>
Message-ID: <Pine.LNX.4.44L0.1809141210530.1482-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Daniel Lustig <dlustig@nvidia.com>, Will Deacon <will.deacon@arm.com>, Andrea Parri <parri.andrea@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, akiyks@gmail.com, Palmer Dabbelt <palmer@sifive.com>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20180914162906.gNBsPngY5ZMI8yNH30Qg_uuZPNb4s2uGGnZa02IlZUM@z>

On Fri, 14 Sep 2018, Andrea Parri wrote:

> > There are several arguments both for and against this change.  Let us
> > refer to these enhanced ordering properties by saying that the LKMM
> > would require locks to be RCtso (a bit of a misnomer, but analogous to
> > RCpc and RCsc) and it would require ordinary acquire/release only to
> > be RCpc.  (Note: In the following, the phrase "all supported
> > architectures" does not include RISC-V, which is still somewhat in
> > a state of flux.)
> 
> But "all supported architectures" does include RISC-V.

For the next draft I have adopted a suggestion Paul made about this;
it should clarify the meaning.

> > Pros:
> > 
> > 	The kernel already provides RCtso ordering for locks on all
> > 	supported architectures, even though this is not stated
> > 	explicitly anywhere.  Therefore the LKMM should formalize it.
> > 
> > 	In theory, guaranteeing RCtso ordering would reduce the need
> > 	for additional barrier-like constructs meant to increase the
> > 	ordering strength of locks.
> > 
> > 	Will Deacon and Peter Zijlstra are strongly in favor of
> > 	formalizing the RCtso requirement.  Linus Torvalds and Will
> > 	would like to go even further, requiring locks to have RCsc
> > 	behavior (ordering preceding writes against later reads), but
> > 	they recognize that this would incur a noticeable performance
> > 	degradation on the POWER architecture.  Linus also points out
> > 	that people have made the mistake, in the past, of assuming
> > 	that locking has stronger ordering properties than is
> > 	currently guaranteed, and this change would reduce the
> > 	likelihood of such mistakes.
> 
> Pros for "RCpc-only ordinary (and atomic) acquire/release" should go
> here.

I have added two more paragraphs here, taking some of the material out of
the first Con entry.

> > Cons:
> > 
> > 	Andrea Parri and Luc Maranget feel that locks should have the
> > 	same ordering properties as ordinary acquire/release (indeed,
> > 	Luc points out that the names "acquire" and "release" derive
> > 	from the usage of locks) and that having different ordering
> > 	properties for different forms of acquires and releases would
> > 	be confusing and unmaintainable.
> 
> s/unmaintainable/unneeded   ("confusing" should already convey the
> fragility of these changes).

The updated text includes all three notions explicitly.

> >Will and Linus, on the other
> > 	hand, feel that architectures should be free to implement
> > 	ordinary acquire/release using relatively weak RCpc machine
> > 	instructions.  Linus points out that locks should be easy for
> > 	people to use without worrying about memory consistency
> > 	issues, since they are so pervasive in the kernel, whereas
> > 	acquire/release is much more of an "expertss only" tool.
> > 
> > 	Locks are constructed from lower-level primitives, typically
> > 	RMW-acquire (for locking) and ordinary release (for unlock).
> > 	It is illogical to require stronger ordering properties from
> 
> s/It is illogical/It is detrimental to the LKMM's applicability

I disagree with this suggestion; not only would it be less readable,
it would lose a lot of the impact.  It really is illogical to require
A to be stronger than B when A is made up from B.

> > 	the high-level operations than from the low-level operations
> > 	they comprise.  Thus, this change would make
> > 
> > 		while (cmpxchg_acquire(&s, 0, 1) != 0)
> > 			cpu_relax();
> > 
> > 	an incorrect implementation of spin_lock(&s)
> 
> ... w.r.t. the LKMM (same for smp_cond_load_acquire).

Added.  I'm not sure what you meant about smp_cond_load_acquire(), so 
I didn't include it here (besides, the text already mentions 
smp_cond_load_acquire() in the fourth Con entry).

> >.  In theory this
> > 	weakness can be ameliorated by changing the LKMM even further,
> > 	requiring RMW-acquire/release also to be RCtso (which it
> > 	already is on all supported architectures).
> > 
> > 	As far as I know, nobody has singled out any examples of code
> > 	in the kernel that actually relies on locks being RCtso.
> > 	(People mumble about RCU and the scheduler, but nobody has
> > 	pointed to any actual code.  If there are any real cases,
> > 	their number is likely quite small.)  If RCtso ordering is not
> > 	needed, why require it?
> 
> Your patch and Paul said "opinions ranking".

What exactly are you referring to?  A later part of the text includes
the phrase "opinions ... carry more weight", which means more or less
the same thing.

>   Andrea

The updated Changelog draft is below.

Alan.

--------------------------------------------------------------------------
More than one kernel developer has expressed the opinion that the LKMM
should enforce ordering of writes by locking.  In other words, given
the following code:

	WRITE_ONCE(x, 1);
	spin_unlock(&s):
	spin_lock(&s);
	WRITE_ONCE(y, 1);

the stores to x and y should be propagated in order to all other CPUs,
even though those other CPUs might not access the lock s.  In terms of
the memory model, this means expanding the cumul-fence relation.

Locks should also provide read-read (and read-write) ordering in a
similar way.  Given:

	READ_ONCE(x);
	spin_unlock(&s);
	spin_lock(&s);
	READ_ONCE(y);		// or WRITE_ONCE(y, 1);

the load of x should be executed before the load of (or store to) y.
The LKMM already provides this ordering, but it provides it even in
the case where the two accesses are separated by a release/acquire
pair of fences rather than unlock/lock.  This would prevent
architectures from using weakly ordered implementations of release and
acquire, which seems like an unnecessary restriction.  The patch
therefore removes the ordering requirement from the LKMM for that
case.

There are several arguments both for and against this change.  Let us
refer to these enhanced ordering properties by saying that the LKMM
would require locks to be RCtso (a bit of a misnomer, but analogous to
RCpc and RCsc) and it would require ordinary acquire/release only to
be RCpc.  (Note: In the following, the phrase "all supported
architectures" is meant not to include RISC-V.  Although RISC-V is
indeed supported by the kernel, the implementation is still somewhat
in a state of flux and therefore statements about it would be
premature.)

Pros:

	The kernel already provides RCtso ordering for locks on all
	supported architectures, even though this is not stated
	explicitly anywhere.  Therefore the LKMM should formalize it.

	In theory, guaranteeing RCtso ordering would reduce the need
	for additional barrier-like constructs meant to increase the
	ordering strength of locks.

	Will Deacon and Peter Zijlstra are strongly in favor of
	formalizing the RCtso requirement.  Linus Torvalds and Peter
	would like to go even further, requiring locks to have RCsc
	behavior (ordering preceding writes against later reads), but
	they recognize that this would incur a noticeable performance
	degradation on the POWER architecture.  Linus also points out
	that people have made the mistake, in the past, of assuming
	that locking has stronger ordering properties than is
	currently guaranteed, and this change would reduce the
	likelihood of such mistakes.

	Not requiring ordinary acquire/release to be any stronger than
	RCpc may prove advantageous for future architectures, allowing
	them to implement smp_load_acquire() and smp_store_release()
	with more efficient machine instructions than would be
	possible if the operations had to be RCtso.  Will and Linus
	approve this rationale, hypothetical though it is at the
	moment (it may end up affecting the RISC-V implementation).
	The same argument may or may not apply to RMW-acquire/release;
	see also the second Con entry below.

	Linus feels that locks should be easy for people to use
	without worrying about memory consistency issues, since they
	are so pervasive in the kernel, whereas acquire/release is
	much more of an "experts only" tool.  Requiring locks to be
	RCtso is a step in this direction.

Cons:

	Andrea Parri and Luc Maranget think that locks should have the
	same ordering properties as ordinary acquire/release (indeed,
	Luc points out that the names "acquire" and "release" derive
	from the usage of locks).  Andrea points out that having
	different ordering properties for different forms of acquires
	and releases is not only unnecessary, it would also be
	confusing and unmaintainable.

	Locks are constructed from lower-level primitives, typically
	RMW-acquire (for locking) and ordinary release (for unlock).
	It is illogical to require stronger ordering properties from
	the high-level operations than from the low-level operations
	they comprise.  Thus, this change would make

		while (cmpxchg_acquire(&s, 0, 1) != 0)
			cpu_relax();

	an incorrect implementation of spin_lock(&s) as far as the
	LKMM is concerned.  In theory this weakness can be ameliorated
	by changing the LKMM even further, requiring
	RMW-acquire/release also to be RCtso (which it already is on
	all supported architectures).

	As far as I know, nobody has singled out any examples of code
	in the kernel that actually relies on locks being RCtso.
	(People mumble about RCU and the scheduler, but nobody has
	pointed to any actual code.  If there are any real cases,
	their number is likely quite small.)  If RCtso ordering is not
	needed, why require it?

	A handful of locking constructs (qspinlocks, qrwlocks, and
	mcs_spinlocks) are built on top of smp_cond_load_acquire()
	instead of an RMW-acquire instruction.  It currently provides
	only the ordinary acquire semantics, not the stronger ordering
	this patch would require of locks.  In theory this could be
	ameliorated by requiring smp_cond_load_acquire() in
	combination with ordinary release also to be RCtso (which is
	currently true on all supported architectures).

	On future weakly ordered architectures, people may be able to
	implement locks in a non-RCtso fashion with significant
	performance improvement.  Meeting the RCtso requirement would
	necessarily add run-time overhead.

Overall, the technical aspects of these arguments seem relatively
minor, and it appears mostly to boil down to a matter of opinion.
Since the opinions of senior kernel maintainers such as Linus,
Peter, and Will carry more weight than those of Luc and Andrea, this
patch changes the model in accordance with the maintainers' wishes.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

v.5: Incorporated feedback from Andrea regarding the updated Changelog.

v.4: Added pros and cons discussion to the Changelog.

v.3: Rebased against the dev branch of Paul's linux-rcu tree.
Changed unlock-rf-lock-po to po-unlock-rf-lock-po, making it more
symmetrical and more in accordance with the use of fence.tso for
the release on RISC-V.

v.2: Restrict the ordering to lock operations, not general release
and acquire fences.
