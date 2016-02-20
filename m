From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [isocpp-parallel] Proposal for new memory_order_consume
 definition
Date: Sat, 20 Feb 2016 11:53:18 -0800
Message-ID: <20160220195318.GF3522@linux.vnet.ibm.com>
References: <20160218011033.GA1505@linux.vnet.ibm.com>
 <20160220021516.4898897.32908.5212@gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e17.ny.us.ibm.com ([129.33.205.207]:37276 "EHLO
	e17.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbcBTTxS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 20 Feb 2016 14:53:18 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Sat, 20 Feb 2016 14:53:17 -0500
Content-Disposition: inline
In-Reply-To: <20160220021516.4898897.32908.5212@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: parallel@lists.isocpp.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, gcc@gcc.gnu.org, llvm-dev@lists.llvm.org, Peter.Sewell@cl.cam.ac.uk, peterz@infradead.org, will.deacon@arm.com, dhowells@redhat.com, Ramana.Radhakrishnan@arm.com, luc.maranget@inria.fr, akpm@linux-foundation.org, j.alglave@ucl.ac.uk, torvalds@linux-foundation.org, mingo@kernel.org

On Fri, Feb 19, 2016 at 09:15:16PM -0500, Tony V E wrote:
> There's at least one easy answer in there:
>=20
> > =E2=80=8EIf implementations must support annotation, what form shou=
ld that
> 	annotation take? =C2=A0P0190R0 recommends the [[carries_dependency]]
> 	attribute, but I am not picky as long as it can be (1) applied
> 	to all relevant pointer-like objects and (2) used in C as well
> 	as C++. =C2=A0;-)
>=20
> If an implementation must support it, then it is not an annotation bu=
t a keyword. So no [[]]=C2=A0

I would be good with that approach, especially if the WG14 continues
to stay away from annotations.

=46or whatever it is worth, the introduction of intrinsics for comparis=
ons
that avoid breaking dependencies enables the annotation to remain
optional.

							Thanx, Paul

> Sent=C2=A0from=C2=A0my=C2=A0BlackBerry=C2=A0portable=C2=A0Babbage=C2=A0=
Device
> =C2=A0 Original Message =C2=A0
> From: Paul E. McKenney
> Sent: Thursday, February 18, 2016 4:58 AM
> To: parallel@lists.isocpp.org; linux-kernel@vger.kernel.org; linux-ar=
ch@vger.kernel.org; gcc@gcc.gnu.org; llvm-dev@lists.llvm.org
> Reply To: parallel@lists.isocpp.org
> Cc: peterz@infradead.org; j.alglave@ucl.ac.uk; will.deacon@arm.com; d=
howells@redhat.com; Ramana.Radhakrishnan@arm.com; luc.maranget@inria.fr=
; akpm@linux-foundation.org; Peter.Sewell@cl.cam.ac.uk; torvalds@linux-=
foundation.org; mingo@kernel.org
> Subject: [isocpp-parallel] Proposal for new memory_order_consume defi=
nition
>=20
> Hello!
>=20
> A proposal (quaintly identified as P0190R0) for a new memory_order_co=
nsume
> definition may be found here:
>=20
> http://www2.rdrop.com/users/paulmck/submission/consume.2016.02.10b.pd=
f
>=20
> As requested at the October C++ Standards Committee meeting, this
> is a follow-on to P0098R1 that picks one alternative and describes
> it in detail. This approach focuses on existing practice, with the
> goal of supporting existing code with existing compilers. In the last
> clang/LLVM patch I saw for basic support of this change, you could co=
unt
> the changed lines and still have lots of fingers and toes left over.
> Those who have been following this story will recognize that this is
> a very happy contrast to work that would be required to implement the
> definition in the current standard.
>=20
> I expect that P0190R0 will be discussed at the upcoming C++ Standards
> Committee meeting taking place the week of February 29th. Points of
> discussion are likely to include:
>=20
> o	May memory_order_consume dependency ordering be used in
> unannotated code? I believe that this must be the case,
> especially given that this is our experience base. P0190R0
> therefore recommends this approach.
>=20
> o	If memory_order_consume dependency ordering can be used in
> unannotated code, must implementations support annotation?
> I believe that annotation support should be required, at the very
> least for formal verification, which can be quite difficult to
> carry out on unannotated code. In addition, it seems likely
> that annotations can enable much better diagnostics. P0190R0
> therefore recommends this approach.
>=20
> o	If implementations must support annotation, what form should that
> annotation take? P0190R0 recommends the [[carries_dependency]]
> attribute, but I am not picky as long as it can be (1) applied
> to all relevant pointer-like objects and (2) used in C as well
> as C++. ;-)
>=20
> o	If memory_order_consume dependency ordering can be used in
> unannotated code, how best to define the situations where
> the compiler can determine the exact value of the pointer in
> question? (In current defacto implementations, this can
> defeat dependency ordering. Interestingly enough, this case
> is not present in the Linux kernel, but still needs to be
> defined.)
>=20
> Options include:
>=20
> o	Provide new intrinsics that carry out the
> comparisons, but guarantee to preserve dependencies,
> as recommended by P0190R0 (std::pointer_cmp_eq_dep(),
> std::pointer_cmp_ne_dep(), std::pointer_cmp_gt_dep(),
> std::pointer_cmp_ge_dep(), std::pointer_cmp_lt_dep(),
> and std::pointer_cmp_le_dep()).
>=20
> o	State that -any- comparison involving an unannotated
> pointer loses the dependency.
>=20
> o	How is the common idiom of marking pointers by setting low-order
> bits to be supported when those pointers carry dependencies?
> At the moment, I believe that setting bits in pointers results in
> undefined behavior even without dependency ordering, so P0190R0
> kicks this particular can down the road. One option that
> has been suggested is to provide intrinsics for this purpose.
> (Sorry, but I forget who suggested this.)
>=20
> Thoughts?
>=20
> Thanx, Paul
>=20
> _______________________________________________
> Parallel mailing list
> Parallel@lists.isocpp.org
> Subscription: http://lists.isocpp.org/mailman/listinfo.cgi/parallel
> Link to this post: http://lists.isocpp.org/parallel/2016/02/0040.php
> _______________________________________________
> Parallel mailing list
> Parallel@lists.isocpp.org
> Subscription: http://lists.isocpp.org/mailman/listinfo.cgi/parallel
> Link to this post: http://lists.isocpp.org/parallel/2016/02/0045.php
