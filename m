From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v3] tools/memory-model/Documentation: Fix "conflict"
 definition
Date: Mon, 2 Mar 2020 10:44:33 -0800
Message-ID: <20200302184433.GL2935@paulmck-ThinkPad-P72>
References: <20200302172101.157917-1-elver@google.com>
 <Pine.LNX.4.44L0.2003021256130.1555-100000@iolanthe.rowland.org>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbgCBSoe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Mar 2020 13:44:34 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2003021256130.1555-100000@iolanthe.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org, linux-arch@vger.kernel.org

On Mon, Mar 02, 2020 at 12:56:59PM -0500, Alan Stern wrote:
> On Mon, 2 Mar 2020, Marco Elver wrote:
> 
> > The definition of "conflict" should not include the type of access nor
> > whether the accesses are concurrent or not, which this patch addresses.
> > The definition of "data race" remains unchanged.
> > 
> > The definition of "conflict" as we know it and is cited by various
> > papers on memory consistency models appeared in [1]: "Two accesses to
> > the same variable conflict if at least one is a write; two operations
> > conflict if they execute conflicting accesses."
> > 
> > The LKMM as well as the C11 memory model are adaptations of
> > data-race-free, which are based on the work in [2]. Necessarily, we need
> > both conflicting data operations (plain) and synchronization operations
> > (marked). For example, C11's definition is based on [3], which defines a
> > "data race" as: "Two memory operations conflict if they access the same
> > memory location, and at least one of them is a store, atomic store, or
> > atomic read-modify-write operation. In a sequentially consistent
> > execution, two memory operations from different threads form a type 1
> > data race if they conflict, at least one of them is a data operation,
> > and they are adjacent in <T (i.e., they may be executed concurrently)."
> > 
> > [1] D. Shasha, M. Snir, "Efficient and Correct Execution of Parallel
> >     Programs that Share Memory", 1988.
> > 	URL: http://snir.cs.illinois.edu/listed/J21.pdf
> > 
> > [2] S. Adve, "Designing Memory Consistency Models for Shared-Memory
> >     Multiprocessors", 1993.
> > 	URL: http://sadve.cs.illinois.edu/Publications/thesis.pdf
> > 
> > [3] H.-J. Boehm, S. Adve, "Foundations of the C++ Concurrency Memory
> >     Model", 2008.
> > 	URL: https://www.hpl.hp.com/techreports/2008/HPL-2008-56.pdf
> > 
> > Signed-off-by: Marco Elver <elver@google.com>
> > Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > ---
> > v3:
> > * Apply Alan's suggestion.
> > * s/two race candidates/race candidates/
> 
> Looks good!

Applied, thank you both!

							Thanx, Paul
