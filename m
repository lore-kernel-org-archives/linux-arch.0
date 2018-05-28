From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/memory-model] Add litmus-test naming scheme
Date: Mon, 28 May 2018 14:48:38 -0700
Message-ID: <20180528214838.GZ3803@linux.vnet.ibm.com>
References: <20180525191020.GA5914@linux.vnet.ibm.com>
 <20180528112010.GA8801@andrea>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180528112010.GA8801@andrea>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, May 28, 2018 at 01:20:10PM +0200, Andrea Parri wrote:
> On Fri, May 25, 2018 at 12:10:20PM -0700, Paul E. McKenney wrote:
> > This commit documents the scheme used to generate the names for the
> > litmus tests.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >  README |  136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 135 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
> > index 00140aaf58b7..b81f51054cd3 100644
> > --- a/tools/memory-model/litmus-tests/README
> > +++ b/tools/memory-model/litmus-tests/README
> > @@ -1,4 +1,6 @@
> > -This directory contains the following litmus tests:
> > +============
> > +LITMUS TESTS
> > +============
> >  
> >  CoRR+poonceonce+Once.litmus
> >  	Test of read-read coherence, that is, whether or not two
> > @@ -151,3 +153,135 @@ Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
> >  A great many more litmus tests are available here:
> >  
> >  	https://github.com/paulmckrcu/litmus
> > +
> > +==================
> > +LITMUS TEST NAMING
> > +==================
> > +
> > +Litmus tests are usually named based on their contents, which means that
> > +looking at the name tells you what the litmus test does.  The naming
> > +scheme covers litmus tests having a single cycle that passes through
> > +each process exactly once, so litmus tests not fitting this description
> > +are named on an ad-hoc basis.
> > +
> > +The structure of a litmus-test name is the litmus-test class, a plus
> > +sign ("+"), and one string for each process, separated by plus signs.
> > +The end of the name is ".litmus".
> 
> We used to distinguigh between the test name and the test filename; we
> currently have only one test whose name ends with .litmus:
> 
>   ISA2+pooncelock+pooncelock+pombonce.litmus
> 
> (that I missed until now...).

I queued a commit to fix this with your Reported-by, good catch!

> > +
> > +The litmus-test classes may be found in the infamous test6.pdf:
> > +https://www.cl.cam.ac.uk/~pes20/ppc-supplemental/test6.pdf
> > +Each class defines the pattern of accesses and of the variables accessed.
> > +For example, if the one process writes to a pair of variables, and
> > +the other process reads from these same variables, the corresponding
> > +litmus-test class is "MP" (message passing), which may be found on the
> > +left-hand end of the second row of tests on page one of test6.pdf.
> > +
> > +The strings used to identify the actions carried out by each process are
> > +complex due to a desire to have finite-length names.
> 
> I'm not sure what you mean here: can you elaborate/rephrase?

If we used Rfi, PodRW, and so on, the names would be even longer than
they are now.  This sentence now reads as follows:

	The strings used to identify the actions carried out by each
	process are complex due to a desire to have short(er) names.

