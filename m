From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V6 04/33] csky: Exception handling and mm-fault
Date: Sun, 30 Sep 2018 01:07:46 +0800
Message-ID: <20180929170746.GF27796@guoren-Inspiron-7460>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <a4571e227938b58d8ba5f35e2f8e17b625478607.1538058840.git.ren_guo@c-sky.com>
 <20180928161503.GC19827@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180928161503.GC19827@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 28, 2018 at 09:15:03AM -0700, Christoph Hellwig wrote:
> > +#ifndef CONFIG_CPU_HAS_TLBI
> > +	/*
> > +	 * We fault-in kernel-space virtual memory on-demand. The
> > +	 * 'reference' page table is init_mm.pgd.
> > +	 *
> > +	 * NOTE! We MUST NOT take any locks for this case. We may
> > +	 * be in an interrupt or a critical region, and should
> > +	 * only copy the information from the master page table,
> > +	 * nothing more.
> > +	 */
> > +	if (unlikely(address >= VMALLOC_START && address <= VMALLOC_END))
> > +	{
> 
> This doesn't fir the kernel style.  Please run checkpatch.pl over
> your code and fix at least all warnings that don't seem clearly bogus.
	if (unlikely(address >= VMALLOC_START) &&
	    unlikely(address <= VMALLOC_END)) {

Ok, use checkpatch.pl.

Best Regards
 Guo Ren
