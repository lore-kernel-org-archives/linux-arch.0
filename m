From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH v3 09/33] nds32: Cache and TLB routines
Date: Wed, 13 Dec 2017 10:16:20 +0800
Message-ID: <20171213021619.GA6254@gary-OptiPlex-3050>
References: <cover.1512723245.git.green.hu@gmail.com>
 <9d0e976c3e60bf6834dffb6ef798ad2a03e1c9ac.1512723245.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9d0e976c3e60bf6834dffb6ef798ad2a03e1c9ac.1512723245.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 08, 2017 at 05:11:52PM +0800, Greentime Hu wrote:
> From: Greentime Hu <greentime@andestech.com>
 [...]
> diff --git a/arch/nds32/mm/cacheflush.c b/arch/nds32/mm/cacheflush.c
 [...]
> +#ifndef CONFIG_CPU_CACHE_ALIASING
> +void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
> +		      pte_t * pte)
 [...]
> +	if (vma->vm_mm == current->active_mm) {
> +
> +		__nds32__mtsr_dsb(addr, NDS32_SR_TLB_VPN);
> +		__nds32__tlbop_rwr(*pte);
> +		__nds32__isb();
If there is an interruption between "mtsr_dsb" and "tlbop_rwr" and a
update_mmu_cache() is invoked again, then an error page mapping is
set up in your tlb-buffer when tlbop_rwr is excuted from interrupt.
Because it's another addr in NDS32_SR_TLB_VPN.

It seems that tlb-hardrefill can help build tlb-buffer mapping, why you
update it in this software way?

 Guo Ren
