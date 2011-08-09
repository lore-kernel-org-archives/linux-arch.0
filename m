From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/24] C6X: cache control
Date: Tue, 9 Aug 2011 18:53:54 +0200
Message-ID: <201108091853.54655.arnd@arndb.de>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <1312839879-13592-16-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62537 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab1HIQx5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2011 12:53:57 -0400
In-Reply-To: <1312839879-13592-16-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 08 August 2011, Mark Salter wrote:
> +/*
> + *  Copyright (C) 2011 Texas Instruments Incorporated
> + *  Author: Mark Salter <msalter@redhat.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + */
> +#include <linux/io.h>
> +
> +#include <asm/cache.h>
> +#include <asm/machdep.h>
> +#include <asm/soc.h>
> +
> +#define IMCR_BASE	  0x01840000

Please don't hardcode MMIO regions like this. You should have the base address in
the device tree and use of_iomap() like you do in some other cases.
If you need this really early, you might need to 

> +static void cache_block_operation_wait(unsigned int wc_reg)
> +{
> +	/* Wait for completion */
> +	while (imcr_get(wc_reg))
> +		;
> +}

When you have blocking loops like this one, better use cpu_relax() in the
loop body. I realize that that is currently a nop, but it's better style
to use it anyway.

> +/*
> + * Generic function to perform a block cache operation as
> + * invalidate or writeback/invalidate
> + */
> +static void cache_block_operation(unsigned int *start,
> +				  unsigned int *end,
> +				  unsigned int bar_reg,
> +				  unsigned int wc_reg)
> +{
> +	unsigned long flags;
> +	unsigned int wcnt =
> +		(L2_CACHE_ALIGN_CNT((unsigned int) end)
> +		 - L2_CACHE_ALIGN_LOW((unsigned int) start)) >> 2;
> +	unsigned int wc = 0;
> +
> +	for (; wcnt; wcnt -= wc, start += wc) {
> +loop:
> +		local_irq_save(flags);
> +
> +		/*
> +		 * If another cache operation is occuring
> +		 */
> +		if (unlikely(imcr_get(wc_reg))) {
> +			local_irq_restore(flags);
> +
> +			/* Wait for previous operation completion */
> +			cache_block_operation_wait(wc_reg);
> +
> +			/* Try again */
> +			goto loop;
> +		}
> +
> +		imcr_set(bar_reg, L2_CACHE_ALIGN_LOW((unsigned int) start));
> +
> +		if (wcnt > 0xffff)
> +			wc = 0xffff;
> +		else
> +			wc = wcnt;
> +
> +		/* Set word count value in the WC register */
> +		imcr_set(wc_reg, wc & 0xffff);
> +
> +		local_irq_restore(flags);
> +
> +		/* Wait for completion */
> +		cache_block_operation_wait(wc_reg);
> +	}
> +}

Doesn't this need a proper spinlock instead of a local_irq_save?
You should try to write code with SMP in mind, even if the current usage
is UP only. The resulting object code is the same on UP.

> + *  L1P global-invalidate all
> + */
> +void L1P_cache_global_invalidate(void)
> +{
> +	unsigned int set = 1;
> +	imcr_set(IMCR_L1PINV, set);
> +	while (imcr_get(IMCR_L1PINV) & 1)
> +		;
> +}
> +
> +/*
> + *  L1D global-invalidate all
> + *
> + * Warning: this operation causes all updated data in L1D to
> + * be discarded rather than written back to the lower levels of
> + * memory
> + */
> +void L1D_cache_global_invalidate(void)
> +{
> +	unsigned int set = 1;
> +	imcr_set(IMCR_L1DINV, set);
> +	while (imcr_get(IMCR_L1DINV) & 1)
> +		;
> +}
> +
> +void L1D_cache_global_writeback(void)
> +{
> +	unsigned int set = 1;
> +	imcr_set(IMCR_L1DWB, set);
> +	while (imcr_get(IMCR_L1DWB) & 1)
> +		;
> +}
> +
> +void L1D_cache_global_writeback_invalidate(void)
> +{
> +	unsigned int set = 1;
> +	imcr_set(IMCR_L1DWBINV, set);
> +	while (imcr_get(IMCR_L1DWBINV) & 1)
> +		;
> +}

cpu_relax() again.

	Arnd
