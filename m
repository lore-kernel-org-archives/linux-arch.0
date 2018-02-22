Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:43744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753703AbeBVL7r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Feb 2018 06:59:47 -0500
Date: Thu, 22 Feb 2018 12:59:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S
 lock-based external-view litmus test
Message-ID: <20180222115929.GM25181@hirez.programming.kicks-ass.net>
References: <20180220232405.GA19274@linux.vnet.ibm.com>
 <1519169112-20593-10-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180222032349.klcuiq23f52sfop6@tardis>
 <20180222041357.GB2855@linux.vnet.ibm.com>
 <20180222052746.vofmqbpnmfahck3z@tardis>
 <fad8e18b-ef5a-5bc0-5d87-6fad2e9f7c95@nvidia.com>
 <20180222065847.zqiquiyehvzgiiht@tardis>
 <20180222101504.GQ25201@hirez.programming.kicks-ass.net>
 <20180222104532.6znly3zespgfga4i@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222104532.6znly3zespgfga4i@tardis>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>

On Thu, Feb 22, 2018 at 06:45:32PM +0800, Boqun Feng wrote:
> Maybe it's me who misunderstand Daniel's words. But my understanding is
> that riscv people are on a debate about whether their "RCpc" atomic
> instructions need to be more strict: release+acquire pair orders two
> writes. And I thought that atomics(including RmW atomics) in kernel only
> have purely RCpc semantics, which I needed to check with you guy. And if
> I'm right, it's cerntainly fine for riscv "RCpc" instruction to be
> purely RCpc.
> 
> Note that even on PPC, the release+acquire pair of atomics orders writes
> before and after, and on x86, writes are ordered since it's TSO. So
> strictly speaking, I think our current implementation of atomics are a
> little more strict than purely RCpc. If we think this is an requirement
> for implementation of atomic primitives, than the current version of
> riscv's "RCpc" atomics don't suffice.


So the question is:

P0()
{
	WRITE_ONCE(x, 1);
	smp_store_release(&y, 1);
	r0 = smp_load_acquire(&y);
	WRITE_ONCE(z, 1);
}

P1()
{
	r1 = READ_ONCE(z);
	smp_rmb();
	r2 = READ_ONCE(x);
}

exists: r0 == 1 /\ r1==1 /\ r2==0

Which per the current LKMM would be forbidden? How would strict RCpc
allow that? Due to a fwd from the release to the acquire and then
defeating the ordering or something like that?

My vote would go to disallowing this. Allowing this would be rather
subtle and unexpected IMO.
