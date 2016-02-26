From: Lawrence Crowl <Lawrence@Crowl.org>
Subject: Re: [isocpp-parallel] Proposal for new memory_order_consume definition
Date: Fri, 26 Feb 2016 15:56:59 -0800
Message-ID: <CAA+UVZQtzmY3Df8kh_9k5KXstephApm1cWhKumXLVNRetFqGtQ@mail.gmail.com>
References: <20160218011033.GA1505@linux.vnet.ibm.com>
	<20160220021516.4898897.32908.5212@gmail.com>
	<20160220195318.GF3522@linux.vnet.ibm.com>
	<CAPUmR1bw=N4NkjAK1zn_X0+84KEaEAM6HZCHZJy_txqC9hMgSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:34253 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754279AbcBZX5B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Feb 2016 18:57:01 -0500
In-Reply-To: <CAPUmR1bw=N4NkjAK1zn_X0+84KEaEAM6HZCHZJy_txqC9hMgSg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: parallel@lists.isocpp.org
Cc: linux-arch@vger.kernel.org, gcc@gcc.gnu.org, p796231 <Peter.Sewell@cl.cam.ac.uk>, llvm-dev@lists.llvm.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, peterz@infradead.org, Ramana.Radhakrishnan@arm.com, Luc Maranget <luc.maranget@inria.fr>, akpm@linux-foundation.org, Jade Alglave <j.alglave@ucl.ac.uk>, torvalds@linux-foundation.org, mingo@kernel.org

On 2/25/16, Hans Boehm <boehm@acm.org> wrote:
> If carries_dependency affects semantics, then it should not be an
> attribute.
>
> The original design, or at least my understanding of it, was that it =
not
> have semantics; it was only a suggestion to the compiler that it shou=
ld
> preserve dependencies instead of inserting a fence at the call site.
> Dependency-based ordering would be preserved in either case.

Yes, but there is a performance penalty, though I do not know how sever=
e.
When do the pragmatics become sufficiently severe that they become
semantics?

> But I think we're moving away from that view towards something that d=
oesn't
> quietly add fences.
>
> I do not think we can quite get away with defining a dependency in a =
way
> that is unconditionally preserved by existing compilers, and thus I t=
hink
> that we do probably need annotations along the dependency path.  I ju=
st
> don't see a way to otherwise deal with the case in which a compiler i=
nfers
> an equivalent pointer and dereferences that instead of the original. =
 This
> can happen under so many (unlikely but) hard-to-define conditions tha=
t it
> seems undefinable in an implementation-independent manner. "If the
> implementation is able then <the semantics change>" is, in my opinion=
, not
> acceptable standards text.
>
> Thus I see no way to both avoid adding syntax to functions that prese=
rve
> dependencies and continue to allow existing transformations that remo=
ve
> dependencies we care about, e.g. due to equality comparisons.  We can
> hopefully ensure that without annotations compilers break things with=
 very
> low probability, so that there is a reasonable path forward for exist=
ing
> code relying on dependency ordering (which currently also breaks with=
 very
> low probability unless you understand what the compiler is doing).  B=
ut I
> don't see a way for the standard to guarantee correctness without the=
 added
> syntax (or added optimization constraints that effectively assume all
> functions were annotated).
>
> On Sat, Feb 20, 2016 at 11:53 AM, Paul E. McKenney <
> paulmck@linux.vnet.ibm.com> wrote:
>
>> On Fri, Feb 19, 2016 at 09:15:16PM -0500, Tony V E wrote:
>> > There's at least one easy answer in there:
>> >
>> > > =E2=80=8EIf implementations must support annotation, what form s=
hould that
>> >       annotation take?  P0190R0 recommends the [[carries_dependenc=
y]]
>> >       attribute, but I am not picky as long as it can be (1) appli=
ed
>> >       to all relevant pointer-like objects and (2) used in C as we=
ll
>> >       as C++.  ;-)
>> >
>> > If an implementation must support it, then it is not an annotation=
 but
