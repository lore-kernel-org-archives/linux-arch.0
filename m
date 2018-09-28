From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V6 04/33] csky: Exception handling and mm-fault
Date: Fri, 28 Sep 2018 09:15:03 -0700
Message-ID: <20180928161503.GC19827@infradead.org>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <a4571e227938b58d8ba5f35e2f8e17b625478607.1538058840.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a4571e227938b58d8ba5f35e2f8e17b625478607.1538058840.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

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
