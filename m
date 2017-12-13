From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v3 09/33] nds32: Cache and TLB routines
Date: Wed, 13 Dec 2017 13:45:02 +0800
Message-ID: <CAEbi=3dtcnUNbd4SoueUnoYvRWot9fA1n62t0b4PWx1UYs2jZA@mail.gmail.com>
References: <cover.1512723245.git.green.hu@gmail.com> <9d0e976c3e60bf6834dffb6ef798ad2a03e1c9ac.1512723245.git.green.hu@gmail.com>
 <20171213021619.GA6254@gary-OptiPlex-3050>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:39771 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbdLMFpo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Dec 2017 00:45:44 -0500
In-Reply-To: <20171213021619.GA6254@gary-OptiPlex-3050>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>

2017-12-13 10:16 GMT+08:00 Guo Ren <ren_guo@c-sky.com>:
> On Fri, Dec 08, 2017 at 05:11:52PM +0800, Greentime Hu wrote:
>> From: Greentime Hu <greentime@andestech.com>
>  [...]
>> diff --git a/arch/nds32/mm/cacheflush.c b/arch/nds32/mm/cacheflush.c
>  [...]
>> +#ifndef CONFIG_CPU_CACHE_ALIASING
>> +void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
>> +                   pte_t * pte)
>  [...]
>> +     if (vma->vm_mm == current->active_mm) {
>> +
>> +             __nds32__mtsr_dsb(addr, NDS32_SR_TLB_VPN);
>> +             __nds32__tlbop_rwr(*pte);
>> +             __nds32__isb();
> If there is an interruption between "mtsr_dsb" and "tlbop_rwr" and a
> update_mmu_cache() is invoked again, then an error page mapping is
> set up in your tlb-buffer when tlbop_rwr is excuted from interrupt.
> Because it's another addr in NDS32_SR_TLB_VPN.
>
> It seems that tlb-hardrefill can help build tlb-buffer mapping, why you
> update it in this software way?
>

Hi, Guo Ren:

I think it should be fine if an interruption between mtsr_dsb and
tlbop_rwr because this is a optimization by sw.
The page mapping has been created and it is just not in TLB yet.
What we did is to insert this mapping to TLB by SW thus it can prevent
TLB miss one time.
It will be fine even if TLB miss. HW will walk through page table and
insert this mapping to TLB anyway.

Based on Documentation/cachetlb.txt
5) ``void update_mmu_cache(struct vm_area_struct *vma,
   unsigned long address, pte_t *ptep)``

        At the end of every page fault, this routine is invoked to
        tell the architecture specific code that a translation
        now exists at virtual address "address" for address space
        "vma->vm_mm", in the software page tables.

        A port may use this information in any way it so chooses.
        For example, it could use this event to pre-load TLB
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        translations for software managed TLB configurations.
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