> > Thus, there is a
> > +tool to generate these strings from a given litmus test's actions.  For
> > +example, consider the processes from SB+rfionceonce-poonceonces.litmus:
> > +
> > +	P0(int *x, int *y)
> > +	{
> > +		int r1;
> > +		int r2;
> > +
> > +		WRITE_ONCE(*x, 1);
> > +		r1 = READ_ONCE(*x);
> > +		r2 = READ_ONCE(*y);
> > +	}
> > +
> > +	P1(int *x, int *y)
> > +	{
> > +		int r3;
> > +		int r4;
> > +
> > +		WRITE_ONCE(*y, 1);
> > +		r3 = READ_ONCE(*y);
> > +		r4 = READ_ONCE(*x);
> > +	}
> > +
> > +The next step is to construct a space-separated list of descriptors,
> > +interleaving descriptions of the relation between a pair of consecutive
> > +accesses with descriptions of the second access in the pair.
> > +
> > +P0()'s WRITE_ONCE() is read by its first READ_ONCE(), which is a
> > +reads-from link (rf) and internal to the P0() process.  This is
> > +"rfi", which is an abbreviation for "reads-from internal".  Because
> > +some of the tools string these abbreviations together with space
> > +characters separating processes, the first character is capitalized,
> > +resulting in "Rfi".
> > +
> > +P0()'s second access is a READ_ONCE(), as opposed to (for example)
> > +smp_load_acquire(), so next is "Once".  Thus far, we have "Rfi Once".
> > +
> > +P0()'s third access is also a READ_ONCE(), but to y rather than x.
> > +This is related to P0()'s second access by program order ("po"),
> > +to a different variable ("d"), and both accesses are reads ("RR").
> > +The resulting descriptor is "PodRR".  Because P0()'s third access is
> > +READ_ONCE(), we add another "Once" descriptor.
> > +
> > +A from-read ("fre") relation links P0()'s third to P1()'s first
> > +access, and the resulting descriptor is "Fre".  P1()'s first access is
> > +WRITE_ONCE(), which as before gives the descriptor "Once".  The string
> > +thus far is thus "Rfi Once PodRR Once Fre Once".
> > +
> > +The remainder of P1() is similar to P0(), which means we add
> > +"Rfi Once PodRR Once".  Another fre links P1()'s last access to
> > +P0()'s first access, which is WRITE_ONCE(), so we add "Fre Once".
> > +The full string is thus:
> > +
> > +	Rfi Once PodRR Once Fre Once Rfi Once PodRR Once Fre Once
> > +
> > +This string can be given to the "norm7" and "classify7" tools to
> > +produce the name:
> > +
> > +$ norm7 -bell linux-kernel.bell Rfi Once PodRR Once Fre Once Rfi Once PodRR Once Fre Once |  classify7 -bell linux-kernel.bell -diyone | sed -e 's/:.*//g'
> > +SB+rfionceonce-poonceonces
> 
> We should check for the required version of herdtools7; a quick search
> here pointed out:
> 
>   ad5681da10fafb ("gen: add the tool 'norm' that normalise and name one cycle given as command line arguments.")
> 
> (so after v7.49), but I do remember a 'norm7' tool during my 'Parisian
> days', mmh...
> 
> I also notice that, with the current version, the above command can be
> simplified to:
> 
>   $ norm7 -bell linux-kernel.bell Rfi Once PodRR Once Fre Once Rfi Once PodRR Once Fre Once | sed -e 's/:.*//g'

Dropping the "classify7" command, correct?

> but we might want to list other commands for backward compatibility.

By the time this hits mainline, I bet there will be another herdtools
release, and the version number can be updated when that happens.  ;-)

> > +
> > +Adding the ".litmus" suffix: SB+rfionceonce-poonceonces.litmus
> > +
> > +
> > +=======================
> > +LITMUS TEST DESCRIPTORS
> > +=======================
> > +
> > +These descriptors cover connections between consecutive accesses:
> 
> Maybe expand to recall that we're referring to a particular cycle (the
> cycle referred to in the previous section)? (the term 'consecutive' is
> overloaded ;-)

Well, it is an English word, so overloading is the common case.  ;-)

How about this?

	These descriptors cover connections between consecutive accesses
	within the cycle through a given litmus test:

> > +
> > +Fre: From-read external.  The current process wrote a variable that
> > +	the previous process read.  Example: The SB (store buffering) test.
> > +Fri: From-read internal.  This process read a variable and then
> > +	immediately wrote to it.  Example: ???
> > +PodRR: Program-order different variable, read followed by read.
> > +	This process read a variable and again read a different variable.
> > +	Example: The read-side process in the MP (message-passing) test.
> > +PodRW: Program-order different variable, read followed by write.
> > +	This process read a variable and then wrote a different variable.
> > +	Example: The LB (load buffering) test.
> > +PodWR: Program-order different variable, write followed by read.
> > +	This process wrote a variable and then read a different variable.
> > +	Example: The SB (store buffering) test.
> > +PodWW: Program-order different variable, write followed by write.
> > +	This process wrote a variable and again wrote a different variable.
> > +	Example: The write-side process in the MP (message-passing) test.
> > +PosRR: Program-order same variable, read followed by read.
> > +	This process read a variable and again read that same variable.
> > +	Example: ???
> > +PosRW: Program-order same variable, read followed by write.
> > +	This process read a variable and then wrote that same variable.
> > +	Example: ???
> > +PosWR: Program-order same variable, write followed by read.
> > +	This process wrote a variable and then read that same variable.
> > +	Example: ???
> > +PosWW: Program-order same variable, write followed by write.
> > +	This process wrote a variable and again rrote that same variable.
> 
> s/rrote/wrote

