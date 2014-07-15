Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:55474 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757853AbaGOJ17 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jul 2014 05:27:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 12/29] nios2: Interrupt handling
Date: Tue, 15 Jul 2014 11:27:55 +0200
Message-ID: <5170097.X9RFbxSEnp@wuerfel>
In-Reply-To: <1405413956-2772-13-git-send-email-lftan@altera.com>
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <1405413956-2772-13-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20140715092755._uI4H0U4KBpDfbKTJ2Da-16KBZW7GgF4rG1zdUIOQsY@z>

On Tuesday 15 July 2014 16:45:39 Ley Foon Tan wrote:
> +#ifndef _ASM_NIOS2_IRQ_H
> +#define _ASM_NIOS2_IRQ_H
> +
> +#define NIOS2_CPU_NR_IRQS	32
> +/* Reserve 32 additional interrupts for GPIO IRQs */
> +#define NR_IRQS			(NIOS2_CPU_NR_IRQS + 32)

Is this intentional? I would expect that you use SPARSE_IRQ
instead and not define NR_IRQS.

> +#ifndef NO_IRQ
> +#define NO_IRQ			(-1)
> +#endif

New architectures should no longer define NO_IRQ. Please fix all users
you encounter instead.

> diff --git a/arch/nios2/kernel/irq.c b/arch/nios2/kernel/irq.c
> new file mode 100644
> index 0000000..8770d50
> --- /dev/null
> +++ b/arch/nios2/kernel/irq.c
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/of.h>

Maybe move this into drivers/irqchip/? Probably doesn't matter either way,
your choice.

	Arnd
