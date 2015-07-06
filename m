From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 2/4] locking/qrwlock: Reduce reader/writer to reader lock
 transfer latency
Date: Mon, 6 Jul 2015 19:23:53 +0100
Message-ID: <20150706182353.GC1607@arm.com>
References: <1436197386-58635-1-git-send-email-Waiman.Long@hp.com>
 <1436197386-58635-3-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60762 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbbGFSX6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 6 Jul 2015 14:23:58 -0400
Content-Disposition: inline
In-Reply-To: <1436197386-58635-3-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

Hi Waiman,

On Mon, Jul 06, 2015 at 04:43:04PM +0100, Waiman Long wrote:
> Currently, a reader will check first to make sure that the writer mode
> byte is cleared before incrementing the reader count. That waiting is
> not really necessary. It increases the latency in the reader/writer
> to reader transition and reduces readers performance.
> 
> This patch eliminates that waiting. It also has the side effect
> of reducing the chance of writer lock stealing and improving the
> fairness of the lock. Using a locking microbenchmark, a 10-threads 5M
> locking loop of mostly readers (RW ratio = 10,000:1) has the following
> performance numbers in a Haswell-EX box:
> 
>         Kernel          Locking Rate (Kops/s)
>         ------          ---------------------
>         4.1.1               15,063,081
>         Patched 4.1.1       17,241,552
> 
> Signed-off-by: Waiman Long <Waiman.Long@hp.com>

I've just finished rebasing my arm64 qrwlock stuff, but I think it will
conflict with these patches. Do you mind if I post them for review anyway,
so we can at least co-ordinate our efforts?

> ---
>  kernel/locking/qrwlock.c |   12 ++++--------
>  1 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
> index 81bae99..ecd2d19 100644
> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c
> @@ -88,15 +88,11 @@ void queue_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
>  	arch_spin_lock(&lock->lock);
>  
>  	/*
> -	 * At the head of the wait queue now, wait until the writer state
> -	 * goes to 0 and then try to increment the reader count and get
> -	 * the lock. It is possible that an incoming writer may steal the
> -	 * lock in the interim, so it is necessary to check the writer byte
> -	 * to make sure that the write lock isn't taken.
> +	 * At the head of the wait queue now, increment the reader count
> +	 * and wait until the writer, if it has the lock, has gone away.
> +	 * At ths stage, it is not possible for a writer to remain in the
> +	 * waiting state (_QW_WAITING). So there won't be any deadlock.
>  	 */
> -	while (atomic_read(&lock->cnts) & _QW_WMASK)
> -		cpu_relax_lowlatency();

Thinking about it, can we kill _QW_WAITING altogether and set (cmpxchg
from 0) wmode to _QW_LOCKED in the write_lock slowpath, polling (acquire)
rmode until it hits zero?

Will
