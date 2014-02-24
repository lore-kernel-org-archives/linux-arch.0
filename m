From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 0/5] arch: atomic rework
Date: Mon, 24 Feb 2014 09:40:37 -0800
Message-ID: <20140224174037.GQ8264@linux.vnet.ibm.com>
References: <CA+55aFwfx==u7o1NZ66aPbkOgsvGqW3UscGqrQkGuzOkjSpm6Q@mail.gmail.com>
 <20140220181116.GT4250@linux.vnet.ibm.com>
 <CA+55aFwn9gXWVq_GL=tPPP63vsqs-9QB4ii4s06xqG4UscCV5w@mail.gmail.com>
 <20140220185608.GX4250@linux.vnet.ibm.com>
 <CA+55aFw4inow5B-JAg-NtZigJ90yDbksddr00RoMKytzDAEa8A@mail.gmail.com>
 <20140220221027.GC4250@linux.vnet.ibm.com>
 <CA+55aFxp7U67R0PARaUfj94y5dJ8q6_HQ2pnbQ6=JD=XR-bTOw@mail.gmail.com>
 <alpine.LNX.2.00.1402211847290.7694@wotan.suse.de>
 <20140221191318.GK4250@linux.vnet.ibm.com>
 <alpine.LNX.2.00.1402241403580.7694@wotan.suse.de>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:54806 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbaBXRkm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Feb 2014 12:40:42 -0500
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 24 Feb 2014 10:40:42 -0700
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1402241403580.7694@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Matz <matz@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Torvald Riegel <triegel@redhat.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>

On Mon, Feb 24, 2014 at 02:55:07PM +0100, Michael Matz wrote:
> Hi,
>=20
> On Fri, 21 Feb 2014, Paul E. McKenney wrote:
>=20
> > > And with conservative I mean "everything is a source of a depende=
ncy, and=20
> > > hence can't be removed, reordered or otherwise fiddled with", and=
 that=20
> > > includes code sequences where no atomic objects are anywhere in s=
ight [1].
> > > In the light of that the only realistic way (meaning to not have =
to=20
> > > disable optimization everywhere) to implement consume as currentl=
y=20
> > > specified is to map it to acquire.  At which point it becomes poi=
ntless.
> >=20
> > No, only memory_order_consume loads and [[carries_dependency]]
> > function arguments are sources of dependency chains.
>=20
> I don't see [[carries_dependency]] in the C11 final draft (yeah, shou=
ld=20
> get a real copy, I know, but let's assume it's the same language as t=
he=20
> standard).  Therefore, yes, only consume loads are sources of=20
> dependencies.  The problem with the definition of the "carries a=20
> dependency" relation is not the sources, but rather where it stops. =20
> It's transitively closed over "value of evaluation A is used as opera=
nd in=20
> evaluation B", with very few exceptions as per 5.1.2.4#14.  Evaluatio=
ns=20
> can contain function calls, so if there's _any_ chance that an operan=
d of=20
> an evaluation might even indirectly use something resulting from a co=
nsume=20
> load then that evaluation must be compiled in a way to not break=20
> dependency chains.
>=20
> I don't see a way to generally assume that e.g. the value of a functi=
on=20
> argument can impossibly result from a consume load, therefore the com=
piler=20
> must assume that all function arguments _can_ result from such loads,=
 and=20
> so must disable all depchain breaking optimization (which are many).
>=20
> > > [1] Simple example of what type of transformations would be disal=
lowed:
> > >=20
> > > int getzero (int i) { return i - i; }
> >=20
> > This needs to be as follows:
> >=20
> > [[carries_dependency]] int getzero(int i [[carries_dependency]])
> > {
> > 	return i - i;
> > }
> >=20
> > Otherwise dependencies won't get carried through it.
>=20
> So, with the above do you agree that in absense of any other magic (s=
ee=20
> below) the compiler is not allowed to transform my initial getzero()=20
> (without the carries_dependency markers) implementation into "return =
0;"=20
> because of the C11 rules for "carries-a-dependency"?
>=20
> If so, do you then also agree that the specification of "carries a=20
> dependency" is somewhat, err, shall we say, overbroad?

=46rom what I can see, overbroad.  The problem is that the C++11 standa=
rd
defines how carries-dependency interacts with function calls and return=
s
in 7.6.4, which describes the [[carries_dependency]] attribute.  For ex=
ample,
7.6.4p6 says:

	Function g=E2=80=99s second parameter has a carries_dependency
	attribute, but its first parameter does not. Therefore, function
	h=E2=80=99s first call to g carries a dependency into g, but its secon=
d
	call does not. The implementation might need to insert a fence
	prior to the second call to g.

When C11 declined to take attributes, they also left out the part sayin=
g
how carries-dependency interacts with functions.  :-/

Might be fixed by now, checking up on it.

