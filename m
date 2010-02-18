From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 4/5] xtime_lock: Convert to raw_seqlock
Date: Thu, 18 Feb 2010 12:02:14 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1002181200050.2811@localhost.localdomain>
References: <20100217183740.486724334@linutronix.de>  <20100217184155.882793970@linutronix.de> <1266490168.26719.179.camel@laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:58337 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757Ab0BRLCi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Feb 2010 06:02:38 -0500
In-Reply-To: <1266490168.26719.179.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, John Stultz <johnstul@us.ibm.com>

On Thu, 18 Feb 2010, Peter Zijlstra wrote:

> On Wed, 2010-02-17 at 18:47 +0000, Thomas Gleixner wrote:
> > 
> > xtime_lock needs a raw_spinlock in preempt-rt. Convert it to
> > raw_seqlock and fix up all users.
> > 
> s/raw_spinlock/raw_seqlock/ ?
> 
> Maybe add an explanation on _why_ -rt needs this for the uninformed
> amongst us.
> 
> -rt switches to sleeping spinlocks, but since the vdso is basically
> userspace it cannot schedule, hence we need to keep using actual
> spinlocks (this is also the reason the vdso things must not call into
> lockdep)

No, the read_seq side is not taking the lock. It's just the write side
which is taking the spinlock to serialize against other writers.

xtime_lock is write locked in the timer interrupt context and therefor
cannot take a sleeping spinlock.

Thanks,

	tglx
