From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2] tools/memory-model/Documentation: Fix "conflict"
 definition
Date: Mon, 2 Mar 2020 10:28:42 -0800
Message-ID: <20200302182841.GJ2935@paulmck-ThinkPad-P72>
References: <20200302141819.40270-1-elver@google.com>
 <8d5fdc95ed3847508bf0d523f41a5862@AcuMS.aculab.com>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgCBS2n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Mar 2020 13:28:43 -0500
Content-Disposition: inline
In-Reply-To: <8d5fdc95ed3847508bf0d523f41a5862@AcuMS.aculab.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Marco Elver' <elver@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "parri.andrea@gmail.com" <parri.andrea@gmail.com>, "will@kernel.org" <will@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "npiggin@gmail.com" <npiggin@gmail.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>, "luc.maranget@inria.fr" <luc.maranget@inria.fr>, "akiyks@gmail.com" <akiyks@gmail.com>, "dlustig@nvidia.com" <dlustig@nvidia.com>, "joel@joelfernandes.org" <joel@joelfernandes.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Mon, Mar 02, 2020 at 05:44:11PM +0000, David Laight wrote:
> From: Marco Elver
> > Sent: 02 March 2020 14:18
> > 
> > The definition of "conflict" should not include the type of access nor
> > whether the accesses are concurrent or not, which this patch addresses.
> > The definition of "data race" remains unchanged.
> > 
> > The definition of "conflict" as we know it and is cited by various
> > papers on memory consistency models appeared in [1]: "Two accesses to
> > the same variable conflict if at least one is a write; two operations
> > conflict if they execute conflicting accesses."
> 
> I'm pretty sure that Linux requires that the underlying memory
> subsystem remove any possible 'conflicts' by serialising the
> requests (in an arbitrary order).
> 
> So 'conflicts' are never relevant.
> 
> There are memory subsystems where conflicts MUST be avoided.
> For instance the fpga I use have some dual-ported memory.
> Concurrent accesses on the two ports for the same address
> must (usually) be avoided if one is a write.
> Two writes will generate corrupt memory.
> A concurrent write+read will generate a garbage read.
> In the special case where the two ports use the same clock
> it is possible to force the read to be 'old data' but that
> constrains the timings.
> 
> On such systems the code must avoid conflicting cycles.

That would be yet another definition of "conflicts".  Quite relevant on
some older hardware I have worked with.  But what we are concerned with
here are cases where (as you say) the memory subsystem will do just fine,
but where the fact that the memory subsystem is called upon to do the
necessary serialization constitutes a bug of some sort.

There are unfortunately a wide variety of definitions and opinions as
to exactly what sorts of conflicts constitute bugs.  The generic pattern
for these definitions and opinions is "a concurrent set of insufficiently
marked accesses to a given location, at least one of which is a write".

The differences in definitions and opinions center around exactly what
is meant by the word "insufficiently" in this last sentence.  We will
probably be tolerating some variety of definitions in the kernel,
and given the wide variety of code contained therein, this should be
just fine.

							Thanx, Paul
