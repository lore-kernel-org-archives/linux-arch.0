From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 18:17:52 +0200
Message-ID: <20171011161752.x6sd6ue4hmzfnffe@hirez.programming.kicks-ass.net>
References: <20171011155948.GE3521@linux.vnet.ibm.com>
 <20171011122217.GD11106@arm.com>
 <20171010155042.GD3521@linux.vnet.ibm.com>
 <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010001951.GA6476@linux.vnet.ibm.com>
 <8079.1507628146@warthog.procyon.org.uk>
 <26455.1507724399@warthog.procyon.org.uk>
 <6309.1507735045@warthog.procyon.org.uk>
 <7484.1507738025@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:51070 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbdJKQSC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Oct 2017 12:18:02 -0400
Content-Disposition: inline
In-Reply-To: <7484.1507738025@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: paulmck@linux.vnet.ibm.com, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>, dvyukov@google.com

On Wed, Oct 11, 2017 at 05:07:05PM +0100, David Howells wrote:
> Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > It does not.  In most cases, the barriered version would be
> > smp_store_release().
> 
> Ummm... Is that good enough?  Is:
> 
> 	WRITE_ONCE(x, 1);
> 	WRITE_ONCE(x, 2);
> 
> equivalent to:
> 
> 	smp_store_release(x, 1);
> 	smp_store_release(x, 2);
> 
> if CONFIG_SMP=n?

Almost; it ends up being:

	barrier();
	WRITE_ONCE(x, 1);
	barrier();
	WRITE_ONCE(x, 2);

> (Consider what happens if an interrupt messes with x).
> 
> If it is good enough, should we be using smp_load_acquire() rather than
> READ_ONCE()?

No, smp_load_acquire() is strictly stronger (and far more expensive on
!Alpha).

Dependent loads do not require barriers (except Alpha, and we want to
kill that special case).
