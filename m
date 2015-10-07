From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Date: Wed, 7 Oct 2015 13:19:15 +0200
Message-ID: <20151007111915.GF17308@twins.programming.kicks-ass.net>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:51368 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbbJGLT1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2015 07:19:27 -0400
Content-Disposition: inline
In-Reply-To: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Wed, Oct 07, 2015 at 11:59:28AM +0100, Will Deacon wrote:
> As much as we'd like to live in a world where RELEASE -> ACQUIRE is
> always cheaply ordered and can be used to construct UNLOCK -> LOCK
> definitions with similar guarantees, the grim reality is that this isn't
> even possible on x86 (thanks to Paul for bringing us crashing down to
> Earth).
> 
> This patch handles the issue by introducing a new barrier macro,
> smp_mb__release_acquire, that can be placed between a RELEASE and a
> subsequent ACQUIRE operation in order to upgrade them to a full memory
> barrier. At the moment, it doesn't have any users, so its existence
> serves mainly as a documentation aid.

Does we want to go revert 12d560f4ea87 ("rcu,locking: Privatize
smp_mb__after_unlock_lock()") for that same reason?

> Documentation/memory-barriers.txt is updated to describe more clearly
> the ACQUIRE and RELEASE ordering in this area and to show an example of
> the new barrier in action.

The only nit I have is that if we revert the above it might be make
sense to more clearly call out the distinction between the two.
