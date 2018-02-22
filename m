Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:49192 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752537AbeBVKPW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Feb 2018 05:15:22 -0500
Date: Thu, 22 Feb 2018 11:15:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S
 lock-based external-view litmus test
Message-ID: <20180222101504.GQ25201@hirez.programming.kicks-ass.net>
References: <20180220232405.GA19274@linux.vnet.ibm.com>
 <1519169112-20593-10-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180222032349.klcuiq23f52sfop6@tardis>
 <20180222041357.GB2855@linux.vnet.ibm.com>
 <20180222052746.vofmqbpnmfahck3z@tardis>
 <fad8e18b-ef5a-5bc0-5d87-6fad2e9f7c95@nvidia.com>
 <20180222065847.zqiquiyehvzgiiht@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222065847.zqiquiyehvzgiiht@tardis>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>

On Thu, Feb 22, 2018 at 02:58:47PM +0800, Boqun Feng wrote:
> > And yes, if we go with a purely RCpc interpretation of acquire and
> > release, then I don't believe the writes in the previous critical
> > section would be ordered with the writes in the subsequent critical
> > section.  That's really all the argument boils down to.  We'd like
> 
> I think atomics in Linux kernel(and in LKMM) are purely RCpc, right?
> Alan and Andrea? 
> 
> And we are not going to change it, are we?
> 
> If atomics in Linux kernel are purely RCpc, then it cerntainly makes
> sense for riscv to provide purely RCpc atomics.

So there's 3 things:

  smp_load_acquire(), smp_store_release()

  atomic*_{acquire,release}()

  *_{lock,unlock}();

Which are all quite distinct.

smp_load_acquire() and smp_store_release() are RCpc, and there is no
discussion of ever wanting to change that.

The atomics also follow this and are RCpc, in fact the RELEASE only
applies to the STORE and the ACQUIRE only applies to the LOAD of the
atomics.

The locking primitives OTOH we would really rather like to be RCsc, and
everybody except PPC has them as such, PPC being the only one having
RCpc locks.

I read the part you quoted from Daniel as being purely about spinlocks,
the 'critical section' wording being a dead give away, so I'm then
somewhat confused why you talk about atomics.
