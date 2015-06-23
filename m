From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v5 3/3] locking/qrwlock: Don't contend with readers when
 setting _QW_WAITING
Date: Tue, 23 Jun 2015 09:37:56 +0100
Message-ID: <20150623083756.GD31504@arm.com>
References: <1434729002-57724-1-git-send-email-Waiman.Long@hp.com>
 <1434729002-57724-4-git-send-email-Waiman.Long@hp.com>
 <20150622162123.GI1583@arm.com>
 <5588CB2C.108@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50440 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443AbbFWIiA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Jun 2015 04:38:00 -0400
Content-Disposition: inline
In-Reply-To: <5588CB2C.108@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On Tue, Jun 23, 2015 at 03:57:48AM +0100, Waiman Long wrote:
> On 06/22/2015 12:21 PM, Will Deacon wrote:
> > On Fri, Jun 19, 2015 at 04:50:02PM +0100, Waiman Long wrote:
> >> The current cmpxchg() loop in setting the _QW_WAITING flag for writers
> >> in queue_write_lock_slowpath() will contend with incoming readers
> >> causing possibly extra cmpxchg() operations that are wasteful. This
> >> patch changes the code to do a byte cmpxchg() to eliminate contention
> >> with new readers.
> > [...]
> >
> >> diff --git a/arch/x86/include/asm/qrwlock.h b/arch/x86/include/asm/qrwlock.h
> >> index a8810bf..5678b0a 100644
> >> --- a/arch/x86/include/asm/qrwlock.h
> >> +++ b/arch/x86/include/asm/qrwlock.h
> >> @@ -7,8 +7,7 @@
> >>   #define queued_write_unlock queued_write_unlock
> >>   static inline void queued_write_unlock(struct qrwlock *lock)
> >>   {
> >> -        barrier();
> >> -        ACCESS_ONCE(*(u8 *)&lock->cnts) = 0;
> >> +	smp_store_release(&lock->wmode, 0);
> >>   }
> >>   #endif
> > I reckon you could actually use this in the asm-generic header and remove
> > the x86 arch version altogether. Most architectures support single-copy
> > atomic byte access and those that don't (alpha?) can just not use qrwlock
> > (or override write_unlock with atomic_sub).
> >
> > I already have a patch making this change, so I'm happy either way.
> 
> Yes, I am aware of that. If you have a patch to make that change, I am 
> fine with that too.

Tell you what; I'll rebase my patches on top of yours and post them after
the merge window.

Will
