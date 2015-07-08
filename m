From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 2/4] locking/qrwlock: Reduce reader/writer to reader lock
 transfer latency
Date: Wed, 8 Jul 2015 18:19:49 +0100
Message-ID: <20150708171949.GE6348@arm.com>
References: <20150706182353.GC1607@arm.com>
 <559ADBCD.6020803@hp.com>
 <20150707091711.GA23879@arm.com>
 <20150707111731.GQ3644@twins.programming.kicks-ass.net>
 <20150707114918.GG23879@arm.com>
 <559BE27E.6060901@hp.com>
 <20150707172718.GJ23879@arm.com>
 <20150707181002.GK23879@arm.com>
 <559C44CE.7070701@hp.com>
 <20150708095248.GZ3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42594 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759028AbbGHRTy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Jul 2015 13:19:54 -0400
Content-Disposition: inline
In-Reply-To: <20150708095248.GZ3644@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <waiman.long@hp.com>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On Wed, Jul 08, 2015 at 10:52:48AM +0100, Peter Zijlstra wrote:
> On Tue, Jul 07, 2015 at 05:29:50PM -0400, Waiman Long wrote:
> > I prefer the current setting as you won't know if the writer has the
> > lock or not when you take a snapshot of the value of the lock. You
> > need the whole time sequence in this case to figure it out and so will
> > be more prone to error.
> 
> I still need to wake up, but I suspect we need to change
> queue_read_{try,}lock() to use cmpxchg/inc_not_zero like things, which
> is fine for ARM, but not so much for x86.
> 
> So I think I agree with Waiman, but am willing to be shown differently.

That's fine; I just wanted to make sure I wasn't going round the twist!

Will
