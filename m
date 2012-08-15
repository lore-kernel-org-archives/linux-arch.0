From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 28/31] arm64: Generic timers support
Date: Wed, 15 Aug 2012 15:52:40 +0000
Message-ID: <201208151552.40484.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-29-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58192 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab2HOPwt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 11:52:49 -0400
In-Reply-To: <1344966752-16102-29-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>

On Tuesday 14 August 2012, Catalin Marinas wrote:
> +static void arch_timer_reg_write(int reg, u32 val)
> +{
> +       switch (reg) {
> +       case ARCH_TIMER_REG_CTRL:
> +               asm volatile("msr cntp_ctl_el0,  %0" : : "r" (val));
> +               break;
> +       case ARCH_TIMER_REG_TVAL:
> +               asm volatile("msr cntp_tval_el0, %0" : : "r" (val));
> +               break;
> +       default:
> +               BUG();
> +       }
> +
> +       isb();
> +}
> +
> +static u32 arch_timer_reg_read(int reg)
> +{
> +       u32 val;
> +
> +       switch (reg) {
> +       case ARCH_TIMER_REG_CTRL:
> +               asm volatile("mrs %0,  cntp_ctl_el0" : "=r" (val));
> +               break;
> +       case ARCH_TIMER_REG_FREQ:
> +               asm volatile("mrs %0,   cntfrq_el0" : "=r" (val));
> +               break;
> +       case ARCH_TIMER_REG_TVAL:
> +               asm volatile("mrs %0, cntp_tval_el0" : "=r" (val));
> +               break;
> +       default:
> +               BUG();
> +       }
> +
> +       return val;
> +}

Are the inline assemblies the only things in this driver that are
specific to AArch64?
Are you planning to use the same file for 32 bit ARM as well, e.g.
when running a 32 bit guest kernel on a 64 bit host?

	Arnd
