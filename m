From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 0/5] arch: atomic rework
Date: Sat, 22 Feb 2014 22:34:26 -0800
Message-ID: <20140223063426.GT4250@linux.vnet.ibm.com>
References: <20140220083032.GN4250@linux.vnet.ibm.com>
 <CA+55aFwfx==u7o1NZ66aPbkOgsvGqW3UscGqrQkGuzOkjSpm6Q@mail.gmail.com>
 <20140220181116.GT4250@linux.vnet.ibm.com>
 <CA+55aFwn9gXWVq_GL=tPPP63vsqs-9QB4ii4s06xqG4UscCV5w@mail.gmail.com>
 <1392922421.28840.36.camel@triegel.csb>
 <CA+55aFwos2Gwd2LEvht4ymVxHb6GRVjtZ9wwJSaj1p--FqNUWw@mail.gmail.com>
 <1393095223.28840.4914.camel@triegel.csb>
 <CA+55aFz9=RQoMO2ipyZgNPNzWGVXi_R9Ar5=o9VBWwXzDDz6jg@mail.gmail.com>
 <20140223003933.GQ4250@linux.vnet.ibm.com>
 <CA+55aFyjzR_Ga_HOKnBXpKYbuesqovj1-sFTVisD9UwA6JuJtw@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:42676 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbaBWGed (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 23 Feb 2014 01:34:33 -0500
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Sat, 22 Feb 2014 23:34:32 -0700
Content-Disposition: inline
In-Reply-To: <CA+55aFyjzR_Ga_HOKnBXpKYbuesqovj1-sFTVisD9UwA6JuJtw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Torvald Riegel <triegel@redhat.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>

On Sat, Feb 22, 2014 at 07:50:35PM -0800, Linus Torvalds wrote:
> On Sat, Feb 22, 2014 at 4:39 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >
> > Agreed, by far the most frequent use is "->" to dereference and ass=
ignment
> > to store into a local variable.  The other operations where the ker=
nel
> > expects ordering to be maintained are:
> >
> > o       Bitwise "&" to strip off low-order bits.  The FIB tree does
> >         this, for example in fib_table_lookup() in net/ipv4/fib_tri=
e.c.
> >         The low-order bit is used to distinguish internal nodes fro=
m
> >         leaves -- nodes and leaves are different types of structure=
s.
> >         (There are a few others.)
>=20
> Note that this is very much outside the scope of the C standard,
> regardless of 'consume' or not.
>=20
> We'll always do things outside the standard, so I wouldn't worry.

=46air enough.  I am going to make examples to try to make sure that we
aren't using the same words for two different meanings:

	struct foo restrict *p;

	p =3D atomic_load_explicit(&gp, memory_order_consume);
	p &=3D ~0x3;  /* OK because p has restrict property. */
	return p->a;	/* Ordered WRT above load. */

Of course, the compiler would have to work pretty hard to break this
ordering, so I am with you in not worrying too much about this one.

> > o       Uses "?:" to substitute defaults in case of NULL pointers,
> >         but ordering must be maintained in the non-default case.
> >         Most, perhaps all, of these could be converted to "if" shou=
ld
> >         "?:" prove problematic.
>=20
> Note that this doesn't actually affect the restrict/ordering rule in
> theory: "?:" isn't special according to those rules. The rules are
> fairly simple: we guarantee ordering only to the object that the
> pointer points to, and even that guarantee goes out the window if
> there is some *other* way to reach the object.
>=20
> ?: is not really relevant, except in the sense that *any* expression
> that ends up pointing to outside the object will lose the ordering
> guarantee. ?: can be one such expression, but so can "p-p" or anythin=
g
> like that.
>=20
> And in *practice*, the only thing that needs to be sure to generate
> special code is alpha, and there you'd just add the "rmb" after the
> load. That is sufficient to fulfill the guarantees.

OK, seems reasonable.  Reworking the earlier example:

	struct foo restrict *p;

	p =3D atomic_load_explicit(&gp, memory_order_consume);
	p =3D p ? p : &default_foo;
	return p->a;	/* Ordered WRT above load if p non-NULL. */

And the ordering makes sense only in the non-NULL case anyway,
so this should be fine.

> On ARM and powerpc, the compiler obviously has to guarantee that it
> doesn't do value-speculation on the result, but again, that never
> really had anything to do with the whole "carries a dependency", it i=
s
> really all about the fact that in order to guarantee the ordering, th=
e
> compiler mustn't generate that magical aliased pointer value. But if
> the aliased pointer value comes from the *source* code, all bets are
> off.

Agreed, compiler-based value speculation is dangerous in any case.
(Though the branch-predictor-based trick seems like it should be safe
on TSO systems like x86, s390, etc.)

> Now, even on alpha, the compiler can obviously move that "rmb" around=
=2E
> For example, if there is a conditional after the
> "atomic_read(mo_consume)", and the compiler can tell that the pointer
> that got read by mo_consume is dead along one branch, then the
> compiler can move the "rmb" to only exist in the other branch. Why?
> Because we inherently guarantee only the order to any accesses to the
> object the pointer pointed to, and that the pointer that got loaded i=
s
> the *only* way to get to that object (in this context), so if the
> value is dead, then so is the ordering.

Yep!

> In fact, even if the value is *not* dead, but it is NULL, the compile=
r
> can validly say "the NULL pointer cannot point to any object, so I
> don't have to guarantee any serialization". So code like this (writin=
g
> alpha assembly, since in practice only alpha will ever care):
>=20
>     ptr =3D atomic_read(pp, mo_consume);
>     if (ptr) {
>        ... do something with ptr ..
>     }
>     return ptr;
>=20
> can validly be translated to:
>=20
>     ldq $1,0($2)
>     beq $1,branch-over
>     rmb
>     .. the do-something code using register $1 ..
>=20
> because the compiler knows that a NULL pointer cannot be dereferenced=
,
> so it can decide to put the rmb in the non-NULL path - even though th=
e
> pointer value is still *live* in the other branch (well, the liveness
> of a constant value is somewhat debatable, but you get the idea), and
> may be used by the caller (but since it is NULL, the "use" can not
> include accessing any object, only really testing)

