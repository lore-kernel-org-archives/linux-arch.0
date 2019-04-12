Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45091 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfDLROx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Apr 2019 13:14:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so5483799pgk.12
        for <linux-arch@vger.kernel.org>; Fri, 12 Apr 2019 10:14:52 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: 1808d65b55 ("asm-generic/tlb: Remove arch_tlb*_mmu()"):  BUG: KASAN: stack-out-of-bounds in __change_page_attr_set_clr
From: Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <E33FDED8-8B95-431D-9AC7-71D45AB49011@vmware.com>
Date: Fri, 12 Apr 2019 10:14:49 -0700
Content-Transfer-Encoding: quoted-printable
Message-ID: <43ACD9F9-6373-4325-A97A-B8E8588E24BD@amacapital.net>
References: <5cae03c4.iIPk2cWlfmzP0Zgy%lkp@intel.com> <20190411193906.GA12232@hirez.programming.kicks-ass.net> <20190411195424.GL14281@hirez.programming.kicks-ass.net> <20190411211348.GA8451@worktop.programming.kicks-ass.net> <20190412105633.GM14281@hirez.programming.kicks-ass.net> <20190412111756.GO14281@hirez.programming.kicks-ass.net> <F18AF0D5-D8B4-4F4B-8469-F9DEC49683C7@vmware.com> <E33FDED8-8B95-431D-9AC7-71D45AB49011@vmware.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>, kernel test robot <lkp@intel.com>, LKP <lkp@01.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dave Hansen <dave.hansen@intel.com>
Message-ID: <20190412171449.9JOm7XbGrLY9otMd6pPpzMuSjSIy-t3pfLHTP8n6gKk@z>



On Apr 12, 2019, at 10:05 AM, Nadav Amit <namit@vmware.com> wrote:

>> On Apr 12, 2019, at 8:11 AM, Nadav Amit <namit@vmware.com> wrote:
>>=20
>>> On Apr 12, 2019, at 4:17 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>>>=20
>>> On Fri, Apr 12, 2019 at 12:56:33PM +0200, Peter Zijlstra wrote:
>>>>> On Thu, Apr 11, 2019 at 11:13:48PM +0200, Peter Zijlstra wrote:
>>>>>> On Thu, Apr 11, 2019 at 09:54:24PM +0200, Peter Zijlstra wrote:
>>>>>>> On Thu, Apr 11, 2019 at 09:39:06PM +0200, Peter Zijlstra wrote:
>>>>>>> I think this bisect is bad. If you look at your own logs this patch
>>>>>>> merely changes the failure, but doesn't make it go away.
>>>>>>>=20
>>>>>>> Before this patch (in fact, before tip/core/mm entirely) the errror
>>>>>>> reads like the below, which suggests there is memory corruption
>>>>>>> somewhere, and the fingered patch just makes it trigger differently.=

>>>>>>>=20
>>>>>>> It would be very good to find the source of this corruption, but I'm=

