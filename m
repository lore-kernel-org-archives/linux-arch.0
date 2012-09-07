From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 07/31] arm64: Process management
Date: Fri, 7 Sep 2012 19:20:16 +0000
Message-ID: <201209071920.17355.arnd@arndb.de>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com> <1347035226-18649-8-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56425 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab2IGTUZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 15:20:25 -0400
In-Reply-To: <1347035226-18649-8-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Friday 07 September 2012, Catalin Marinas wrote:
> The patch adds support for thread creation and context switching. The
> context switching CPU specific code is introduced with the CPU support
> patch (part of the arch/arm64/mm/proc.S file). AArch64 supports
> ASID-tagged TLBs and the ASID can be either 8 or 16-bit wide (detectable
> via the ID_AA64AFR0_EL1 register).
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>


But please fix a few small issues in process.c:

> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> new file mode 100644
> index 0000000..6dfd96f
> --- /dev/null
> +++ b/arch/arm64/kernel/process.c

> +
> +extern void setup_mm_for_reboot(void);

No extern declarations in .c files, put it in a header file instead.


> +
> +/*
> + * Function pointers to optional machine specific functions
> + */
> +void (*pm_power_off)(void);
> +EXPORT_SYMBOL(pm_power_off);
> +
> +void (*pm_restart)(const char *cmd);
> +EXPORT_SYMBOL_GPL(pm_restart);
> +
>
> +void (*pm_idle)(void) = default_idle;
> +EXPORT_SYMBOL(pm_idle);

I'd make them all EXPORT_SYMBOL_GPL. External modules have no business overriding them.

> +	/*
> +	 * Whoops - the architecture was unable to reboot.
> +	 * Tell the user!
> +	 */
> +	mdelay(1000);
> +	printk("Reboot failed -- System halted\n");
> +	while (1);

This delay seems pointless.


	Arnd