Agreed.

> So note how this is actually very different from the "carries
> dependency" rule. It's simpler, and it allows much more natural
> optimizations.

I do have a couple more questions about it, but please see below.

> > o       Addition and subtraction to adjust both pointers to and ind=
exes
> >         into RCU-protected arrays.  There are not that many indexes=
,
> >         and they could be converted to pointers, but the addition a=
nd
> >         subtraction looks necessary in a some cases.
>=20
> Addition and subtraction is fine, as long as they stay within the sam=
e
> object/array.
>=20
> And realistically, people violate the whole C pointer "same object"
> rule all the time. Any time you implement a raw memory allocator,
> you'll violate the C standard and you *will* basically be depending o=
n
> architecture-specific behavior. So everybody knows that the C "pointe=
r
> arithmetic has to stay within the object" is really a fairly made-up
> but convenient shorthand for "sure, we know you'll do tricks on
> pointer values, but they won't be portable and you may have to take
> particular machine representations into account".

Adding and subtracting integers to/from a RCU-protected pointer makes
sense to me.

Adding and subtracting integers to/from an RCU-protected integer makes
sense in many practical cases, but I worry about the compiler figuring
out that the RCU-protected integer cancelled with some other integer.
I am beginning to suspect that the few uses of RCU-protected array
indexes should be converted to pointer form.

