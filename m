From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/4] locking/qrwlock: Use direct MCS lock/unlock in
 slowpath
Date: Wed, 8 Jul 2015 00:13:06 +0200
Message-ID: <20150707221306.GN19282@twins.programming.kicks-ass.net>
References: <1436197386-58635-1-git-send-email-Waiman.Long@hp.com>
 <1436197386-58635-5-git-send-email-Waiman.Long@hp.com>
 <20150707112449.GR3644@twins.programming.kicks-ass.net>
 <559C4BDF.3020605@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:38079 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932886AbbGGWNR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2015 18:13:17 -0400
Content-Disposition: inline
In-Reply-To: <559C4BDF.3020605@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On Tue, Jul 07, 2015 at 05:59:59PM -0400, Waiman Long wrote:
> On 07/07/2015 07:24 AM, Peter Zijlstra wrote:
> >On Mon, Jul 06, 2015 at 11:43:06AM -0400, Waiman Long wrote:
> >>Lock waiting in the qrwlock uses the spinlock (qspinlock for x86)
> >>as the waiting queue. This is slower than using MCS lock directly
> >>because of the extra level of indirection causing more atomics to
> >>be used as well as 2 waiting threads spinning on the lock cacheline
> >>instead of only one.
> >This needs a better explanation. Didn't we find with the qspinlock thing
> >that the pending spinner improved performance on light loads?
> >
> >Taking it out seems counter intuitive, we could very much like these two
> >the be the same.
> 
> Yes, for lightly loaded case, using raw_spin_lock should have an advantage.
> It is a different matter when the lock is highly contended. In this case,
> having the indirection in qspinlock will make it slower.

But we should not optimize the lock for the complete saturation case, if
you encounter that, change the locking. The light contention case is
much more important.
