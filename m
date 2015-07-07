From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH 2/9] locking/qrwlock: avoid redundant atomic_add_return
 on read_lock_slowpath
Date: Tue, 07 Jul 2015 13:51:54 -0400
Message-ID: <559C11BA.1070309@hp.com>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com> <1436289865-2331-3-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g1t5425.austin.hp.com ([15.216.225.55]:34195 "EHLO
	g1t5425.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932198AbbGGRv6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2015 13:51:58 -0400
In-Reply-To: <1436289865-2331-3-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, peterz@infradead.org, mingo@redhat.com

On 07/07/2015 01:24 PM, Will Deacon wrote:
> When a slow-path reader gets to the front of the wait queue outside of
> interrupt context, it waits for any writers to drain, increments the
> reader count and again waits for any additional writers that may have
> snuck in between the initial check and the increment.
>
> Given that this second check is performed with acquire semantics, there
> is no need to perform the increment using atomic_add_return, which acts
> as a full barrier.
>
> This patch changes the slow-path code to use smp_load_acquire and
> atomic_add instead of atomic_add_return. Since the check only involves
> the writer count, we can perform the acquire after the add.
>
> Signed-off-by: Will Deacon<will.deacon@arm.com>
> ---
>   kernel/locking/qrwlock.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
> index 96b77d1e0545..4e29bef688ac 100644
> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c
> @@ -98,7 +98,8 @@ void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
>   	while (atomic_read(&lock->cnts)&  _QW_WMASK)
>   		cpu_relax_lowlatency();
>
> -	cnts = atomic_add_return(_QR_BIAS,&lock->cnts) - _QR_BIAS;
> +	atomic_add(_QR_BIAS,&lock->cnts);
> +	cnts = smp_load_acquire((u32 *)&lock->cnts);
>   	rspin_until_writer_unlock(lock, cnts);
>
>   	/*

Atomic add in x86 is actually a full barrier too. The performance 
difference between "lock add" and "lock xadd" should be minor. The 
additional load, however, could potentially cause an additional 
cacheline load on a contended lock. So do you see actual performance 
benefit of this change in ARM?

Cheers,
Longman
