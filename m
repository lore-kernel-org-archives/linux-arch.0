From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/4] doc: Rename LOCK/UNLOCK to ACQUIRE/RELEASE
Date: Tue, 17 Dec 2013 11:13:23 +0100
Message-ID: <20131217101323.GH21999@twins.programming.kicks-ass.net>
References: <20131213145657.265414969@infradead.org>
 <20131213150640.726393081@infradead.org>
 <20131216201157.GI4200@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:37912 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007Ab3LQKN4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Dec 2013 05:13:56 -0500
Content-Disposition: inline
In-Reply-To: <20131216201157.GI4200@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kerne.org, geert@linux-m68k.org, torvalds@linux-foundation.org, VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com, mathieu.desnoyers@polymtl.ca, michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tony.luck@intel.com

On Mon, Dec 16, 2013 at 12:11:57PM -0800, Paul E. McKenney wrote:
> Should we rename smp_mb__before_spinlock() to be smp_mb__before_acquire()?

> > +ACQUIRE can be followed by an smp_mb__after_unlock_lock() invocation.  This
> 
> And should we rename this to be smp_mb__after_release_acquire()?
> 
> (I kind of hope not, as it is a bit more typing.)

you could name it: smp_mb__after_rel_acq(), which is shorter again :-)

But on both cases, I would propose to wait until we have a use-case
where we need these barriers on !spinlocks.
