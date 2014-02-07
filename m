From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 0/5] arch: atomic rework
Date: Thu, 6 Feb 2014 20:20:51 -0800
Message-ID: <20140207042051.GL4250@linux.vnet.ibm.com>
References: <20140206134825.305510953@infradead.org>
 <21984.1391711149@warthog.procyon.org.uk>
 <52F3DA85.1060209@arm.com>
 <20140206185910.GE27276@mudshark.cambridge.arm.com>
 <20140206192743.GH4250@linux.vnet.ibm.com>
 <1391721423.23421.3898.camel@triegel.csb>
 <20140206221117.GJ4250@linux.vnet.ibm.com>
 <1391730288.23421.4102.camel@triegel.csb>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:37345 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbaBGEU5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Feb 2014 23:20:57 -0500
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 6 Feb 2014 21:20:56 -0700
Content-Disposition: inline
In-Reply-To: <1391730288.23421.4102.camel@triegel.csb>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Torvald Riegel <triegel@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>

On Fri, Feb 07, 2014 at 12:44:48AM +0100, Torvald Riegel wrote:
> On Thu, 2014-02-06 at 14:11 -0800, Paul E. McKenney wrote:
> > On Thu, Feb 06, 2014 at 10:17:03PM +0100, Torvald Riegel wrote:
> > > On Thu, 2014-02-06 at 11:27 -0800, Paul E. McKenney wrote:
> > > > On Thu, Feb 06, 2014 at 06:59:10PM +0000, Will Deacon wrote:
> > > > > There are also so many ways to blow your head off it's untrue=
=2E For example,
> > > > > cmpxchg takes a separate memory model parameter for failure a=
nd success, but
> > > > > then there are restrictions on the sets you can use for each.=
 It's not hard
> > > > > to find well-known memory-ordering experts shouting "Just use
> > > > > memory_model_seq_cst for everything, it's too hard otherwise"=
=2E Then there's
> > > > > the fun of load-consume vs load-acquire (arm64 GCC completely=
 ignores consume
> > > > > atm and optimises all of the data dependencies away) as well =
as the definition
> > > > > of "data races", which seem to be used as an excuse to miscom=
pile a program
> > > > > at the earliest opportunity.
> > > >=20
> > > > Trust me, rcu_dereference() is not going to be defined in terms=
 of
> > > > memory_order_consume until the compilers implement it both corr=
ectly and
> > > > efficiently.  They are not there yet, and there is currently no=
 shortage
> > > > of compiler writers who would prefer to ignore memory_order_con=
sume.
> > >=20
> > > Do you have any input on
> > > http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D59448?  In particul=
ar, the
> > > language standard's definition of dependencies?
> >=20
> > Let's see...  1.10p9 says that a dependency must be carried unless:
> >=20
> > =E2=80=94 B is an invocation of any specialization of std::kill_dep=
endency (29.3), or
> > =E2=80=94 A is the left operand of a built-in logical AND (&&, see =
5.14) or logical OR (||, see 5.15) operator,
> > or
> > =E2=80=94 A is the left operand of a conditional (?:, see 5.16) ope=
rator, or
> > =E2=80=94 A is the left operand of the built-in comma (,) operator =
(5.18);
> >=20
> > So the use of "flag" before the "?" is ignored.  But the "flag - fl=
ag"
> > after the "?" will carry a dependency, so the code fragment in 5944=
8
> > needs to do the ordering rather than just optimizing "flag - flag" =
out
> > of existence.  One way to do that on both ARM and Power is to actua=
lly
> > emit code for "flag - flag", but there are a number of other ways t=
o
> > make that work.
>=20
> And that's what would concern me, considering that these requirements
> seem to be able to creep out easily.  Also, whereas the other atomics
> just constrain compilers wrt. reordering across atomic accesses or
> changes to the atomic accesses themselves, the dependencies are new
> requirements on pieces of otherwise non-synchronizing code.  The latt=
er
> seems far more involved to me.

