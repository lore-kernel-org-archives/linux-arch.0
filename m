Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:55942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbeI1Wfr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Sep 2018 18:35:47 -0400
Date: Fri, 28 Sep 2018 09:11:10 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V6 01/33] csky: Build infrastructure
Message-ID: <20180928161110.GA19827@infradead.org>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <dbd9228bb886c672ba75ad9e479f870957d6bcfa.1538058840.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd9228bb886c672ba75ad9e479f870957d6bcfa.1538058840.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com
Message-ID: <20180928161110.3qBn7F3cEg5NjwadbaElb5lwosUdb4PZqwjPdO9Wghc@z>

> --- /dev/null
> +++ b/arch/csky/kernel/Makefile
> @@ -0,0 +1,8 @@
> +extra-y := head.o vmlinux.lds
> +
> +obj-y += entry.o atomic.o signal.o traps.o irq.o time.o vdso.o \
> +	 power.o syscall.o platform.o syscall_table.o setup.o \
> +	 process.o cpu-probe.o ptrace.o dumpstack.o
> +
> +obj-$(CONFIG_MODULES)			+= module.o

You can't just wire up the build infrastructure before th code.

Please add the objects to the Makefiles when they are actually added.