>>>>>>> fairly certain it is not here.
>>>>>>=20
>>>>>> I went back to v4.20 to try and find a time when the below error did n=
ot
>>>>>> occur, but even that reliably triggers the warning.
>>>>>=20
>>>>> So I also tested v4.19 and found that that was good, which made me
>>>>> bisect v4.19..v4.20
>>>>>=20
>>>>> # bad: [8fe28cb58bcb235034b64cbbb7550a8a43fd88be] Linux 4.20
>>>>> # good: [84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d] Linux 4.19
>>>>> git bisect start 'v4.20' 'v4.19'
>>>>> # bad: [ec9c166434595382be3babf266febf876327774d] Merge tag 'mips_fixe=
s_4.20_1' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
>>>>> git bisect bad ec9c166434595382be3babf266febf876327774d
>>>>> # bad: [50b825d7e87f4cff7070df6eb26390152bb29537] Merge git://git.kern=
el.org/pub/scm/linux/kernel/git/davem/net-next
>>>>> git bisect bad 50b825d7e87f4cff7070df6eb26390152bb29537
>>>>> # good: [99e9acd85ccbdc8f5785f9e961d4956e96bd6aa5] Merge tag 'mlx5-upd=
ates-2018-10-17' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linu=
x
>>>>> git bisect good 99e9acd85ccbdc8f5785f9e961d4956e96bd6aa5
>>>>> # good: [c403993a41d50db1e7d9bc2d43c3c8498162312f] Merge tag 'for-linu=
s-4.20' of https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fgithub.com%2Fcminyard%2Flinux-ipmi&amp;data=3D02%7C01%7Cnamit%40vmware.com=
%7Ca1c3ea5d4bc34cfc785508d6bf388ff3%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7=
C0%7C636906647013777573&amp;sdata=3D3VSR3VdE5rxOitAdkqFNPpAnAtLgDmYLzJtoUrs5=
v9Y%3D&amp;reserved=3D0
>>>>> git bisect good c403993a41d50db1e7d9bc2d43c3c8498162312f
>>>>> # good: [c05f3642f4304dd081876e77a68555b6aba4483f] Merge branch 'perf-=
core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>> git bisect good c05f3642f4304dd081876e77a68555b6aba4483f
>>>>> # bad: [44786880df196a4200c178945c4d41675faf9fb7] Merge branch 'parisc=
-4.20-1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linu=
x
>>>>> git bisect bad 44786880df196a4200c178945c4d41675faf9fb7
>>>>> # bad: [99792e0cea1ed733cdc8d0758677981e0cbebfed] Merge branch 'x86-mm=
-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>> git bisect bad 99792e0cea1ed733cdc8d0758677981e0cbebfed
>>>>> # good: [fec98069fb72fb656304a3e52265e0c2fc9adf87] Merge branch 'x86-c=
pu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>> git bisect good fec98069fb72fb656304a3e52265e0c2fc9adf87
>>>>> # bad: [a31acd3ee8f7dbc0370bdf4a4bfef7a8c13c7542] x86/mm: Page size aw=
are flush_tlb_mm_range()
>>>>> git bisect bad a31acd3ee8f7dbc0370bdf4a4bfef7a8c13c7542
>>>>> # good: [a7295fd53c39ce781a9792c9dd2c8747bf274160] x86/mm/cpa: Use flu=
sh_tlb_kernel_range()
>>>>> git bisect good a7295fd53c39ce781a9792c9dd2c8747bf274160
>>>>> # good: [9cf38d5559e813cccdba8b44c82cc46ba48d0896] kexec: Allocate dec=
rypted control pages for kdump if SME is enabled
>>>>> git bisect good 9cf38d5559e813cccdba8b44c82cc46ba48d0896
>>>>> # good: [5b12904065798fee8b153a506ac7b72d5ebbe26c] x86/mm/doc: Clean u=
p the x86-64 virtual memory layout descriptions
>>>>> git bisect good 5b12904065798fee8b153a506ac7b72d5ebbe26c
>>>>> # good: [cf089611f4c446285046fcd426d90c18f37d2905] proc/vmcore: Fix i3=
86 build error of missing copy_oldmem_page_encrypted()
>>>>> git bisect good cf089611f4c446285046fcd426d90c18f37d2905
>>>>> # good: [a5b966ae42a70b194b03eaa5eaea70d8b3790c40] Merge branch 'tlb/a=
sm-generic' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux int=
o x86/mm
>>>>> git bisect good a5b966ae42a70b194b03eaa5eaea70d8b3790c40
>>>>> # first bad commit: [a31acd3ee8f7dbc0370bdf4a4bfef7a8c13c7542] x86/mm:=
 Page size aware flush_tlb_mm_range()
>>>>>=20
>>>>> And 'funnily' the bad patch is one of mine too :/
>>>>>=20
>>>>> I'll go have a look at that tomorrow, because currrently I'm way past
>>>>> tired.
>>>>=20
>>>> OK, so the below patchlet makes it all good. It turns out that the
>>>> provided config has:
>>>>=20
>>>> CONFIG_X86_L1_CACHE_SHIFT=3D7
>>>>=20
>>>> which then, for some obscure raisin, results in flush_tlb_mm_range()
>>>> compiling to use 320 bytes of stack:
>>>>=20
>>>> sub    $0x140,%rsp
>>>>=20
>>>> Where a 'defconfig' build results in:
>>>>=20
>>>> sub    $0x58,%rsp
>>>>=20
>>>> The thing that pushes it over the edge in the above fingered patch is
>>>> the addition of a field to struct flush_tlb_info, which grows if from 3=
2
>>>> to 36 bytes.
>>>>=20
>>>> So my proposal is to basically revert that, unless we can come up with
>>>> something that GCC can't screw up.
>>>=20
>>> To clarify, 'that' is Nadav's patch:
>>>=20
>>> 515ab7c41306 ("x86/mm: Align TLB invalidation info")
>>>=20
>>> which turns out to be the real problem.
>>=20
>> Sorry for that. I still think it should be aligned, especially with all t=
he
>> effort the Intel puts around to avoid bus-locking on unaligned atomic
>> operations.
>>=20
>> So the right solution seems to me as putting this data structure off stac=
k.
>> It would prevent flush_tlb_mm_range() from being reentrant, so we can kee=
p a
>> few entries for this matter and atomically increase the entry number ever=
y
>> time we enter flush_tlb_mm_range().
>>=20
>> But my question is - should flush_tlb_mm_range() be reentrant, or can we
>> assume no TLB shootdowns are initiated in interrupt handlers and #MC
>> handlers?
>=20
> Peter, what do you say about this one? I assume there are no nested TLB
> flushes, but the code can easily be adapted (assuming there is a limit on
> the nesting level).