Good catch, fixed.

> > +	Example: ???
> > +Rfe: Read-from external.  The current process read a variable written
> > +	by the previous process.  Example: The MP (message passing) test.
> > +Rfi: Read-from internal.  The current process wrote a variable and then
> > +	immediately read the value back from it.  Example:  ???
> > +	Comparison to PosWR???
> 
> I'm not sure if it is worth commenting on this, but compare, e.g., the
> 'exists' clauses of the following two tests (thinking at 'coherence'):
> 
> $ diyone7 -arch LISA PosWR PodRR Fre PosWR PodRR Fre
> LISA A
> "PosWR PodRR Fre PosWR PodRR Fre"
> Generator=diyone7 (version 7.49+02(dev))
> Prefetch=0:x=F,0:y=T,1:y=F,1:x=T
> Com=Fr Fr
> Orig=PosWR PodRR Fre PosWR PodRR Fre
> {
> }
>  P0       | P1       ;
>  w[] x 1  | w[] y 1  ;
>  r[] r0 x | r[] r0 y ;
>  r[] r1 y | r[] r1 x ;
> exists
> (0:r1=0 /\ 1:r1=0)
> 
> $ diyone7 -arch LISA Rfi PodRR Fre Rfi PodRR Fre
> LISA A
> "Rfi PodRR Fre Rfi PodRR Fre"
> Generator=diyone7 (version 7.49+02(dev))
> Prefetch=0:x=F,0:y=T,1:y=F,1:x=T
> Com=Fr Fr
> Orig=Rfi PodRR Fre Rfi PodRR Fre
> {
> }
>  P0       | P1       ;
>  w[] x 1  | w[] y 1  ;
>  r[] r0 x | r[] r0 y ;
>  r[] r1 y | r[] r1 x ;
> exists
> (0:r0=1 /\ 0:r1=0 /\ 1:r0=1 /\ 1:r1=0)

How about this?

fi: Read-from internal.  The current process wrote a variable and then
	immediately read the value back from it.  For the purposes of
	naming, Rfi acts identically to PosWR.	However, there are subtle
	but very real differences between them in other contexts.
	Example:  ???

> > +Wse: Write same external.  The current process wrote to a variable that
> > +	was also written to by the previous process.  Example:  ???
> > +Wsi: Write same internal.  The current process wrote to a variable and
> > +	then immediately wrote to it again.  Example:  ???
> 
> The list of descriptors is incomplete; the command:
> 
>   $ diyone7 -bell linux-kernel.bell -show edges
> 
> shows other descriptors (including fences and dependencies).  We might
> want to list this command; searching the commit history, I found:
> 
>    3c24730ef6c662 ("gen: Add a new command line option -show (edges|fences|annotations) that list various categories of candidate relaxations.")

