Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:34039 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFSOk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2018 14:14:40 -0400
Date: Thu, 6 Sep 2018 15:39:01 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V3 10/26] csky: IRQ handling
In-Reply-To: <a881fc9d1009f7b3ca1cfa50dd7f1ead7844d521.1536138304.git.ren_guo@c-sky.com>
Message-ID: <alpine.DEB.2.21.1809061535040.1570@nanos.tec.linutronix.de>
References: <cover.1536138304.git.ren_guo@c-sky.com> <a881fc9d1009f7b3ca1cfa50dd7f1ead7844d521.1536138304.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Message-ID: <20180906133901.fs1cnnSn2tZujZUne90NxoflXkHcllWNoFRJsyGstH8@z>

On Wed, 5 Sep 2018, Guo Ren wrote:

> +static void (*handle_arch_irq)(struct pt_regs *regs) = NULL;
> +
> +void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
> +{
> +	if (handle_arch_irq)
> +		return;
> +
> +	handle_arch_irq = handle_irq;
> +}

Please don't introduce yet another variant of that. Please use
CONFIG_GENERIC_IRQ_MULTI_HANDLER which provides that in the generic code.

Btw, some of your patches have tab vs. space inconsistencies, e.g.

+        siginfo_t info;
+       int fault;
+       unsigned long address = mmu_meh & PAGE_MASK;

Thanks,

	tglx
