From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch 09/34] arm64: Use generic idle loop
Date: Mon, 25 Mar 2013 18:06:56 +0000
Message-ID: <20130325180656.GG3894@arm.com>
References: <20130321214930.752934102@linutronix.de>
 <20130321215233.887563095@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:59293 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932576Ab3CYSOT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Mar 2013 14:14:19 -0400
Content-Disposition: inline
In-Reply-To: <20130321215233.887563095@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Magnus Damm <magnus.damm@gmail.com>

On Thu, Mar 21, 2013 at 09:53:03PM +0000, Thomas Gleixner wrote:
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
> Index: linux-2.6/arch/arm64/Kconfig
> ===================================================================
> --- linux-2.6.orig/arch/arm64/Kconfig
> +++ linux-2.6/arch/arm64/Kconfig
> @@ -14,6 +14,7 @@ config ARM64
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_IRQ_SHOW
>  	select GENERIC_SMP_IDLE_THREAD
> +	select GENERIC_IDLE_LOOP
>  	select GENERIC_TIME_VSYSCALL
>  	select HARDIRQS_SW_RESEND
>  	select HAVE_ARCH_TRACEHOOK

Minor thing, I try to keep these entries alphabetically sorted (it won't
last long, I'm sure). Otherwise,

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