You need IRQs on to flush, right?  So as long as preemption is off, it won=E2=
=80=99t nest.

But is there really any measurable performance benefit to aligning it like t=
his?  There shouldn=E2=80=99t actually be any atomically =E2=80=94 it=E2=80=99=
s just a little data structure telling everyone what to do.

>=20
> -- >8 --
>=20
> Subject: [PATCH] x86: Move flush_tlb_info off the stack
> ---
> arch/x86/mm/tlb.c | 49 +++++++++++++++++++++++++++++++++--------------
> 1 file changed, 35 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index bc4bc7b2f075..15fe90d4e3e1 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -14,6 +14,7 @@
> #include <asm/cache.h>
> #include <asm/apic.h>
> #include <asm/uv/uv.h>
> +#include <asm/local.h>
>=20
> #include "mm_internal.h"
>=20
> @@ -722,43 +723,63 @@ void native_flush_tlb_others(const struct cpumask *c=
pumask,
>  */
> unsigned long tlb_single_page_flush_ceiling __read_mostly =3D 33;
>=20
> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct flush_tlb_info, flush_tlb_inf=
o);
> +#ifdef CONFIG_DEBUG_VM
> +static DEFINE_PER_CPU(local_t, flush_tlb_info_idx);
> +#endif
> +
> void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>                unsigned long end, unsigned int stride_shift,
>                bool freed_tables)
> {
> +    struct flush_tlb_info *info;
>    int cpu;
>=20
> -    struct flush_tlb_info info __aligned(SMP_CACHE_BYTES) =3D {
> -        .mm =3D mm,
> -        .stride_shift =3D stride_shift,
> -        .freed_tables =3D freed_tables,
> -    };
> -
>    cpu =3D get_cpu();
>=20
> +    info =3D this_cpu_ptr(&flush_tlb_info);
> +
> +#ifdef CONFIG_DEBUG_VM
> +    /*
> +     * Ensure that the following code is non-reentrant and flush_tlb_info=

> +     * is not overwritten. This means no TLB flushing is initiated by
> +     * interrupt handlers and machine-check exception handlers. If needed=
,
> +     * we can add additional flush_tlb_info entries.
> +     */
> +    BUG_ON(local_inc_return(this_cpu_ptr(&flush_tlb_info_idx)) !=3D 1);
> +#endif
> +
> +    info->mm =3D mm;
> +    info->stride_shift =3D stride_shift;
> +    info->freed_tables =3D freed_tables;
> +
>    /* This is also a barrier that synchronizes with switch_mm(). */
> -    info.new_tlb_gen =3D inc_mm_tlb_gen(mm);
> +    info->new_tlb_gen =3D inc_mm_tlb_gen(mm);
>=20
>    /* Should we flush just the requested range? */
>    if ((end !=3D TLB_FLUSH_ALL) &&
>        ((end - start) >> stride_shift) <=3D tlb_single_page_flush_ceiling)=
 {
> -        info.start =3D start;
> -        info.end =3D end;
> +        info->start =3D start;
> +        info->end =3D end;
>    } else {
> -        info.start =3D 0UL;
> -        info.end =3D TLB_FLUSH_ALL;
> +        info->start =3D 0UL;
> +        info->end =3D TLB_FLUSH_ALL;
>    }
>=20
>    if (mm =3D=3D this_cpu_read(cpu_tlbstate.loaded_mm)) {
> -        VM_WARN_ON(irqs_disabled());
> +        lockdep_assert_irqs_enabled();
>        local_irq_disable();
> -        flush_tlb_func_local(&info, TLB_LOCAL_MM_SHOOTDOWN);
> +        flush_tlb_func_local(info, TLB_LOCAL_MM_SHOOTDOWN);
>        local_irq_enable();
>    }
>=20
>    if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
> -        flush_tlb_others(mm_cpumask(mm), &info);
> +        flush_tlb_others(mm_cpumask(mm), info);
>=20
> +#ifdef CONFIG_DEBUG_VM
> +    barrier();
> +    local_dec(this_cpu_ptr(&flush_tlb_info_idx));
> +#endif
>    put_cpu();
> }
>=20
> --=20
> 2.17.1
>=20
>=20
