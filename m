From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Date: Thu, 8 Oct 2015 13:16:38 +0200
Message-ID: <20151008111638.GL3816@twins.programming.kicks-ass.net>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55025 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755168AbbJHLQs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2015 07:16:48 -0400
Content-Disposition: inline
In-Reply-To: <1444276236.9940.5.camel@ellerman.id.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: paulmck@linux.vnet.ibm.com, Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org

On Thu, Oct 08, 2015 at 02:50:36PM +1100, Michael Ellerman wrote:
> On Wed, 2015-10-07 at 08:25 -0700, Paul E. McKenney wrote:

> > Currently, we do need smp_mb__after_unlock_lock() to be after the
> > acquisition on PPC -- putting it between the unlock and the lock
> > of course doesn't cut it for the cross-thread unlock/lock case.

This ^, that makes me think I don't understand
smp_mb__after_unlock_lock.

How is:

	UNLOCK x
	smp_mb__after_unlock_lock()
	LOCK y

a problem? That's still a full barrier.

> > I am with Peter -- we do need the benchmark results for PPC.
> 
> Urgh, sorry guys. I have been slowly doing some benchmarks, but time is not
> plentiful at the moment.
> 
> If we do a straight lwsync -> sync conversion for unlock it looks like that
> will cost us ~4.2% on Anton's standard context switch benchmark.

And that does not seem to agree with Paul's smp_mb__after_unlock_lock()
usage and would not be sufficient for the same (as of yet unexplained)
reason.

Why does it matter which of the LOCK or UNLOCK gets promoted to full
barrier on PPC in order to become RCsc?
