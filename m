From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH v2 28/31] arm64: Generic timers support
Date: Tue, 21 Aug 2012 15:20:18 -0400
Message-ID: <5033DF72.70609@codeaurora.org>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-29-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:10223 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab2HUTU0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Aug 2012 15:20:26 -0400
In-Reply-To: <1344966752-16102-29-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On 08/14/2012 01:52 PM, Catalin Marinas wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> This patch adds support for the ARM generic timers with A64 instructions
> for accessing the timer registers. It uses the physical counter as the
> clock source and the virtual counter as sched_clock.
> 
> The timer frequency can be specified via DT or read from the CNTFRQ_EL0
> register. The physical counter is also accessible from user space
> allowing fast gettimeofday() implementation.

[...]

> +++ b/drivers/clocksource/arm_generic.c

[...]

> +static void arch_timer_reg_write(int reg, u32 val)
> +{
> +	switch (reg) {
> +	case ARCH_TIMER_REG_CTRL:
> +		asm volatile("msr cntp_ctl_el0,  %0" : : "r" (val));
> +		break;
> +	case ARCH_TIMER_REG_TVAL:
> +		asm volatile("msr cntp_tval_el0, %0" : : "r" (val));
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	isb();
> +}

Doesn't architecture-specific assembly need to go in the arch directory rather
than the drivers directory?

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
