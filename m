Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49937 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbcHKPhR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Aug 2016 11:37:17 -0400
Date: Thu, 11 Aug 2016 17:36:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
Message-ID: <20160811153645.GX30192@twins.programming.kicks-ass.net>
References: <1470672218-16059-1-git-send-email-cmetcalf@mellanox.com>
 <1470672218-16059-5-git-send-email-cmetcalf@mellanox.com>
 <20160809124325.GG13300@pathway.suse.cz>
 <feaaca8f-cc09-5847-ea3f-d27052704d9b@mellanox.com>
 <20160811152538.GH13300@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160811152538.GH13300@pathway.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20160811153645.aUuOTbP86ty4W0qwFQhI8FuB2OWJ9n0RAZhfhv-DJ1U@z>

On Thu, Aug 11, 2016 at 05:25:38PM +0200, Petr Mladek wrote:
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index b77f5edb03b0..e31d50acd491 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -44,7 +44,7 @@ static inline void native_irq_enable(void)
>  	asm volatile("sti": : :"memory");
>  }
>  
> -static inline void native_safe_halt(void)
> +static inline __attribute__((__section__(".cpuidle.text"))) void native_safe_halt(void)
>  {
>  	asm volatile("sti; hlt": : :"memory");
>  }

An alternative is to use __always_inline I suppose.
