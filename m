From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 08/11] ia64, rwsem: provide __down_write_killable
Date: Thu, 7 Apr 2016 20:28:16 +0300
Message-ID: <570698B0.8090707@cogentembedded.com>
References: <1460041951-22347-1-git-send-email-mhocko@kernel.org>
 <1460041951-22347-9-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34920 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757161AbcDGR2V (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Apr 2016 13:28:21 -0400
Received: by mail-lb0-f177.google.com with SMTP id os9so10123995lbb.2
        for <linux-arch@vger.kernel.org>; Thu, 07 Apr 2016 10:28:20 -0700 (PDT)
In-Reply-To: <1460041951-22347-9-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Michal Hocko <mhocko@suse.com>

Hello.

On 04/07/2016 06:12 PM, Michal Hocko wrote:

> From: Michal Hocko <mhocko@suse.com>
>
> Introduce ___down_write for the fast path and reuse it for __down_write
> resp. __down_write_killable each using the respective generic slow path
> (rwsem_down_write_failed resp. rwsem_down_write_failed_killable).
>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>   arch/ia64/include/asm/rwsem.h | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/arch/ia64/include/asm/rwsem.h b/arch/ia64/include/asm/rwsem.h
> index 3027e7516d85..5e78cb40d9df 100644
> --- a/arch/ia64/include/asm/rwsem.h
> +++ b/arch/ia64/include/asm/rwsem.h
> @@ -49,8 +49,8 @@ __down_read (struct rw_semaphore *sem)
>   /*
>    * lock for writing
>    */
> -static inline void
> -__down_write (struct rw_semaphore *sem)
> +static inline long
> +___down_write (struct rw_semaphore *sem)
>   {
>   	long old, new;
>
> @@ -59,10 +59,26 @@ __down_write (struct rw_semaphore *sem)
>   		new = old + RWSEM_ACTIVE_WRITE_BIAS;
>   	} while (cmpxchg_acq(&sem->count, old, new) != old);
>
> -	if (old != 0)
> +	return old;
> +}
> +
> +static inline void
> +__down_write (struct rw_semaphore *sem)
> +{
> +	if (___down_write(sem))
>   		rwsem_down_write_failed(sem);
>   }
>
> +static inline int
> +__down_write_killable (struct rw_semaphore *sem)

    Looks like you haven't run this patch thru scripts/checkpatch.pl. Hint: 
space before ( isn't allowed.

[...]

MNBR, Sergei
