From: Tony V E <tvaneerd@gmail.com>
Subject: Re: [isocpp-parallel] Proposal for new memory_order_consume definition
Date: Fri, 19 Feb 2016 21:15:16 -0500
Message-ID: <20160220021516.4898897.32908.5212@gmail.com>
References: <20160218011033.GA1505@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:33600 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992801AbcBTCPU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 19 Feb 2016 21:15:20 -0500
In-Reply-To: <20160218011033.GA1505@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <parallel@lists.isocpp.org>parallel@lists.isocpp.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, gcc@gcc.gnu.org, llvm-dev@lists.llvm.org
Cc: peterz@infradead.org, j.alglave@ucl.ac.uk, will.deacon@arm.com, dhowells@redhat.com, Ramana.Radhakrishnan@arm.com, luc.maranget@inria.fr, akpm@linux-foundation.org, Peter.Sewell@cl.cam.ac.uk, torvalds@linux-foundation.org, mingo@kernel.org

There's at least one easy answer in there:

> =E2=80=8EIf implementations must support annotation, what form should=
 that
	annotation take? =C2=A0P0190R0 recommends the [[carries_dependency]]
	attribute, but I am not picky as long as it can be (1) applied
	to all relevant pointer-like objects and (2) used in C as well
	as C++. =C2=A0;-)

If an implementation must support it, then it is not an annotation but =
a keyword. So no [[]]=C2=A0



Sent=C2=A0from=C2=A0my=C2=A0BlackBerry=C2=A0portable=C2=A0Babbage=C2=A0=
Device
=C2=A0 Original Message =C2=A0
=46rom: Paul E. McKenney
Sent: Thursday, February 18, 2016 4:58 AM
To: parallel@lists.isocpp.org; linux-kernel@vger.kernel.org; linux-arch=
@vger.kernel.org; gcc@gcc.gnu.org; llvm-dev@lists.llvm.org
Reply To: parallel@lists.isocpp.org
Cc: peterz@infradead.org; j.alglave@ucl.ac.uk; will.deacon@arm.com; dho=
wells@redhat.com; Ramana.Radhakrishnan@arm.com; luc.maranget@inria.fr; =
akpm@linux-foundation.org; Peter.Sewell@cl.cam.ac.uk; torvalds@linux-fo=
undation.org; mingo@kernel.org
Subject: [isocpp-parallel] Proposal for new memory_order_consume defini=
tion

Hello!

A proposal (quaintly identified as P0190R0) for a new memory_order_cons=
ume
definition may be found here:

http://www2.rdrop.com/users/paulmck/submission/consume.2016.02.10b.pdf

As requested at the October C++ Standards Committee meeting, this
is a follow-on to P0098R1 that picks one alternative and describes
it in detail. This approach focuses on existing practice, with the
goal of supporting existing code with existing compilers. In the last
clang/LLVM patch I saw for basic support of this change, you could coun=
t
the changed lines and still have lots of fingers and toes left over.
Those who have been following this story will recognize that this is
a very happy contrast to work that would be required to implement the
definition in the current standard.

I expect that P0190R0 will be discussed at the upcoming C++ Standards
Committee meeting taking place the week of February 29th. Points of
discussion are likely to include:

o	May memory_order_consume dependency ordering be used in
unannotated code? I believe that this must be the case,
especially given that this is our experience base. P0190R0
therefore recommends this approach.

o	If memory_order_consume dependency ordering can be used in
unannotated code, must implementations support annotation?
I believe that annotation support should be required, at the very
least for formal verification, which can be quite difficult to
carry out on unannotated code. In addition, it seems likely
that annotations can enable much better diagnostics. P0190R0
therefore recommends this approach.

o	If implementations must support annotation, what form should that
annotation take? P0190R0 recommends the [[carries_dependency]]
attribute, but I am not picky as long as it can be (1) applied
to all relevant pointer-like objects and (2) used in C as well
as C++. ;-)

o	If memory_order_consume dependency ordering can be used in
unannotated code, how best to define the situations where
the compiler can determine the exact value of the pointer in
question? (In current defacto implementations, this can
defeat dependency ordering. Interestingly enough, this case
is not present in the Linux kernel, but still needs to be
defined.)

Options include:

o	Provide new intrinsics that carry out the
comparisons, but guarantee to preserve dependencies,
as recommended by P0190R0 (std::pointer_cmp_eq_dep(),
std::pointer_cmp_ne_dep(), std::pointer_cmp_gt_dep(),
std::pointer_cmp_ge_dep(), std::pointer_cmp_lt_dep(),
and std::pointer_cmp_le_dep()).

o	State that -any- comparison involving an unannotated
pointer loses the dependency.

o	How is the common idiom of marking pointers by setting low-order
bits to be supported when those pointers carry dependencies?
At the moment, I believe that setting bits in pointers results in
undefined behavior even without dependency ordering, so P0190R0
kicks this particular can down the road. One option that
has been suggested is to provide intrinsics for this purpose.
(Sorry, but I forget who suggested this.)

Thoughts?

Thanx, Paul

_______________________________________________
Parallel mailing list
Parallel@lists.isocpp.org
Subscription: http://lists.isocpp.org/mailman/listinfo.cgi/parallel
Link to this post: http://lists.isocpp.org/parallel/2016/02/0040.php
