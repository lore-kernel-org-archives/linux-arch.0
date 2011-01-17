From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
        smp_send_reschedule()
Date: Mon, 17 Jan 2011 14:58:53 +0100
Message-ID: <20110117135852.GI9874@axis.com>
References: <1295262433.30950.53.camel@laptop> <20110117112637.GA18599@n2100.arm.linux.org.uk> <1295263884.30950.54.camel@laptop> <1295264509.30950.59.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1295264509.30950.59.camel@laptop>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Mike Frysinger <vapier@gentoo.org>, Mikael Starvik <starvik@axis.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 17, 2011 at 12:41:49PM +0100, Peter Zijlstra wrote:
> Index: linux-2.6/arch/cris/arch-v32/kernel/smp.c
> ===================================================================
> --- linux-2.6.orig/arch/cris/arch-v32/kernel/smp.c
> +++ linux-2.6/arch/cris/arch-v32/kernel/smp.c
> @@ -340,15 +340,18 @@ irqreturn_t crisv32_ipi_interrupt(int ir
> 
>         ipi = REG_RD(intr_vect, irq_regs[smp_processor_id()], rw_ipi);
> 
> +       if (ipi.vector & IPI_SCHEDULE) {
> +               scheduler_ipi();
> +       }
>         if (ipi.vector & IPI_CALL) {
> -                func(info);
> +               func(info);
>         }
>         if (ipi.vector & IPI_FLUSH_TLB) {
> -                    if (flush_mm == FLUSH_ALL)
> -                        __flush_tlb_all();
> -                    else if (flush_vma == FLUSH_ALL)
> +               if (flush_mm == FLUSH_ALL)
> +                       __flush_tlb_all();
> +               else if (flush_vma == FLUSH_ALL)
>                         __flush_tlb_mm(flush_mm);
> -                    else
> +               else
>                         __flush_tlb_page(flush_vma, flush_addr);
>         }
> 

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
