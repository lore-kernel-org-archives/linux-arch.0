From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v3 09/33] nds32: Cache and TLB routines
Date: Wed, 13 Dec 2017 17:03:33 +0800
Message-ID: <CAEbi=3fvdWMExreVsSu3TJqXUr5Zpt4k_q=cXXB3miJCvY-+1g@mail.gmail.com>
References: <cover.1512723245.git.green.hu@gmail.com> <9d0e976c3e60bf6834dffb6ef798ad2a03e1c9ac.1512723245.git.green.hu@gmail.com>
 <20171213021619.GA6254@gary-OptiPlex-3050> <CAEbi=3dtcnUNbd4SoueUnoYvRWot9fA1n62t0b4PWx1UYs2jZA@mail.gmail.com>
 <20171213081949.GA18840@gary-OptiPlex-3050> <CAEbi=3eKH5JESwtadq4LKF3ZvmBi1QwUWpCTb0btierBST_cRQ@mail.gmail.com>
 <20171213085334.GA21382@gary-OptiPlex-3050>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171213085334.GA21382@gary-OptiPlex-3050>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>
List-Id: linux-arch.vger.kernel.org

2017-12-13 16:53 GMT+08:00 Guo Ren <ren_guo@c-sky.com>:
> On Wed, Dec 13, 2017 at 04:30:41PM +0800, Greentime Hu wrote:
>> 2017-12-13 16:19 GMT+08:00 Guo Ren <ren_guo@c-sky.com>:
>> > On Wed, Dec 13, 2017 at 01:45:02PM +0800, Greentime Hu wrote:
>> >
>> >> I think it should be fine if an interruption between mtsr_dsb and
>> >> tlbop_rwr because this is a optimization by sw.
>> >
>> > Fine? When there is an unexpected vaddr in SR_TLB_VPN, tlbop_rwr(*pte) will
>> > break that vaddr's pfn in the CPU tlb-buffer entry. When linux access the
>> > vaddr, it will get wrong data unless the entry has been replaced out.
>>
>> Hi, Guo Ren:
>>
>> Thanks. I get your point.
>> It is needed to be protected.
>> I will fix it in the next version patch.
>>
>> if (vma->vm_mm == current->active_mm) {
>>         local_irq_save(flags);
>>         __nds32__mtsr_dsb(addr, NDS32_SR_TLB_VPN);
>>         __nds32__tlbop_rwr(*pte);
>>         __nds32__isb();
>>         local_irq_restore(flags);
>> }
>
> If hardware tlbop_rwr could invalid NDS32_SR_TLB_VPN, then you needn't
> protect.
> I mean:
> mtsr addr1 NDS32_SR_TLB_VPN
> mtsr addr2 NDS32_SR_TLB_VPN
> tlbop_rwr(*pte) // OK, and it will hit a hardware invalid bit internal.
> tlbop_rwr(*pte) // SR_TLB_VPN invalided, then it will not cause problem.
>
> :) How my idea?

Hi, Guo Ren:

The reason I think it might have problem is that

mtsr addr1 NDS32_SR_TLB_VPN
    interrupt coming
        mtsr addr2 NDS32_SR_TLB_VPN <- TLB_VPN has been set to addr2
        tlbop_rwr(*pte);
    interrupt finish
tlbop_rwr(*pte); <- it will use the wrong TLB_VPN

I think all these TLB operations should be protected because tlbop
will operate with TLB_VPN.
Thanks :)
