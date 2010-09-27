From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [patch 18/19] genirq: Provide Kconfig
Date: Mon, 27 Sep 2010 09:43:07 -0700
Message-ID: <20100927094307.6582c188.randy.dunlap@oracle.com>
References: <20100927121651.904100669@linutronix.de>
	<20100927121843.217333624@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:64444 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759707Ab0I0Qo0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Sep 2010 12:44:26 -0400
In-Reply-To: <20100927121843.217333624@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>

On Mon, 27 Sep 2010 12:45:59 -0000 Thomas Gleixner wrote:

> The generic irq Kconfig options are copied around all archs. Provide a
> generic Kconfig file which can be included.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/irq/Kconfig |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> Index: linux-2.6-tip/kernel/irq/Kconfig
> ===================================================================
> --- /dev/null
> +++ linux-2.6-tip/kernel/irq/Kconfig
> @@ -0,0 +1,49 @@
> +#
> +# Interrupt subsystem related configuration options
> +#
> +
> +menu "Interrupt handling subsystem"
> +
> +config GENERIC_HARDIRQS
> +	def_bool y
> +
> +config GENERIC_HARDIRQS_NO__DO_IRQ
> +       def_bool y
> +
> +# Options selectable by the architecture code
> +config HAVE_SPARSE_IRQ
> +       def_bool n
> +
> +config GENERIC_IRQ_PROBE
> +	def_bool n
> +
> +config GENERIC_PENDING_IRQ
> +	def_bool n
> +
> +if SPARSE_IRQ && NUMA
> +config NUMA_IRQ_DESC
> +	def_bool n
> +endif
> +
> +config AUTO_IRQ_AFFINITY
> +       def_bool n
> +
> +config IRQ_PER_CPU
> +       def_bool n
> +
> +config HARDIRQS_SW_RESEND
> +       def_bool n
> +
> +config SPARSE_IRQ
> +	bool "Support sparse irq numbering"
> +	depends on HAVE_SPARSE_IRQ
> +	---help---
> +	  This enables support for sparse irqs. This is useful for distro
> +	  kernels that want to define a high CONFIG_NR_CPUS value but still
> +	  want to have low kernel memory footprint on smaller machines.
> +

I see that this is just moved from another location, but it would be good if
the "irq"s above could be like the one below (IRQ or IRQs).

> +	  ( Sparse IRQs can also be beneficial on NUMA boxes, as they spread
> +	    out the irq_desc[] array in a more NUMA-friendly way. )
> +
> +	  If you don't know what to do here, say N.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