I don't feel all that good about subtractions involving an RCU-protecte=
d
pointer and another pointer, again due to the possibility of arithmetic
optimizations cancelling everything.  But it is true that doing so is
perfectly safe in a number of situations.  For example, the following
should work, and might even be useful:

	p =3D atomic_load_explicit(&gp, memory_order_consume);
	q =3D gq + p - gp_base;
	do_something_with(q->a);  /* No ordering, but corresponding element. *=
/

But at that point, the RCU-protected array index seems nicer.  Give or
take my nervousness about arithmetic optimizations.

> > o       Array indexing.  The value from rcu_dereference() is used b=
oth
> >         before and inside the "[]", interestingly enough.
>=20
> Well, in the C sense, or in the actual "integer index" sense? Because
> technically, a[b] is nothing but *(a+b), so "inside" the "[]" is
> strictly speaking meaningless. Inside and outside are just syntactic
> sugar.

Yep, understood that a[b] is identical to b[a] in classic C.  Just gett=
ing
nervous about RCU-protected integer indexes interacting with compiler
optimizations.  Perhaps needlessly so, but...

> That said, I agree that the way I phrased things really limits things
> to *just* pointers, and if you want to do RCU on integer values (that
> get turned into pointers some other way), that would be outside the
> spec.

That was why I asked.  ;-)

> But in practice, the code generation will *work* for non-pointers too
> (the exception might be if the compiler actually does the above "NULL
> is special, so I know I don't need to order wrt it". Exactly the way
> that people do arithmetic operations on pointers that aren't really
> covered by the standard (ie arithmetic 'and' to align them etc), the
> code still *works*. It may be outside the standard, but everybody doe=
s
> it, and one of the reasons C is so powerful is exactly that you *can*
> do things like that. They won't be portable, and you have to know wha=
t
> you are doing, but they don't stop working just because they aren't
> covered by the standard.

Yep, again modulo my nervousness about arithmetic optimizations on
RCU-protected integers.

> >>  - the "restricted pointer" part means that the compiler does not =
need
> >> to worry about serialization to that object through other possible
> >> pointers - we have basically promised that the *only* pointer to t=
hat
> >> object comes from the mo_consume. So that part makes it clear that=
 the
> >> "consume" ordering really only is valid wrt that particular pointe=
r
> >> load.
> >
> > That could work, though there are some cases where a multi-linked
> > structure is made visible using a single rcu_assign_pointer(), and
> > rcu_dereference() is used only for the pointer leading to that
> > multi-linked structure, not for the pointers among the elements
> > making up that structure.  One way to handle this would be to
> > require rcu_dereference() to be used within the structure an well
> > as upon first traversal to the structure.
>=20
> I don't see that you would need to protect anything but the first
> read, so I think you need rcu_dereference() only on the initial
> pointer access.

Let me try an example:

	struct bar {
		int a;
		unsigned b;
	};

	struct foo {
		struct bar *next;
		char c;
	};

	struct bar bar1;
	struct foo foo1;
=09
	struct foo *foop;

T1:	bar1.a =3D -1;
	bar1.b =3D 2;
	foo1.next =3D &bar;
	foo1.c =3D "*";
	atomic_store_explicit(&foop, &foo1, memory_order_release);

T2:	struct foo restrict *p;
	struct bar *q;

	p =3D atomic_load_explicit(&foop, memory_order_consume);
	if (p =3D=3D NULL)
		return -EDEALWITHIT;
	q =3D p->next;  /* Ordered with above load. */
	do_something(q->b); /* Non-decorated pointer, ordered? */

Yes, any reasonable code generation of the above will produce the order=
ing
on all systems that Linux runs on, understood.  But by your rules, if
we don't do something special for pointer q, how do we avoid either
(1) losing the ordering, (2) being back in the dependency-tracing busin=
ess,
or (3) having to rely on the kindness of compiler writers?

> On architectures where following a pointer is sufficient ordering,
> we're fine. On alpha (and, if anybody ever makes that horrid mistake
> again), the 'rmb' after the first access will guarantee that all the
> later accesses will see the new list.
>=20
> So basically, 'consume' will end up inserting a barrier (if necessary=
)
> before following the pointer for the first time, but once that barrie=
r
> has been inserted, we are now fully ordered wrt the releasing store,
> so we're done. No need to order *all* the accesses (even off the same
> base pointer), only the first one.

