Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 29 May 2005 09:55:57 -0700
From: Richard Henderson <rth@twiddle.net>
Subject: Re: Lots of possible arch breakage in cpu_idle!!
Message-ID: <20050529165557.GA19922@twiddle.net>
References: <4299523F.90502@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4299523F.90502@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Sun, May 29, 2005 at 03:25:19PM +1000, Nick Piggin wrote:
> +++ linux-2.6/arch/alpha/kernel/process.c
...
> +	set_thread_flag(TIF_POLLING_NRFLAG);

Ok.

> +			cpu_relax();
> +		preempt_enable_no_resched();
>  		schedule();
> +		preempt_disable();

Not ok.

> +++ linux-2.6/arch/s390/kernel/smp.c	2005-05-29 14:21:42.000000000 +1000
> @@ -528,6 +528,8 @@ extern void pfault_fini(void);
>  
>  int __devinit start_secondary(void *cpuvoid)
>  {
> +	preempt_disable();

Not ok.

Do not add the substring "preempt" to the alpha subtree.


r~