Yow!!!

 CtrldR CtrldW CtrlsR CtrlsW DpAddrdR DpAddrdW DpAddrsR DpAddrsW DpCtrldR DpCtrldW DpCtrlsR DpCtrlsW DpDatadW DpDatasW Dpd* DpdR DpdW Dps* DpsR DpsW FenceAfter-atomic FenceAfter-atomicd** FenceAfter-atomicd*R FenceAfter-atomicd*W FenceAfter-atomicdR* FenceAfter-atomicdRR FenceAfter-atomicdRW FenceAfter-atomicdW* FenceAfter-atomicdWR FenceAfter-atomicdWW FenceAfter-atomics** FenceAfter-atomics*R FenceAfter-atomics*W FenceAfter-atomicsR* FenceAfter-atomicsRR FenceAfter-atomicsRW FenceAfter-atomicsW* FenceAfter-atomicsWR FenceAfter-atomicsWW FenceAfter-spinlock FenceAfter-spinlockd** FenceAfter-spinlockd*R FenceAfter-spinlockd*W FenceAfter-spinlockdR* FenceAfter-spinlockdRR FenceAfter-spinlockdRW FenceAfter-spinlockdW* FenceAfter-spinlockdWR FenceAfter-spinlockdWW FenceAfter-spinlocks** Fence
 After-spinlocks*R FenceAfter-spinlocks*W FenceAfter-spinlocksR* FenceAfter-spinlocksRR FenceAfter-spinlocksRW FenceAfter-spinlocksW* FenceAfter-spinlocksWR FenceAfter-spinlocksWW FenceBefore-atomic FenceBefore-atomicd** FenceBefore-atomicd*R FenceBefore-atomicd*W FenceBefore-atomicdR* FenceBefore-atomicdRR FenceBefore-atomicdRW FenceBefore-atomicdW* FenceBefore-atomicdWR FenceBefore-atomicdWW FenceBefore-atomics** FenceBefore-atomics*R FenceBefore-atomics*W FenceBefore-atomicsR* FenceBefore-atomicsRR FenceBefore-atomicsRW FenceBefore-atomicsW* FenceBefore-atomicsWR FenceBefore-atomicsWW FenceMb FenceMbd** FenceMbd*R FenceMbd*W FenceMbdR* FenceMbdRR FenceMbdRW FenceMbdW* FenceMbdWR FenceMbdWW FenceMbs** FenceMbs*R FenceMbs*W FenceMbsR* FenceMbsRR FenceMbsRW FenceMbsW* FenceMbsWR FenceMbsW
 W FenceRcu-lock FenceRcu-lockd** FenceRcu-lockd*R FenceRcu-lockd*W FenceRcu-lockdR* FenceRcu-lockdRR FenceRcu-lockdRW FenceRcu-lockdW* FenceRcu-lockdWR FenceRcu-lockdWW FenceRcu-locks** FenceRcu-locks*R FenceRcu-locks*W FenceRcu-locksR* FenceRcu-locksRR FenceRcu-locksRW FenceRcu-locksW* FenceRcu-locksWR FenceRcu-locksWW FenceRcu-unlock FenceRcu-unlockd** FenceRcu-unlockd*R FenceRcu-unlockd*W FenceRcu-unlockdR* FenceRcu-unlockdRR FenceRcu-unlockdRW FenceRcu-unlockdW* FenceRcu-unlockdWR FenceRcu-unlockdWW FenceRcu-unlocks** FenceRcu-unlocks*R FenceRcu-unlocks*W FenceRcu-unlocksR* FenceRcu-unlocksRR FenceRcu-unlocksRW FenceRcu-unlocksW* FenceRcu-unlocksWR FenceRcu-unlocksWW FenceRmb FenceRmbd** FenceRmbd*R FenceRmbd*W FenceRmbdR* FenceRmbdRR FenceRmbdRW FenceRmbdW* FenceRmbdWR FenceRmbdWW F
 enceRmbs** FenceRmbs*R FenceRmbs*W FenceRmbsR* FenceRmbsRR FenceRmbsRW FenceRmbsW* FenceRmbsWR FenceRmbsWW FenceSync-rcu FenceSync-rcud** FenceSync-rcud*R FenceSync-rcud*W FenceSync-rcudR* FenceSync-rcudRR FenceSync-rcudRW FenceSync-rcudW* FenceSync-rcudWR FenceSync-rcudWW FenceSync-rcus** FenceSync-rcus*R FenceSync-rcus*W FenceSync-rcusR* FenceSync-rcusRR FenceSync-rcusRW FenceSync-rcusW* FenceSync-rcusWR FenceSync-rcusWW FenceWmb FenceWmbd** FenceWmbd*R FenceWmbd*W FenceWmbdR* FenceWmbdRR FenceWmbdRW FenceWmbdW* FenceWmbdWR FenceWmbdWW FenceWmbs** FenceWmbs*R FenceWmbs*W FenceWmbsR* FenceWmbsRR FenceWmbsRW FenceWmbsW* FenceWmbsWR FenceWmbsWW Fenced** Fenced*R Fenced*W FencedR* FencedRR FencedRW FencedW* FencedWR FencedWW Fences** Fences*R Fences*W FencesR* FencesRR FencesRW FencesW* Fe
 ncesWR FencesWW FrBack FrLeave Fre Fri Hat Na Pod** Pod*R Pod*W PodR* PodRR PodRW PodW* PodWR PodWW Pos** Pos*R Pos*W PosR* PosRR PosRW PosW* PosWR PosWW R Read RfBack RfLeave Rfe Rfi Rmw W Write WsBack WsLeave Wse Wsi