>> > a
>> keyword. So no [[]]
>>
>> I would be good with that approach, especially if the WG14 continues
>> to stay away from annotations.
>>
>> For whatever it is worth, the introduction of intrinsics for compari=
sons
>> that avoid breaking dependencies enables the annotation to remain
>> optional.
>>
>>                                                         Thanx, Paul
>>
>> > Sent from my BlackBerry portable Babbage Device
>> >   Original Message
>> > From: Paul E. McKenney
>> > Sent: Thursday, February 18, 2016 4:58 AM
>> > To: parallel@lists.isocpp.org; linux-kernel@vger.kernel.org;
>> linux-arch@vger.kernel.org; gcc@gcc.gnu.org; llvm-dev@lists.llvm.org
>> > Reply To: parallel@lists.isocpp.org
>> > Cc: peterz@infradead.org; j.alglave@ucl.ac.uk; will.deacon@arm.com=
;
>> dhowells@redhat.com; Ramana.Radhakrishnan@arm.com; luc.maranget@inri=
a.fr;
>> akpm@linux-foundation.org; Peter.Sewell@cl.cam.ac.uk;
>> torvalds@linux-foundation.org; mingo@kernel.org
>> > Subject: [isocpp-parallel] Proposal for new memory_order_consume
>> definition
>> >
>> > Hello!
>> >
>> > A proposal (quaintly identified as P0190R0) for a new
>> memory_order_consume
>> > definition may be found here:
>> >
>> > http://www2.rdrop.com/users/paulmck/submission/consume.2016.02.10b=
=2Epdf
>> >
>> > As requested at the October C++ Standards Committee meeting, this
>> > is a follow-on to P0098R1 that picks one alternative and describes
>> > it in detail. This approach focuses on existing practice, with the
>> > goal of supporting existing code with existing compilers. In the l=
ast
>> > clang/LLVM patch I saw for basic support of this change, you could
>> > count
>> > the changed lines and still have lots of fingers and toes left ove=
r.
>> > Those who have been following this story will recognize that this =
is
>> > a very happy contrast to work that would be required to implement =
the
>> > definition in the current standard.
>> >
>> > I expect that P0190R0 will be discussed at the upcoming C++ Standa=
rds
>> > Committee meeting taking place the week of February 29th. Points o=
f
>> > discussion are likely to include:
>> >
>> > o     May memory_order_consume dependency ordering be used in
>> > unannotated code? I believe that this must be the case,
>> > especially given that this is our experience base. P0190R0
>> > therefore recommends this approach.
>> >
>> > o     If memory_order_consume dependency ordering can be used in
>> > unannotated code, must implementations support annotation?
>> > I believe that annotation support should be required, at the very
>> > least for formal verification, which can be quite difficult to
>> > carry out on unannotated code. In addition, it seems likely
>> > that annotations can enable much better diagnostics. P0190R0
>> > therefore recommends this approach.
>> >
>> > o     If implementations must support annotation, what form should=
 that
>> > annotation take? P0190R0 recommends the [[carries_dependency]]
>> > attribute, but I am not picky as long as it can be (1) applied
>> > to all relevant pointer-like objects and (2) used in C as well
>> > as C++. ;-)
>> >
>> > o     If memory_order_consume dependency ordering can be used in
>> > unannotated code, how best to define the situations where
>> > the compiler can determine the exact value of the pointer in
>> > question? (In current defacto implementations, this can
>> > defeat dependency ordering. Interestingly enough, this case
>> > is not present in the Linux kernel, but still needs to be
>> > defined.)
>> >
>> > Options include:
>> >
>> > o     Provide new intrinsics that carry out the
>> > comparisons, but guarantee to preserve dependencies,
>> > as recommended by P0190R0 (std::pointer_cmp_eq_dep(),
>> > std::pointer_cmp_ne_dep(), std::pointer_cmp_gt_dep(),
>> > std::pointer_cmp_ge_dep(), std::pointer_cmp_lt_dep(),
>> > and std::pointer_cmp_le_dep()).
>> >
>> > o     State that -any- comparison involving an unannotated
>> > pointer loses the dependency.
>> >
>> > o     How is the common idiom of marking pointers by setting low-o=
rder
>> > bits to be supported when those pointers carry dependencies?
>> > At the moment, I believe that setting bits in pointers results in
>> > undefined behavior even without dependency ordering, so P0190R0
>> > kicks this particular can down the road. One option that
>> > has been suggested is to provide intrinsics for this purpose.
>> > (Sorry, but I forget who suggested this.)
>> >
>> > Thoughts?
>> >
>> > Thanx, Paul
>> >
>> > _______________________________________________
>> > Parallel mailing list
>> > Parallel@lists.isocpp.org
>> > Subscription: http://lists.isocpp.org/mailman/listinfo.cgi/paralle=
l
>> > Link to this post: http://lists.isocpp.org/parallel/2016/02/0040.p=
hp
>> > _______________________________________________
>> > Parallel mailing list
>> > Parallel@lists.isocpp.org
>> > Subscription: http://lists.isocpp.org/mailman/listinfo.cgi/paralle=
l
>> > Link to this post: http://lists.isocpp.org/parallel/2016/02/0045.p=
hp
>>
>> _______________________________________________
>> Parallel mailing list
>> Parallel@lists.isocpp.org
>> Subscription: http://lists.isocpp.org/mailman/listinfo.cgi/parallel
>> Link to this post: http://lists.isocpp.org/parallel/2016/02/0046.php
>


--=20
Lawrence Crowl
