Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57522 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932214AbcDNPpA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Apr 2016 11:45:00 -0400
Date: Thu, 14 Apr 2016 17:44:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] asm-generic/futex: Properly re-enable preemption in
 futex_atomic_cmpxchg_inatomic()
Message-ID: <20160414154456.GD2975@worktop.cust.blueprintrf.com>
References: <1460640963-690-1-git-send-email-romain.perier@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460640963-690-1-git-send-email-romain.perier@free-electrons.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Romain Perier <romain.perier@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Message-ID: <20160414154456.feEzt7n6vcduka72senwyVkVgtdiCKXwL0XF8cU0nBg@z>

On Thu, Apr 14, 2016 at 03:36:03PM +0200, Romain Perier wrote:
> Fixes: d9b9ff8c1889 ("sched/preempt, futex: Disable preemption in UP futex_atomic_cmpxchg_inatomic() explicitly")
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
> ---
>  include/asm-generic/futex.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
> index e56272c..bf2d34c 100644
> --- a/include/asm-generic/futex.h
> +++ b/include/asm-generic/futex.h
> @@ -108,11 +108,15 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  	u32 val;
>  
>  	preempt_disable();
> -	if (unlikely(get_user(val, uaddr) != 0))
> +	if (unlikely(get_user(val, uaddr) != 0)) {
> +		preempt_enable();
>  		return -EFAULT;
> +	}
>  
> -	if (val == oldval && unlikely(put_user(newval, uaddr) != 0))
> +	if (val == oldval && unlikely(put_user(newval, uaddr) != 0)) {
> +		preempt_enable();
>  		return -EFAULT;
> +	}
>  
>  	*uval = val;
>  	preempt_enable();

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
