From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 11/31] arm64: IRQ handling
Date: Fri, 7 Sep 2012 19:37:18 +0000
Message-ID: <201209071937.19156.arnd@arndb.de>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com> <1347035226-18649-12-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:57787 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab2IGThZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 15:37:25 -0400
In-Reply-To: <1347035226-18649-12-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Friday 07 September 2012, Catalin Marinas wrote:

> +#define __inc_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)++
> +#define __get_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)

Isn't this something that the IRQ core code already keeps track of?

> +#endif /* __ASM_HARDIRQ_H */
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> new file mode 100644
> index 0000000..a4e1cad
> --- /dev/null
> +++ b/arch/arm64/include/asm/irq.h
> @@ -0,0 +1,8 @@
> +#ifndef __ASM_IRQ_H
> +#define __ASM_IRQ_H
> +
> +#include <asm-generic/irq.h>
> +
> +extern void (*handle_arch_irq)(struct pt_regs *);
> +
> +#endif

Is this one still needed?

	Arnd
