From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH RFC tools/memory-model] Add litmus-test naming scheme
Date: Tue, 29 May 2018 11:33:50 +0200
Message-ID: <20180529093350.GA5803@andrea>
References: <20180525191020.GA5914@linux.vnet.ibm.com>
 <20180528112010.GA8801@andrea>
 <20180528214838.GZ3803@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180528214838.GZ3803@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

[...]

> > We used to distinguigh between the test name and the test filename; we
> > currently have only one test whose name ends with .litmus:
> >=20
> >   ISA2+pooncelock+pooncelock+pombonce.litmus
> >=20
> > (that I missed until now...).
>=20
> I queued a commit to fix this with your Reported-by, good catch!

Thanks for the fix.


> > I also notice that, with the current version, the above command can be
> > simplified to:
> >=20
> >   $ norm7 -bell linux-kernel.bell Rfi Once PodRR Once Fre Once Rfi Once=
 PodRR Once Fre Once | sed -e 's/:.*//g'
>=20
> Dropping the "classify7" command, correct?

Right, thanks.  Ah, maybe we should strive to meet the 80-chars bound
by splitting the command with "\"?


> > Maybe expand to recall that we're referring to a particular cycle (the
> > cycle referred to in the previous section)? (the term 'consecutive' is
> > overloaded ;-)
>=20
> Well, it is an English word, so overloading is the common case.  ;-)
>=20
> How about this?

Looks better, thanks.


> > I'm not sure if it is worth commenting on this, but compare, e.g., the
> > 'exists' clauses of the following two tests (thinking at 'coherence'):
> >=20
> > $ diyone7 -arch LISA PosWR PodRR Fre PosWR PodRR Fre
> > LISA A
> > "PosWR PodRR Fre PosWR PodRR Fre"
> > Generator=3Ddiyone7 (version 7.49+02(dev))
> > Prefetch=3D0:x=3DF,0:y=3DT,1:y=3DF,1:x=3DT
> > Com=3DFr Fr
> > Orig=3DPosWR PodRR Fre PosWR PodRR Fre
> > {
> > }
> >  P0       | P1       ;
> >  w[] x 1  | w[] y 1  ;
> >  r[] r0 x | r[] r0 y ;
> >  r[] r1 y | r[] r1 x ;
> > exists
> > (0:r1=3D0 /\ 1:r1=3D0)
> >=20
> > $ diyone7 -arch LISA Rfi PodRR Fre Rfi PodRR Fre
> > LISA A
> > "Rfi PodRR Fre Rfi PodRR Fre"
> > Generator=3Ddiyone7 (version 7.49+02(dev))
> > Prefetch=3D0:x=3DF,0:y=3DT,1:y=3DF,1:x=3DT
> > Com=3DFr Fr
> > Orig=3DRfi PodRR Fre Rfi PodRR Fre
> > {
> > }
> >  P0       | P1       ;
> >  w[] x 1  | w[] y 1  ;
> >  r[] r0 x | r[] r0 y ;
> >  r[] r1 y | r[] r1 x ;
> > exists
> > (0:r0=3D1 /\ 0:r1=3D0 /\ 1:r0=3D1 /\ 1:r1=3D0)
>=20
> How about this?
>=20
> fi: Read-from internal.  The current process wrote a variable and then
> 	immediately read the value back from it.  For the purposes of
> 	naming, Rfi acts identically to PosWR.

Well, "Rfi" produces "rfi" while "PosWR" produces "pos" for a name...


> However, there are subtle
> 	but very real differences between them in other contexts.

I think that you're fascinated by the evocative power of English words. ;-)


> > The list of descriptors is incomplete; the command:
> >=20
> >   $ diyone7 -bell linux-kernel.bell -show edges
> >=20
> > shows other descriptors (including fences and dependencies).  We might
> > want to list this command; searching the commit history, I found:
> >=20
> >    3c24730ef6c662 ("gen: Add a new command line option -show (edges|fen=
ces|annotations) that list various categories of candidate relaxations.")
>=20
> Yow!!!
>=20
>  CtrldR CtrldW CtrlsR CtrlsW DpAddrdR DpAddrdW DpAddrsR DpAddrsW DpCtrldR=
 DpCtrldW DpCtrlsR DpCtrlsW DpDatadW DpDatasW Dpd* DpdR DpdW Dps* DpsR DpsW=
 FenceAfter-atomic FenceAfter-atomicd** FenceAfter-atomicd*R FenceAfter-ato=