One could argue that the bit about emitting fence instructions at
function calls and returns is implied by the as-if rule even without
this wording, but...

> > > depchains don't matter, could _then_ optmize it to zero.  But tha=
t's=20
> > > insane, especially considering that it's hard to detect if a give=
n context=20
> > > doesn't care for depchains, after all the depchain relation is co=
nstructed=20
> > > exactly so that it bleeds into nearly everywhere.  So we would mo=
st of=20
> > > the time have to assume that the ultimate context will be depchai=
n-aware=20
> > > and therefore disable many transformations.
> >=20
> > Any function that does not contain a memory_order_consume load and =
that=20
> > doesn't have any arguments marked [[carries_dependency]] can be=20
> > optimized just as before.
>=20
> And as such marker doesn't exist we must conservatively assume that i=
t's=20
> on _all_ parameters, so I'll stand by my claim.

Or that you have to emit a fence instruction when a dependency chain
enters or leaves a function in cases where all callers/calles are not
visible to the compiler.

My preference is that the ordering properties of a carries-dependency
chain is implementation defined at the point that it enters or leaves
a function without the marker, but others strongly disagreed.  ;-)

> > > Then inlining getzero would merely add another "# j.dep =3D i.dep=
"=20
> > > relation, so depchains are still there but the value optimization=
 can=20
> > > happen before inlining.  Having to do something like that I'd fin=
d=20
> > > disgusting, and rather rewrite consume into acquire :)  Or make t=
he=20
> > > depchain relation somehow realistically implementable.
> >=20
> > I was actually OK with arithmetic cancellation breaking the depende=
ncy=20
> > chains.  Others on the committee felt otherwise, and I figured that=
 (1)=20
> > I wouldn't be writing that kind of function anyway and (2) they kne=
w=20
> > more about writing compilers than I.  I would still be OK saying th=
at=20
> > things like "i-i", "i*0", "i%1", "i&0", "i|~0" and so on just break=
 the=20
> > dependency chain.
>=20
> Exactly.  I can see the problem that people had with that, though.  T=
here=20
> are very many ways to write conceiled zeros (or generally neutral ele=
ments=20
> of the function in question).  My getzero() function is one (it could=
 e.g.=20
> be an assembler implementation).  The allowance to break dependency c=
hains=20
> would have to apply to such cancellation as well, and so can't simply=
=20
> itemize all cases in which cancellation is allowed.  Rather it would =
have=20
> had to argue about something like "value dependency", ala "evaluation=
 B=20
> depends on A, if there exist at least two different values A1 and A2=20
> (results from A), for which evaluation B (with otherwise same operand=
s)=20
> yields different values B1 and B2".

And that was in fact one of the arguments used against me.  ;-)

> Alas, it doesn't, except if you want to understand the term "the valu=
e of=20
> A is used as an operand of B" in that way.  Even then you'd still hav=
e the=20
> second case of the depchain definition, via intermediate not even ato=
mic=20
> memory stores and loads to make two evaluations be ordered per=20
> carries-a-dependency.
>=20
> And even that understanding of "is used" wouldn't be enough, because =
there=20
> are cases where the cancellation happens in steps, and where it inter=
acts=20
> with the third clause (transitiveness):  Assume this:
>=20
>   a =3D something()  // evaluation A
>   b =3D 1 - a        // evaluation B
>   c =3D a - 1 + b    // evaluation C
>=20
> Now, clearly B depends on A.  Also C depends on B (because with other=
wise=20
> same operands changing just B also changes C), because of transitiven=
ess C=20
> then also depends on A.  But equally cleary C was just an elaborate w=
ay to=20
> write "0", and so depends on nothing.  The problem was of course that=
 A=20
> and B weren't independent when determining the dependencies of C.  Bu=
t=20
> allowing cancellation to break dependency chains would have to allow =
for=20
> these cases as well.
>=20
> So, now, that leaves us basically with depchains forcing us to disabl=
e=20
> many useful transformation or finding some other magic.  One would be=
 to=20
> just regard all consume loads as acquire loads and be done (and=20
> effectively remove the ill-advised "carries a dependency" relation fr=
om=20
> consideration).
>=20
> You say downthread that it'd also be possible to just emit barriers b=
efore=20
> all function calls (I say "all" because the compiler will generally=20
> have applied some transformation that broke depchains if they existed=
). =20
> That seems to me to be a bigger hammer than just ignoring depchains a=
nd=20
> emit acquires instead of consumes (because the latter changes only ex=
actly=20
> where atomics are used, the former seems to me to have unbounded effe=
ct).

Yep, converting the acquire to a consume is a valid alternative to
emitting a memory-barrier instruction prior to entering/exiting the
function in question.

> So, am still missing something or is my understanding of the=20
> carries-a-dependency relation correct and my conclusions are merely t=
oo=20
> pessimistic?

Given the definition as it is, I believe you understand it.

							Thanx, Paul
