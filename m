From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
Date: Mon, 21 Mar 2016 16:42:01 +0100
Message-ID: <20160321154201.GA6344@twins.programming.kicks-ass.net>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:57752 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044AbcCUPmD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2016 11:42:03 -0400
Content-Disposition: inline
In-Reply-To: <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, Mar 16, 2016 at 01:02:13PM -0400, Chris Metcalf wrote:
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 9f7c21c22477..d569ae7fde37 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -298,7 +298,7 @@ void arch_cpu_idle(void)
>  /*
>   * We use this if we don't have any better idle routine..
>   */
> -void default_idle(void)
> +void __cpuidle default_idle(void)
>  {
>  	trace_cpu_idle_rcuidle(1, smp_processor_id());
>  	safe_halt();
> @@ -413,7 +413,7 @@ static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
>   * with interrupts enabled and no flags, which is backwards compatible with the
>   * original MWAIT implementation.
>   */
> -static void mwait_idle(void)
> +static __cpuidle void mwait_idle(void)
>  {
>  	if (!current_set_polling_and_test()) {
>  		trace_cpu_idle_rcuidle(1, smp_processor_id());

The most common idle function for x86 is: mwait_idle_with_hints(),
trouble is, its an inline, so I'm not sure adding __cpuidle to it does
anything.

I've yet to find the magic objdump incantation to check. Or rather
objdump -h doesn't appear to list .cpuidle.text at all :/

I'm probably doing something silly...
