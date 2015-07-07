From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 2/4] locking/qrwlock: Reduce reader/writer to reader lock
 transfer latency
Date: Tue, 7 Jul 2015 12:49:18 +0100
Message-ID: <20150707114918.GG23879@arm.com>
References: <1436197386-58635-1-git-send-email-Waiman.Long@hp.com>
 <1436197386-58635-3-git-send-email-Waiman.Long@hp.com>
 <20150706182353.GC1607@arm.com>
 <559ADBCD.6020803@hp.com>
 <20150707091711.GA23879@arm.com>
 <20150707111731.GQ3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35239 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756521AbbGGLtW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 7 Jul 2015 07:49:22 -0400
Content-Disposition: inline
In-Reply-To: <20150707111731.GQ3644@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <waiman.long@hp.com>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On Tue, Jul 07, 2015 at 12:17:31PM +0100, Peter Zijlstra wrote:
> On Tue, Jul 07, 2015 at 10:17:11AM +0100, Will Deacon wrote:
> > > > Thinking about it, can we kill _QW_WAITING altogether and set (cmpxchg
> > > > from 0) wmode to _QW_LOCKED in the write_lock slowpath, polling (acquire)
> > > > rmode until it hits zero?
> > > 
> > > No, this is how we make the lock fair so that an incoming streams of 
> > > later readers won't block a writer from getting the lock.
> > 
> > But won't those readers effectively see that the lock is held for write
> > (because we set wmode to _QW_LOCKED before the existing reader had drained)
> > and therefore fall down the slow-path and get held up on the spinlock?
> 
> Yes, that's the entire point. Once there's a writer pending, new readers
> should queue too.

Agreed. My point was that we can achieve the same result without
a separate _QW_WAITING flag afaict.

Will
