From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] barriers: introduce smp_mb__release_acquire and
 update documentation
Date: Wed, 27 Jan 2016 19:25:51 +0100
Message-ID: <20160127182551.GX6357@twins.programming.kicks-ass.net>
References: <1453918924-27606-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:57550 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934590AbcA0SZy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2016 13:25:54 -0500
Content-Disposition: inline
In-Reply-To: <1453918924-27606-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Wed, Jan 27, 2016 at 06:22:04PM +0000, Will Deacon wrote:
> As much as we'd like to live in a world where RELEASE -> ACQUIRE is
> always cheaply ordered and can be used to construct UNLOCK -> LOCK
> definitions with similar guarantees, the grim reality is that this isn't
> even possible on x86 (thanks to Paul for bringing us crashing down to
> Earth).
> 
> This patch handles the issue by introducing a new barrier macro,
> smp_mb__after_release_acquire, that can be placed after an ACQUIRE that
> either reads from a RELEASE or is in program-order after a RELEASE. The
> barrier upgrades the RELEASE-ACQUIRE pair to a full memory barrier,
> implying global transitivity. At the moment, it doesn't have any users,
> so its existence serves mainly as a documentation aid and a potential
> stepping stone to the reintroduction of smp_mb__after_unlock_lock() used
> by RCU.
> 
> Documentation/memory-barriers.txt is updated to describe more clearly
> the ACQUIRE and RELEASE ordering in this area and to show some examples
> of the new barrier in action.

So the obvious question is: do we have a use-case?