I added the following at the end:

Please note that the above is a partial list.  To see the full list of
descriptors, execute the following command:

$ diyone7 -bell linux-kernel.bell -show edges

> I also notice that our current names for tests with fences (and cycle)
> deviate from the corresponding 'norm7' results; e.g.,
> 
>   $ norm7 -bell linux-kernel.bell FenceWmbdWW Once Rfe Once FenceRmbdRR Once Fre Once | sed -e 's/:.*//g'
>   MP+fencewmbonceonce+fencermbonceonce
> 
> while we use 'MP+wmbonceonce+rmbonceonce' (that is, we omit the 'fence'
> prefixes).

Would you be willing to send me a patch fixing them up?

Please see below for updated patch.

							Thanx, Paul

------------------------------------------------------------------------

commit 04a897a8e202e8d79dd47910321f0e8efb081854
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Fri May 25 12:02:53 2018 -0700

    EXP tools/memory-model: Add litmus-test naming scheme
    
    This commit documents the scheme used to generate the names for the
    litmus tests.
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    [ paulmck: Apply feedback from Andrea Parri. ]

diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 00140aaf58b7..9c0ea65c5362 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -1,4 +1,6 @@
-This directory contains the following litmus tests:
+============
+LITMUS TESTS
+============
 
 CoRR+poonceonce+Once.litmus
 	Test of read-read coherence, that is, whether or not two
@@ -151,3 +153,143 @@ Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
 A great many more litmus tests are available here:
 
 	https://github.com/paulmckrcu/litmus