Well, the wording of 1.10p9 is pretty explicit on this point.
There are only a few exceptions to the rule that dependencies from
memory_order_consume loads must be tracked.  And to your point about
requirements being placed on pieces of otherwise non-synchronizing code=
,
we already have that with plain old load acquire and store release --
both of these put ordering constraints that affect the surrounding
non-synchronizing code.

This issue got a lot of discussion, and the compromise is that
dependencies cannot leak into or out of functions unless the relevant
parameters or return values are annotated with [[carries_dependency]].
This means that the compiler can see all the places where dependencies
must be tracked.  This is described in 7.6.4.  If a dependency chain
headed by a memory_order_consume load goes into or out of a function
without the aid of the [[carries_dependency]] attribute, the compiler
needs to do something else to enforce ordering, e.g., emit a memory
barrier.

=46rom a Linux-kernel viewpoint, this is a bit ugly, as it requires
annotations and use of kill_dependency, but it was the best I could do
at the time.  If things go as they usually do, there will be some other
reason why those are needed...

> > BTW, there is some discussion on 1.10p9's handling of && and ||, an=
d
> > that clause is likely to change.  And yes, I am behind on analyzing
> > usage in the Linux kernel to find out if Linux cares...
>=20
> Do you have any pointers to these discussions (e.g., LWG issues)?

Nope, just a bare email thread.  I would guess that it will come up
next week.

The question is whether dependencies should be carried through && or ||
at all, and if so how.  My current guess is that && and || should not
carry dependencies.

> > > > And rcu_dereference() will need per-arch overrides for some tim=
e during
> > > > any transition to memory_order_consume.
> > > >=20
> > > > > Trying to introduce system concepts (writes to devices, inter=
rupts,
> > > > > non-coherent agents) into this mess is going to be an uphill =
battle IMHO. I'd
> > > > > just rather stick to the semantics we have and the asm volati=
le barriers.
> > > >=20
> > > > And barrier() isn't going to go away any time soon, either.  An=
d
> > > > ACCESS_ONCE() needs to keep volatile semantics until there is s=
ome
> > > > memory_order_whatever that prevents loads and stores from being=
 coalesced.
> > >=20
> > > I'd be happy to discuss something like this in ISO C++ SG1 (or ha=
s this
> > > been discussed in the past already?).  But it needs to have a pap=
er I
> > > suppose.
> >=20
> > The current position of the usual suspects other than me is that th=
is
> > falls into the category of forward-progress guarantees, which are
> > considers (again, by the usual suspects other than me) to be out
> > of scope.
>=20
> But I think we need to better describe forward progress, even though
> that might be tricky.  We made at least some progress on
> http://cplusplus.github.io/LWG/lwg-active.html#2159 in Chicago, even
> though we can't constrain the OS schedulers too much, and for lock-fr=
ee
> we're in this weird position that on most general-purpose schedulers =
and
> machines, obstruction-free algorithms are likely to work just fine li=
ke
> lock-free, most of the time, in practice...

Yep, there is a draft paper by Alistarh et al. making this point.
They could go quite a bit further.  With a reasonably short set of
additional constraints, you can get bounded execution times out of
locking as well.  They were not amused when I suggested this, Bjoern
Brandenberg's dissertation notwithstanding.  ;-)

> We also need to discuss forward progress guarantees for any
> parallelism/concurrency abstractions, I believe:
> http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2014/n3874.pdf
>=20
> Hopefully we'll get some more acceptance of this being in scope...

That would be good.  Just in case C11 is to be applicable to real-time
software.

> > > Will you be in Issaquah for the C++ meeting next week?
> >=20
> > Weather permitting, I will be there!
>=20
> Great, maybe we can find some time in SG1 to discuss this then.  Even=
 if
> the standard doesn't want to include it, SG1 should be a good forum t=
o
> understand everyone's concerns around that, with the hope that this
> would help potential non-standard extensions to be still checked by t=
he
> same folks that did the rest of the memory model.

Sounds good!  Hopefully some discussion of out-of-thin-air values as we=
ll.

							Thanx, Paul