I hear what you are saying, but it is sounding like #3 in my list above=
=2E  ;-)

Which is OK, except from the legalistic guarantees viewpoint you mentio=
n
below.  It might also allow compiler writers to do crazy optimizations
in general, but not on these restricted pointers.  This might improve
performance without risking messing up critical orderings.

> > But now it is time for some bullshit syntax for the RCU-protected a=
rrays
> > in the Linux kernel:
> >
> >         p =3D atomic_load_explicit(gp, memory_order_consume);
> >         r1 =3D *p; /* Ordering maintained. */
> >         r2 =3D p[5]; /* Ordering maintained? */
>=20
> Oh yes. It's in the same object. If it wasn't, then "p[5]" itself
> would be meaningless and outside the scope of the standard to begin
> with.
>=20
> >         r3 =3D p + 5; /* Ordering maintained? */
> >         n =3D get_an_index();
> >         r4 =3D p[n]; /* Ordering maintained? */
>=20
> Yes. By definition. And again, for the very same reason. You would
> violate *other* parts of the C standard before you violated the
> suggested rule.

Good!

> Also, remember: a lot of this is about "legalistic guarantees". In
> practice, just the fact that a data chain *exists* is guarantee
> enough, so from a code generation standpoint, NONE OF THIS MATTERS.

Completely understood.

> The exception is alpha, where a "mo_consume" load basically needs to
> be generated with a "rmb" following it (see above how you can relax
> that a _bit_, but not much). Trivial.
>=20
> So code generation is actually *trivial*. Ordering is maintained
> *automatically*, with no real effort on the side of the compiler.
>=20
> The only issues really are:
>=20
>  - the current C standard language implies *too much* ordering. The
> whole "carries dependency" is broken. The practical example - even
> without using "?:" or any conditionals or any function calls - is jus=
t
> that
>=20
>         ptr =3D atomic_read(pp, mo_consume);
>         value =3D array[ptr-ptr];
>=20
>   and there really isn't any sane ordering there. But the current
> standard clearly says there is. The current standard is wrong.

Yep, not my idea, though I must take the blame for going along with it.

>  - my trick of saying that it is only ordered wrt accesses to the
> object the pointer points to gets rid of that whole bogus false
> dependency.

So I am still nervous about pointer "q" in my example above.

>  - the "restricted pointer" thing is just legalistic crap, and has no
> actual meaning for code generation, it is _literally_ just that if th=
e
> programmer does value speculation by hand:
>=20
>         ptr =3D atomic_read(pp, mo_consume);
>         value =3D object.val;
>         if (ptr !=3D &object)
>                 value =3D ptr->val;
>=20
>     then in this situation the compiler does *not* need to worry abou=
t
> the ordering to the "object.val" access, because it was gotten throug=
h
> an alias.

And hopefully to tell the compiler to go easy on crazy optimizations
in case where ptr->a or some such is really used.

> So that "restrict" thing is really just a way to say "the ordering
> only exists through that single pointer". That's not really what
> restrict was _designed_ for, but to quote the standard:
>=20
>  "An object that is accessed through a restrict-quali=EF=AC=81ed poin=
ter has a
> special association
>   with that pointer. This association, de=EF=AC=81ned in 6.7.3.1 belo=
w,
> requires that all accesses to
>   that object use, directly or indirectly, the value of that particul=
ar pointer"
>=20
> that's not the *definition* of "restrict", and quite frankly, the
> actual language that talks about "restrict" really talks about being
> able to know that nobody *modifies* the value through another pointer=
,
> so I'm clearly stretching things a bit. But anybody reading the above
> quote from the standard hopefully agrees that I'm not stretching it
> all that much.

Well, based on my experience, the committee would pick some other
spelling anyway...  ;-)

							Thanx, Paul
