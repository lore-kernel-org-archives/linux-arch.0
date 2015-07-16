From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 5/7] locking/qrwlock: make use of
 acquire/release/relaxed atomics
Date: Thu, 16 Jul 2015 18:59:03 +0200
Message-ID: <20150716165903.GA19282@twins.programming.kicks-ass.net>
References: <1437060758-10381-1-git-send-email-will.deacon@arm.com>
 <1437060758-10381-6-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:44102 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbbGPQ7K (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2015 12:59:10 -0400
Content-Disposition: inline
In-Reply-To: <1437060758-10381-6-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, Waiman.Long@hp.com, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com

On Thu, Jul 16, 2015 at 04:32:36PM +0100, Will Deacon wrote:
> @@ -130,8 +130,7 @@ static inline void queued_read_unlock(struct qrwlock *lock)
>  	/*
>  	 * Atomically decrement the reader count
>  	 */
> -	smp_mb__before_atomic();
> -	atomic_sub(_QR_BIAS, &lock->cnts);
> +	(void)atomic_sub_return_release(_QR_BIAS, &lock->cnts);
>  }
>  
>  /**

This one will actually cause different code on x86; I think its still
fine though. LOCK XADD should not be (much) slower than LOCK SUB.

> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
> index a71bb3541880..879c8fab7bea 100644
> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c
> @@ -36,7 +36,7 @@ rspin_until_writer_unlock(struct qrwlock *lock, u32 cnts)
>  {
>  	while ((cnts & _QW_WMASK) == _QW_LOCKED) {
>  		cpu_relax_lowlatency();
> -		cnts = smp_load_acquire((u32 *)&lock->cnts);
> +		cnts = atomic_read_acquire(&lock->cnts);
>  	}
>  }

It might make sense to add comments to the users of this function that
actually rely on the _acquire semantics, I had to double check that :-)


But otherwise that all looks good.
