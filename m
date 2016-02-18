From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Proposal for new memory_order_consume definition
Date: Wed, 17 Feb 2016 17:10:33 -0800
Message-ID: <20160218011033.GA1505@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:54113 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbcBRBKz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Feb 2016 20:10:55 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 17 Feb 2016 18:10:55 -0700
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: parallel@lists.isocpp.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, gcc@gcc.gnu.org, llvm-dev@lists.llvm.org
Cc: Peter.Sewell@cl.cam.ac.uk, torvalds@linux-foundation.org, Mark.Batty@cl.cam.ac.uk, peterz@infradead.org, will.deacon@arm.com, Ramana.Radhakrishnan@arm.com, dhowells@redhat.com, akpm@linux-foundation.org, mingo@kernel.org, michaelw@ca.ibm.com, boehm@acm.org, Jens.Maurer@gmx.net, luc.maranget@inria.fr, j.alglave@ucl.ac.uk

Hello!

A proposal (quaintly identified as P0190R0) for a new memory_order_consume
definition may be found here:

	http://www2.rdrop.com/users/paulmck/submission/consume.2016.02.10b.pdf

As requested at the October C++ Standards Committee meeting, this
is a follow-on to P0098R1 that picks one alternative and describes
it in detail.  This approach focuses on existing practice, with the
goal of supporting existing code with existing compilers.  In the last
clang/LLVM patch I saw for basic support of this change, you could count
the changed lines and still have lots of fingers and toes left over.
Those who have been following this story will recognize that this is
a very happy contrast to work that would be required to implement the
definition in the current standard.

I expect that P0190R0 will be discussed at the upcoming C++ Standards
Committee meeting taking place the week of February 29th.  Points of
discussion are likely to include:

o	May memory_order_consume dependency ordering be used in
	unannotated code?  I believe that this must be the case,
	especially given that this is our experience base.  P0190R0
	therefore recommends this approach.

o	If memory_order_consume dependency ordering can be used in
	unannotated code, must implementations support annotation?
	I believe that annotation support should be required, at the very
	least for formal verification, which can be quite difficult to
	carry out on unannotated code.  In addition, it seems likely
	that annotations can enable much better diagnostics.  P0190R0
	therefore recommends this approach.

o	If implementations must support annotation, what form should that
	annotation take?  P0190R0 recommends the [[carries_dependency]]
	attribute, but I am not picky as long as it can be (1) applied
	to all relevant pointer-like objects and (2) used in C as well
	as C++.  ;-)

o	If memory_order_consume dependency ordering can be used in
	unannotated code, how best to define the situations where
	the compiler can determine the exact value of the pointer in
	question?  (In current defacto implementations, this can
	defeat dependency ordering.  Interestingly enough, this case
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
	kicks this particular can down the road.  One option that
	has been suggested is to provide intrinsics for this purpose.
	(Sorry, but I forget who suggested this.)

Thoughts?

							Thanx, Paul
