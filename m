From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/2] qspinlock: Introducing a 4-byte queue spinlock
 implementation
Date: Mon, 03 Feb 2014 14:21:40 +0530
Message-ID: <52EF589C.9030109@linux.vnet.ibm.com>
References: <1390933151-1797-1-git-send-email-Waiman.Long@hp.com> <1390933151-1797-2-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:50702 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbaBCIpe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Feb 2014 03:45:34 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <raghavendra.kt@linux.vnet.ibm.com>;
	Mon, 3 Feb 2014 18:45:32 +1000
In-Reply-To: <1390933151-1797-2-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Daniel J Blueman <daniel@numascale.com>, Alexander Fyodorov <halcy@yandex.ru>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>

On 01/28/2014 11:49 PM, Waiman Long wrote:
> +#endif /* __ASM_GENERIC_QSPINLOCK_H */
> diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
> index d2b32ac..f185584 100644
> --- a/kernel/Kconfig.locks
> +++ b/kernel/Kconfig.locks
> @@ -223,3 +223,10 @@ endif
>   config MUTEX_SPIN_ON_OWNER
>   	def_bool y
>   	depends on SMP && !DEBUG_MUTEXES
> +
> +config ARCH_USE_QUEUE_SPINLOCK
> +	bool
> +
> +config QUEUE_SPINLOCK
> +	def_bool y if ARCH_USE_QUEUE_SPINLOCK
> +	depends on SMP && !PARAVIRT_SPINLOCKS

This should have been !CONFIG_PARAVIRT instead of !PARAVIRT_SPINLOCKS ?
