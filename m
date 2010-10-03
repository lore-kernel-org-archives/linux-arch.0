From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [patch 20/47] x86: Remove useless reinitialization of irq descriptors
Date: Sun, 03 Oct 2010 08:21:30 -0700
Message-ID: <m14od3l2th.fsf@fess.ebiederm.org>
References: <20100930221351.682772535@linutronix.de>
	<20100930221740.449419120@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:41421 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab0JCPVt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 3 Oct 2010 11:21:49 -0400
In-Reply-To: <20100930221740.449419120@linutronix.de> (Thomas Gleixner's
	message of "Thu, 30 Sep 2010 23:16:14 -0000")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>

Thomas Gleixner <tglx@linutronix.de> writes:

> The descriptors are already initialized in exaclty this way.

They aren't only status is initialized exactly that way.

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/irqinit.c |   17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
>
> Index: linux-2.6-tip/arch/x86/kernel/irqinit.c
> ===================================================================
> --- linux-2.6-tip.orig/arch/x86/kernel/irqinit.c
> +++ linux-2.6-tip/arch/x86/kernel/irqinit.c
> @@ -100,6 +100,8 @@ int vector_used_by_percpu_irq(unsigned i
>  
>  void __init init_ISA_irqs(void)
>  {
> +	struct irq_chip *chip = legacy_pic->chip;
> +	const char *name = chip->name;
>  	int i;
>  
>  #if defined(CONFIG_X86_64) || defined(CONFIG_X86_LOCAL_APIC)
> @@ -107,19 +109,8 @@ void __init init_ISA_irqs(void)
>  #endif
>  	legacy_pic->init(0);
>  
> -	/*
> -	 * 16 old-style INTA-cycle interrupts:
> -	 */

Why delete the comment here?

> -	for (i = 0; i < legacy_pic->nr_legacy_irqs; i++) {
> -		struct irq_desc *desc = irq_to_desc(i);
> -
> -		desc->status = IRQ_DISABLED;
> -		desc->action = NULL;
> -		desc->depth = 1;
> -
> -		set_irq_chip_and_handler_name(i, &i8259A_chip,
> -					      handle_level_irq, "XT");
> -	}
> +	for (i = 0; i < legacy_pic->nr_legacy_irqs; i++)
> +		set_irq_chip_and_handler_name(i, chip, handle_level_irq, name);
>  }
>  
>  void __init init_IRQ(void)

Eric