+
+==================
+LITMUS TEST NAMING
+==================
+
+Litmus tests are usually named based on their contents, which means that
+looking at the name tells you what the litmus test does.  The naming
+scheme covers litmus tests having a single cycle that passes through
+each process exactly once, so litmus tests not fitting this description
+are named on an ad-hoc basis.
+
+The structure of a litmus-test name is the litmus-test class, a plus
+sign ("+"), and one string for each process, separated by plus signs.
+The end of the name is ".litmus".
+
+The litmus-test classes may be found in the infamous test6.pdf:
+https://www.cl.cam.ac.uk/~pes20/ppc-supplemental/test6.pdf
+Each class defines the pattern of accesses and of the variables accessed.
+For example, if the one process writes to a pair of variables, and
+the other process reads from these same variables, the corresponding
+litmus-test class is "MP" (message passing), which may be found on the
+left-hand end of the second row of tests on page one of test6.pdf.
+
+The strings used to identify the actions carried out by each process are
+complex due to a desire to have short(er) names.  Thus, there is a tool to
+generate these strings from a given litmus test's actions.  For example,
+consider the processes from SB+rfionceonce-poonceonces.litmus:
+
+	P0(int *x, int *y)
+	{
+		int r1;
+		int r2;
+
+		WRITE_ONCE(*x, 1);
+		r1 = READ_ONCE(*x);
+		r2 = READ_ONCE(*y);
+	}
+
+	P1(int *x, int *y)
+	{
+		int r3;
+		int r4;
+
+		WRITE_ONCE(*y, 1);
+		r3 = READ_ONCE(*y);
+		r4 = READ_ONCE(*x);
+	}
+
+The next step is to construct a space-separated list of descriptors,
+interleaving descriptions of the relation between a pair of consecutive
+accesses with descriptions of the second access in the pair.
+
+P0()'s WRITE_ONCE() is read by its first READ_ONCE(), which is a
+reads-from link (rf) and internal to the P0() process.  This is
+"rfi", which is an abbreviation for "reads-from internal".  Because
+some of the tools string these abbreviations together with space
+characters separating processes, the first character is capitalized,
+resulting in "Rfi".
+
+P0()'s second access is a READ_ONCE(), as opposed to (for example)
+smp_load_acquire(), so next is "Once".  Thus far, we have "Rfi Once".
+
+P0()'s third access is also a READ_ONCE(), but to y rather than x.
+This is related to P0()'s second access by program order ("po"),
+to a different variable ("d"), and both accesses are reads ("RR").
+The resulting descriptor is "PodRR".  Because P0()'s third access is
+READ_ONCE(), we add another "Once" descriptor.
+
+A from-read ("fre") relation links P0()'s third to P1()'s first
+access, and the resulting descriptor is "Fre".  P1()'s first access is
+WRITE_ONCE(), which as before gives the descriptor "Once".  The string
+thus far is thus "Rfi Once PodRR Once Fre Once".
+
+The remainder of P1() is similar to P0(), which means we add
+"Rfi Once PodRR Once".  Another fre links P1()'s last access to
+P0()'s first access, which is WRITE_ONCE(), so we add "Fre Once".
+The full string is thus:
+
+	Rfi Once PodRR Once Fre Once Rfi Once PodRR Once Fre Once
+
+This string can be given to the "norm7" and "classify7" tools to
+produce the name:
+
+$ norm7 -bell linux-kernel.bell Rfi Once PodRR Once Fre Once Rfi Once PodRR Once Fre Once | sed -e 's/:.*//g'
+SB+rfionceonce-poonceonces
+
+Adding the ".litmus" suffix: SB+rfionceonce-poonceonces.litmus
+
+
+=======================
+LITMUS TEST DESCRIPTORS
+=======================
+
+These descriptors cover connections between consecutive accesses within
+the cycle through a given litmus test:
+
+Fre: From-read external.  The current process wrote a variable that
+	the previous process read.  Example: The SB (store buffering) test.
+Fri: From-read internal.  This process read a variable and then
+	immediately wrote to it.  Example: ???
+PodRR: Program-order different variable, read followed by read.
+	This process read a variable and again read a different variable.
+	Example: The read-side process in the MP (message-passing) test.
+PodRW: Program-order different variable, read followed by write.
+	This process read a variable and then wrote a different variable.
+	Example: The LB (load buffering) test.
+PodWR: Program-order different variable, write followed by read.
+	This process wrote a variable and then read a different variable.
+	Example: The SB (store buffering) test.
+PodWW: Program-order different variable, write followed by write.
+	This process wrote a variable and again wrote a different variable.
+	Example: The write-side process in the MP (message-passing) test.
+PosRR: Program-order same variable, read followed by read.
+	This process read a variable and again read that same variable.
+	Example: ???
+PosRW: Program-order same variable, read followed by write.
+	This process read a variable and then wrote that same variable.
+	Example: ???
+PosWR: Program-order same variable, write followed by read.
+	This process wrote a variable and then read that same variable.
+	Example: ???
+PosWW: Program-order same variable, write followed by write.
+	This process wrote a variable and again wrote that same variable.
+	Example: ???
+Rfe: Read-from external.  The current process read a variable written
+	by the previous process.  Example: The MP (message passing) test.
+Rfi: Read-from internal.  The current process wrote a variable and then
+	immediately read the value back from it.  For the purposes of
+	naming, Rfi acts identically to PosWR.	However, there are subtle
+	but very real differences between them in other contexts.
+	Example:  ???
+Wse: Write same external.  The current process wrote to a variable that
+	was also written to by the previous process.  Example:  ???
+Wsi: Write same internal.  The current process wrote to a variable and
+	then immediately wrote to it again.  Example:  ???
+
+Please note that the above is a partial list.  To see the full list of
+descriptors, execute the following command:
+
+$ diyone7 -bell linux-kernel.bell -show edges