micd*W FenceAfter-atomicdR* FenceAfter-atomicdRR FenceAfter-atomicdRW Fence=
After-atomicdW* FenceAfter-atomicdWR FenceAfter-atomicdWW FenceAfter-atomic=
s** FenceAfter-atomics*R FenceAfter-atomics*W FenceAfter-atomicsR* FenceAft=
er-atomicsRR FenceAfter-atomicsRW FenceAfter-atomicsW* FenceAfter-atomicsWR=
 FenceAfter-atomicsWW FenceAfter-spinlock FenceAfter-spinlockd** FenceAfter=
-spinlockd*R FenceAfter-spinlockd*W FenceAfter-spinlockdR* FenceAfter-spinl=
ockdRR FenceAfter-spinlockdRW FenceAfter-spinlockdW* FenceAfter-spinlockdWR=
 FenceAfter-spinlockdWW FenceAfter-spinlocks** FenceAfter-spinlocks*R Fence=
After-spinlocks*W FenceAfter-spinlocksR* FenceAfter-spinlocksRR FenceAfter-=
spinlocksRW FenceAfter-spinlocksW* FenceAfter-spinlocksWR FenceAfter-spinlo=
cksWW FenceBefore-atomic FenceBefore-atomicd** FenceBefore-atomicd*R FenceB=
efore-atomicd*W FenceBefore-atomicdR* FenceBefore-atomicdRR FenceBefore-ato=
micdRW FenceBefore-atomicdW* FenceBefore-atomicdWR FenceBefore-atomicdWW Fe=
nceBefore-atomics** FenceBefore-atomics*R FenceBefore-atomics*W FenceBefore=
-atomicsR* FenceBefore-atomicsRR FenceBefore-atomicsRW FenceBefore-atomicsW=
* FenceBefore-atomicsWR FenceBefore-atomicsWW FenceMb FenceMbd** FenceMbd*R=
 FenceMbd*W FenceMbdR* FenceMbdRR FenceMbdRW FenceMbdW* FenceMbdWR FenceMbd=
WW FenceMbs** FenceMbs*R FenceMbs*W FenceMbsR* FenceMbsRR FenceMbsRW FenceM=
bsW* FenceMbsWR FenceMbsWW FenceRcu-lock FenceRcu-lockd** FenceRcu-lockd*R =
FenceRcu-lockd*W FenceRcu-lockdR* FenceRcu-lockdRR FenceRcu-lockdRW FenceRc=
u-lockdW* FenceRcu-lockdWR FenceRcu-lockdWW FenceRcu-locks** FenceRcu-locks=
*R FenceRcu-locks*W FenceRcu-locksR* FenceRcu-locksRR FenceRcu-locksRW Fenc=
eRcu-locksW* FenceRcu-locksWR FenceRcu-locksWW FenceRcu-unlock FenceRcu-unl=
ockd** FenceRcu-unlockd*R FenceRcu-unlockd*W FenceRcu-unlockdR* FenceRcu-un=
lockdRR FenceRcu-unlockdRW FenceRcu-unlockdW* FenceRcu-unlockdWR FenceRcu-u=
nlockdWW FenceRcu-unlocks** FenceRcu-unlocks*R FenceRcu-unlocks*W FenceRcu-=
unlocksR* FenceRcu-unlocksRR FenceRcu-unlocksRW FenceRcu-unlocksW* FenceRcu=
-unlocksWR FenceRcu-unlocksWW FenceRmb FenceRmbd** FenceRmbd*R FenceRmbd*W =
FenceRmbdR* FenceRmbdRR FenceRmbdRW FenceRmbdW* FenceRmbdWR FenceRmbdWW Fen=
ceRmbs** FenceRmbs*R FenceRmbs*W FenceRmbsR* FenceRmbsRR FenceRmbsRW FenceR=
mbsW* FenceRmbsWR FenceRmbsWW FenceSync-rcu FenceSync-rcud** FenceSync-rcud=
*R FenceSync-rcud*W FenceSync-rcudR* FenceSync-rcudRR FenceSync-rcudRW Fenc=
eSync-rcudW* FenceSync-rcudWR FenceSync-rcudWW FenceSync-rcus** FenceSync-r=
cus*R FenceSync-rcus*W FenceSync-rcusR* FenceSync-rcusRR FenceSync-rcusRW F=
enceSync-rcusW* FenceSync-rcusWR FenceSync-rcusWW FenceWmb FenceWmbd** Fenc=
eWmbd*R FenceWmbd*W FenceWmbdR* FenceWmbdRR FenceWmbdRW FenceWmbdW* FenceWm=
bdWR FenceWmbdWW FenceWmbs** FenceWmbs*R FenceWmbs*W FenceWmbsR* FenceWmbsR=
R FenceWmbsRW FenceWmbsW* FenceWmbsWR FenceWmbsWW Fenced** Fenced*R Fenced*=
W FencedR* FencedRR FencedRW FencedW* FencedWR FencedWW Fences** Fences*R F=
ences*W FencesR* FencesRR FencesRW FencesW* FencesWR FencesWW FrBack FrLeav=
e Fre Fri Hat Na Pod** Pod*R Pod*W PodR* PodRR PodRW PodW* PodWR PodWW Pos*=
* Pos*R Pos*W PosR* PosRR PosRW PosW* PosWR PosWW R Read RfBack RfLeave Rfe=
 Rfi Rmw W Write WsBack WsLeave Wse Wsi
