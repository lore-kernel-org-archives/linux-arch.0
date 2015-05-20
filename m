From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Compilers and RCU readers: Once more unto the breach!
Date: Tue, 19 May 2015 17:55:10 -0700
Message-ID: <20150520005510.GA23559@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:37283 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbbETAzV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 May 2015 20:55:21 -0400
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 19 May 2015 18:55:20 -0600
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, c++std-parallel@accu.org, linux-arch@vger.kernel.org, gcc@gcc.gnu.org
Cc: Peter.Sewell@cl.cam.ac.uk, torvalds@linux-foundation.org, Mark.Batty@cl.cam.ac.uk, peterz@infradead.org, will.deacon@arm.com, Ramana.Radhakrishnan@arm.com, dhowells@redhat.com, akpm@linux-foundation.org, mingo@kernel.org, michaelw@ca.ibm.com

Hello!

Following up on last year's discussion (https://lwn.net/Articles/586838/,
https://lwn.net/Articles/588300/), I believe that we have a solution.  If
I am wrong, I am sure you all will let me know, and in great detail.  ;-)

The key simplification is to "just say no" to RCU-protected array indexes:
https://lkml.org/lkml/2015/5/12/827, as was suggested by several people.
This simplification means that rcu_dereference (AKA memory_order_consume)
need only return pointers.  This in ture avoids things like (x-x),
(x*0), and (x%1) because if "x" is a pointer, these expressions either
return non-pointers are compilation errors.  With a very few exceptions,
dependency chains can lead -to- non-pointers, but cannot pass -through-
them.

The result is that dependencies are carried only by operations for
which the compiler cannot easily optimize the away those dependencies,
these operations including simple assignment, integer offset (including
indexing), dereferencing, casts, passing as a function argument, return
values from functions and so on.  A complete list with commentary starts
on page 28 of:

	http://www.rdrop.com/users/paulmck/RCU/consume.2015.05.18a.pdf

Dependency chains are broken if a pointer compares equal to some other
pointer not part of the same dependency chain, if too many bits are ORed
onto or ANDed off of a intptr_t or uintptr_t, or if the dependency is
explicitly killed (which should now strictly speaking never be necessary,
but which might allow better diagnostics).  These are set out in more
detail on page 30 of the above PDF.

This covers all the uses in the Linux kernel that I am aware of without
any source-code changes (other than to the rcu_dereference() primitives
themselves) and should also work for compilers and standards.

Thoughts?

							Thanx, Paul
