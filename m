From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/4] locking/qrwlock: Reduce reader/writer to reader lock
 transfer latency
Date: Wed, 8 Jul 2015 11:52:48 +0200
Message-ID: <20150708095248.GZ3644@twins.programming.kicks-ass.net>
References: <1436197386-58635-3-git-send-email-Waiman.Long@hp.com>
 <20150706182353.GC1607@arm.com>
 <559ADBCD.6020803@hp.com>
 <20150707091711.GA23879@arm.com>
 <20150707111731.GQ3644@twins.programming.kicks-ass.net>
 <20150707114918.GG23879@arm.com>
 <559BE27E.6060901@hp.com>
 <20150707172718.GJ23879@arm.com>
 <20150707181002.GK23879@arm.com>
 <559C44CE.7070701@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <559C44CE.7070701@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <waiman.long@hp.com>
Cc: Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 07, 2015 at 05:29:50PM -0400, Waiman Long wrote:
> On 07/07/2015 02:10 PM, Will Deacon wrote:

> >diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
> >index deb9e8b0eb9e..be8dc5c6fdbd 100644
> >--- a/include/asm-generic/qrwlock.h
> >+++ b/include/asm-generic/qrwlock.h
> >@@ -27,7 +27,6 @@
> >  /*
> >   * Writer states&  reader shift and bias
> >   */
> >-#define        _QW_WAITING     1               /* A writer is waiting     */
> >  #define        _QW_LOCKED      0xff            /* A writer holds the lock */
> >  #define        _QW_WMASK       0xff            /* Writer mask             */
> >  #define        _QR_SHIFT       8               /* Reader count shift      */
> >diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
> >index 9f644933f6d4..4006aa1fbd0b 100644
> >--- a/kernel/locking/qrwlock.c
> >+++ b/kernel/locking/qrwlock.c
> >@@ -127,28 +127,23 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
> >         }
> >
> >         /*
> >-        * Set the waiting flag to notify readers that a writer is pending,
> >-        * or wait for a previous writer to go away.
> >+        * Wait for a previous writer to go away, then set the locked
> >+        * flag to notify future readers/writers that we are pending.
> >          */
> >         for (;;) {
> >                 struct __qrwlock *l = (struct __qrwlock *)lock;
> >
> >                 if (!READ_ONCE(l->wmode)&&
> >-                  (cmpxchg(&l->wmode, 0, _QW_WAITING) == 0))
> >+                  (cmpxchg(&l->wmode, 0, _QW_LOCKED) == 0))
> >                         break;
> >
> >                 cpu_relax_lowlatency();
> >         }
> >
> >-       /* When no more readers, set the locked flag */
> >-       for (;;) {
> >-               if ((atomic_read(&lock->cnts) == _QW_WAITING)&&
> >-                   (atomic_cmpxchg(&lock->cnts, _QW_WAITING,
> >-                                   _QW_LOCKED) == _QW_WAITING))
> >-                       break;
> >-
> >+       /* Wait for the readers to drain */
> >+       while (smp_load_acquire((u32 *)&lock->cnts)&  ~_QW_WMASK)
> >                 cpu_relax_lowlatency();
> >-       }
> >+
> >  unlock:
> >         arch_spin_unlock(&lock->lock);
> >  }
> 
> That changes the handshaking protocol. In this case, the readers will have
> to decrement its reader count to enable the writer to continue.

It already needs to, no?

> The interrupt context reader code has to be changed.

Agreed.

> This gives preference to writer and reader will be in a disadvantage.

I don't see that, everybody is still ordered by the wait queue / lock.

> I prefer the current setting as you won't know if the writer has the
> lock or not when you take a snapshot of the value of the lock. You
> need the whole time sequence in this case to figure it out and so will
> be more prone to error.

I still need to wake up, but I suspect we need to change
queue_read_{try,}lock() to use cmpxchg/inc_not_zero like things, which
is fine for ARM, but not so much for x86.

So I think I agree with Waiman, but am willing to be shown differently.
