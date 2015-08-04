From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v4 6/8] locking/qrwlock: make use of
 acquire/release/relaxed atomics
Date: Tue, 4 Aug 2015 12:20:25 +0100
Message-ID: <20150804112025.GA10067@arm.com>
References: <1438621351-15912-1-git-send-email-will.deacon@arm.com>
 <1438621351-15912-7-git-send-email-will.deacon@arm.com>
 <55BFD3D6.8000905@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57198 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933034AbbHDLU3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 4 Aug 2015 07:20:29 -0400
Content-Disposition: inline
In-Reply-To: <55BFD3D6.8000905@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "mingo@kernel.org" <mingo@kernel.org>

Hi Waiman,

Thanks for having a look.

On Mon, Aug 03, 2015 at 09:49:26PM +0100, Waiman Long wrote:
> On 08/03/2015 01:02 PM, Will Deacon wrote:
> > The qrwlock implementation is slightly heavy in its use of memory
> > barriers, mainly through the use of cmpxchg and _return atomics, which
> > imply full barrier semantics.
> >
> > This patch modifies the qrwlock code to use the more relaxed atomic
> > routines so that we can reduce the unnecessary barrier overhead on
> > weakly-ordered architectures.
> >
> > Signed-off-by: Will Deacon<will.deacon@arm.com>

[...]

> > @@ -74,8 +74,9 @@ void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
> >   		 * Readers in interrupt context will get the lock immediately
> >   		 * if the writer is just waiting (not holding the lock yet).
> >   		 * The rspin_until_writer_unlock() function returns immediately
> > -		 * in this case. Otherwise, they will spin until the lock
> > -		 * is available without waiting in the queue.
> > +		 * in this case. Otherwise, they will spin (with ACQUIRE
> > +		 * semantics) until the lock is available without waiting in
> > +		 * the queue.
> >   		 */
> >   		rspin_until_writer_unlock(lock, cnts);
> >   		return;
> > @@ -97,7 +98,13 @@ void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
> >   	while (atomic_read(&lock->cnts)&  _QW_WMASK)
> >   		cpu_relax_lowlatency();
> >
> > -	cnts = atomic_add_return(_QR_BIAS,&lock->cnts) - _QR_BIAS;
> > +	cnts = atomic_add_return_relaxed(_QR_BIAS,&lock->cnts) - _QR_BIAS;
> > +
> > +	/*
> > +	 * The ACQUIRE semantics of the spinning code ensure that
> > +	 * accesses can't leak upwards out of our subsequent critical
> > +	 * section.
> > +	 */
> 
> Maybe you should be more specific to mention the arch_spin_lock() call 
> above. Other than that,

Actually, I think you've uncovered a bug! Initially, I based this on top
of my qrwlock series that made the acquire unconditional in
rspin_until_writer_unlock, but you (reasonably) objected to the extra
overhead on the interrupt path, so now we only get an acquire if the
initial test of (cnts & _QW_WMASK) == _QW_LOCKED) succeeds.

So actually, the atomic_add_return needs to be made an
atomic_add_return_acquire. I'll make that change and adjust the comment
accordingly.

Fixup below.

Cheers,

Will

--->8

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index fb4ef2d636f2..1724eac4c84b 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -98,13 +98,12 @@ void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
 	while (atomic_read(&lock->cnts) & _QW_WMASK)
 		cpu_relax_lowlatency();
 
-	cnts = atomic_add_return_relaxed(_QR_BIAS, &lock->cnts) - _QR_BIAS;
-
 	/*
-	 * The ACQUIRE semantics of the spinning code ensure that
-	 * accesses can't leak upwards out of our subsequent critical
-	 * section.
+	 * The ACQUIRE semantics of the following spinning code ensure
+	 * that accesses can't leak upwards out of our subsequent critical
+	 * section in the case that the lock is currently held for write.
 	 */
+	cnts = atomic_add_return_acquire(_QR_BIAS, &lock->cnts) - _QR_BIAS;
 	rspin_until_writer_unlock(lock, cnts);
 
 	/*
