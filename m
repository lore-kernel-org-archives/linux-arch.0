Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:57828 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbeI1Wjl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Sep 2018 18:39:41 -0400
Date: Fri, 28 Sep 2018 09:15:03 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V6 04/33] csky: Exception handling and mm-fault
Message-ID: <20180928161503.GC19827@infradead.org>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <a4571e227938b58d8ba5f35e2f8e17b625478607.1538058840.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4571e227938b58d8ba5f35e2f8e17b625478607.1538058840.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com
Message-ID: <20180928161503.bxGW-aLDWg-rAdbXmvxGBIq4OYGL7tuyo8vjcd-XOZU@z>

> +#ifndef CONFIG_CPU_HAS_TLBI
> +	/*
> +	 * We fault-in kernel-space virtual memory on-demand. The
> +	 * 'reference' page table is init_mm.pgd.
> +	 *
> +	 * NOTE! We MUST NOT take any locks for this case. We may
> +	 * be in an interrupt or a critical region, and should
> +	 * only copy the information from the master page table,
> +	 * nothing more.
> +	 */
> +	if (unlikely(address >= VMALLOC_START && address <= VMALLOC_END))
> +	{

This doesn't fir the kernel style.  Please run checkpatch.pl over
your code and fix at least all warnings that don't seem clearly bogus.