>=20
> I added the following at the end:
>=20
> Please note that the above is a partial list.  To see the full list of
> descriptors, execute the following command:
>=20
> $ diyone7 -bell linux-kernel.bell -show edges

Thanks.  One more nit: I'd indent this and the above "norm7" commands as
we do in our "main" README.


>=20
> > I also notice that our current names for tests with fences (and cycle)
> > deviate from the corresponding 'norm7' results; e.g.,
> >=20
> >   $ norm7 -bell linux-kernel.bell FenceWmbdWW Once Rfe Once FenceRmbdRR=
 Once Fre Once | sed -e 's/:.*//g'
> >   MP+fencewmbonceonce+fencermbonceonce
> >=20
> > while we use 'MP+wmbonceonce+rmbonceonce' (that is, we omit the 'fence'
> > prefixes).
>=20
> Would you be willing to send me a patch fixing them up?

Yes, I'll work this out.

  Andrea


>=20
> Please see below for updated patch.
>=20
> 							Thanx, Paul
>=20
> ------------------------------------------------------------------------
>=20
> commit 04a897a8e202e8d79dd47910321f0e8efb081854
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Fri May 25 12:02:53 2018 -0700
>=20
>     EXP tools/memory-model: Add litmus-test naming scheme
>    =20
>     This commit documents the scheme used to generate the names for the
>     litmus tests.
>    =20
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>     [ paulmck: Apply feedback from Andrea Parri. ]
>=20
> diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/=
litmus-tests/README
> index 00140aaf58b7..9c0ea65c5362 100644
> --- a/tools/memory-model/litmus-tests/README
> +++ b/tools/memory-model/litmus-tests/README
> @@ -1,4 +1,6 @@
> -This directory contains the following litmus tests:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +LITMUS TESTS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  CoRR+poonceonce+Once.litmus
>  	Test of read-read coherence, that is, whether or not two
> @@ -151,3 +153,143 @@ Z6.0+pooncerelease+poacquirerelease+mbonceonce.litm=
us
>  A great many more litmus tests are available here:
> =20
>  	https://github.com/paulmckrcu/litmus
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +LITMUS TEST NAMING
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Litmus tests are usually named based on their contents, which means that
> +looking at the name tells you what the litmus test does.  The naming
> +scheme covers litmus tests having a single cycle that passes through
> +each process exactly once, so litmus tests not fitting this description
> +are named on an ad-hoc basis.
> +
> +The structure of a litmus-test name is the litmus-test class, a plus
> +sign ("+"), and one string for each process, separated by plus signs.
> +The end of the name is ".litmus".
> +
> +The litmus-test classes may be found in the infamous test6.pdf:
> +https://www.cl.cam.ac.uk/~pes20/ppc-supplemental/test6.pdf
> +Each class defines the pattern of accesses and of the variables accessed.
> +For example, if the one process writes to a pair of variables, and
> +the other process reads from these same variables, the corresponding
> +litmus-test class is "MP" (message passing), which may be found on the
> +left-hand end of the second row of tests on page one of test6.pdf.
> +
> +The strings used to identify the actions carried out by each process are
> +complex due to a desire to have short(er) names.  Thus, there is a tool =
to
> +generate these strings from a given litmus test's actions.  For example,
> +consider the processes from SB+rfionceonce-poonceonces.litmus:
> +
> +	P0(int *x, int *y)
> +	{
> +		int r1;
> +		int r2;
> +
> +		WRITE_ONCE(*x, 1);
> +		r1 =3D READ_ONCE(*x);
> +		r2 =3D READ_ONCE(*y);
> +	}
> +
> +	P1(int *x, int *y)
> +	{
> +		int r3;
> +		int r4;
> +
> +		WRITE_ONCE(*y, 1);
> +		r3 =3D READ_ONCE(*y);
> +		r4 =3D READ_ONCE(*x);
> +	}
> +
> +The next step is to construct a space-separated list of descriptors,
> +interleaving descriptions of the relation between a pair of consecutive
> +accesses with descriptions of the second access in the pair.
> +
> +P0()'s WRITE_ONCE() is read by its first READ_ONCE(), which is a
> +reads-from link (rf) and internal to the P0() process.  This is
> +"rfi", which is an abbreviation for "reads-from internal".  Because
> +some of the tools string these abbreviations together with space
> +characters separating processes, the first character is capitalized,
> +resulting in "Rfi".
> +
> +P0()'s second access is a READ_ONCE(), as opposed to (for example)
> +smp_load_acquire(), so next is "Once".  Thus far, we have "Rfi Once".
> +
> +P0()'s third access is also a READ_ONCE(), but to y rather than x.
> +This is related to P0()'s second access by program order ("po"),
> +to a different variable ("d"), and both accesses are reads ("RR").
> +The resulting descriptor is "PodRR".  Because P0()'s third access is
> +READ_ONCE(), we add another "Once" descriptor.
> +
> +A from-read ("fre") relation links P0()'s third to P1()'s first
> +access, and the resulting descriptor is "Fre".  P1()'s first access is
> +WRITE_ONCE(), which as before gives the descriptor "Once".  The string
> +thus far is thus "Rfi Once PodRR Once Fre Once".
> +
> +The remainder of P1() is similar to P0(), which means we add
> +"Rfi Once PodRR Once".  Another fre links P1()'s last access to
> +P0()'s first access, which is WRITE_ONCE(), so we add "Fre Once".
> +The full string is thus:
> +
> +	Rfi Once PodRR Once Fre Once Rfi Once PodRR Once Fre Once
> +
> +This string can be given to the "norm7" and "classify7" tools to
> +produce the name:
> +
> +$ norm7 -bell linux-kernel.bell Rfi Once PodRR Once Fre Once Rfi Once Po=
dRR Once Fre Once | sed -e 's/:.*//g'
> +SB+rfionceonce-poonceonces
> +
> +Adding the ".litmus" suffix: SB+rfionceonce-poonceonces.litmus
> +
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +LITMUS TEST DESCRIPTORS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +These descriptors cover connections between consecutive accesses within
> +the cycle through a given litmus test:
> +
> +Fre: From-read external.  The current process wrote a variable that
> +	the previous process read.  Example: The SB (store buffering) test.
> +Fri: From-read internal.  This process read a variable and then
> +	immediately wrote to it.  Example: ???
> +PodRR: Program-order different variable, read followed by read.
> +	This process read a variable and again read a different variable.
> +	Example: The read-side process in the MP (message-passing) test.
> +PodRW: Program-order different variable, read followed by write.
> +	This process read a variable and then wrote a different variable.
> +	Example: The LB (load buffering) test.
> +PodWR: Program-order different variable, write followed by read.
> +	This process wrote a variable and then read a different variable.
> +	Example: The SB (store buffering) test.
> +PodWW: Program-order different variable, write followed by write.
> +	This process wrote a variable and again wrote a different variable.
> +	Example: The write-side process in the MP (message-passing) test.
> +PosRR: Program-order same variable, read followed by read.
> +	This process read a variable and again read that same variable.
> +	Example: ???
> +PosRW: Program-order same variable, read followed by write.
> +	This process read a variable and then wrote that same variable.
> +	Example: ???
> +PosWR: Program-order same variable, write followed by read.
> +	This process wrote a variable and then read that same variable.
> +	Example: ???
> +PosWW: Program-order same variable, write followed by write.
> +	This process wrote a variable and again wrote that same variable.
> +	Example: ???
> +Rfe: Read-from external.  The current process read a variable written
> +	by the previous process.  Example: The MP (message passing) test.
> +Rfi: Read-from internal.  The current process wrote a variable and then
> +	immediately read the value back from it.  For the purposes of
> +	naming, Rfi acts identically to PosWR.	However, there are subtle
> +	but very real differences between them in other contexts.
> +	Example:  ???
> +Wse: Write same external.  The current process wrote to a variable that
> +	was also written to by the previous process.  Example:  ???
> +Wsi: Write same internal.  The current process wrote to a variable and
> +	then immediately wrote to it again.  Example:  ???
> +
> +Please note that the above is a partial list.  To see the full list of
> +descriptors, execute the following command:
> +
> +$ diyone7 -bell linux-kernel.bell -show edges
>=20
