From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 09/10] arch: introduce memremap()
Date: Mon, 20 Jul 2015 07:39:44 -0700
Message-ID: <CAPcyv4h+02J-GpJ+PC8f1M3O_yXXE0=W5=jg3P33nPesc+YPiQ@mail.gmail.com>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150720001822.30857.65670.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150720120040.GC19239@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38680 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbbGTOjq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2015 10:39:46 -0400
Received: by wibxm9 with SMTP id xm9so28467729wib.1
        for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2015 07:39:44 -0700 (PDT)
In-Reply-To: <20150720120040.GC19239@leverpostej>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@kernel.org" <mingo@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "arnd@arndb.de" <arnd@arndb.de>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "mcgrof@suse.com" <mcgrof@suse.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ralf@linux-mips.org" <ralf@linux-mips.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "toshi.kani@hp.com" <toshi.kani@hp.com>, "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>, "hch@lst.de" <hch@lst.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Will Deacon <will.deacon@arm.com>c

On Mon, Jul 20, 2015 at 5:00 AM, Mark Rutland <mark.rutland@arm.com> wr=
ote:
> Hi,
>
> On Mon, Jul 20, 2015 at 01:18:23AM +0100, Dan Williams wrote:
>> Existing users of ioremap_cache() are mapping memory that is known i=
n
>> advance to not have i/o side effects.  These users are forced to cas=
t
>> away the __iomem annotation, or otherwise neglect to fix the sparse
>> errors thrown when dereferencing pointers to this memory.  Provide
>> memremap() as a non __iomem annotated ioremap_*() in the case when
>> ioremap is otherwise a pointer to memory.
>>
>> The ARCH_HAS_MEMREMAP kconfig symbol is introduced for archs to asse=
rt
>> that it is safe to recast / reuse the return value from ioremap as a
>> normal pointer to memory.  In other words, archs that mandate specif=
ic
>> accessors for __iomem are not memremap() capable and drivers that ca=
re,
>> like pmem, can add a dependency to disable themselves on these archs=
=2E
>>
>> Note, that memremap is a break from the ioremap implementation patte=
rn
>> of adding a new memremap_<type>() for each mapping type.  Instead,
>> the implementation defines flags that are passed to the central
>> memremap() implementation.
>>
>> Outside of ioremap() and ioremap_nocache(), the expectation is that =
most
>> calls to ioremap_<type>() are seeking memory-like semantics (e.g.
>> speculative reads, and prefetching permitted).  These callsites can =
be
>> moved to memremap() over time.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  arch/arm/Kconfig                     |    1 +
>>  arch/arm64/Kconfig                   |    1 +
>>  arch/arm64/kernel/efi.c              |    7 ++---
>>  arch/arm64/kernel/smp_spin_table.c   |   17 +++++------
>
> These last two files weren't updated in patch 2 to use <linux/io.h>, =
nor are
> they updated here, so this patch breaks the build for arm64.

Thanks for testing!  I'll follow up and see why this failure wasn't
reported by 0day-kbuild.

> [...]
>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 318175f62c24..305def28385f 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -6,6 +6,7 @@ config ARM64
>>         select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>>         select ARCH_HAS_ELF_RANDOMIZE
>>         select ARCH_HAS_GCOV_PROFILE_ALL
>> +       select ARCH_HAS_MEMREMAP
>>         select ARCH_HAS_SG_CHAIN
>>         select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADC=
AST
>>         select ARCH_USE_CMPXCHG_LOCKREF
>> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
>> index 9d4aa18f2a82..ed363a0202b9 100644
>> --- a/arch/arm64/kernel/efi.c
>> +++ b/arch/arm64/kernel/efi.c
>> @@ -290,8 +290,7 @@ static int __init arm64_enable_runtime_services(=
void)
>>         pr_info("Remapping and enabling EFI services.\n");
>>
>>         mapsize =3D memmap.map_end - memmap.map;
>> -       memmap.map =3D (__force void *)ioremap_cache((phys_addr_t)me=
mmap.phys_map,
>> -                                                  mapsize);
>> +       memmap.map =3D memremap(memmap.phys_map, mapsize, MEMREMAP_C=
ACHE);
>
> memmap.phys_map is a void*, so we need to retain a cast to a numeric =
type or
> we'll get splats like:
>
> arch/arm64/kernel/efi.c: In function =E2=80=98arm64_enable_runtime_se=
rvices=E2=80=99:
> arch/arm64/kernel/efi.c:294:24: warning: passing argument 1 of =E2=80=
=98memremap=E2=80=99 makes integer from pointer without a cast
>   memmap.map =3D memremap(memmap.phys_map, mapsize, MEMREMAP_CACHE);
>                         ^
> In file included from arch/arm64/kernel/efi.c:18:0:
> include/linux/io.h:203:14: note: expected =E2=80=98resource_size_t=E2=
=80=99 but argument is of type =E2=80=98void *=E2=80=99
>  extern void *memremap(resource_size_t offset, size_t size, unsigned =
long flags);
>               ^

Again, I need to check my compile scripts.

> Unfortunately, even with that fixed this patch breaks boot due to the
> memremap_valid check. It's extremely likely that (portions of) the
> tables are already in the linear mapping, and so page_is_ram will be
> true.

Really, "portions of", not the entire table?  Is it too early to use
the direct mapping like pfn_to_page(memmap.phys_map >> PAGE_SHIFT)?

In any event this splat mandates splitting this memremap() enabling
patch into per-instance conversions of ioremap_cache().

> At boot time I get the following:
>
> Remapping and enabling EFI services.
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at kernel/resource.c:541 memremap+0xb0/0xbc()
> memremap attempted on ram 0x00000009f9e4a018 size: 1200
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.2.0-rc3+ #201
> Hardware name: ARM Juno development board (r0) (DT)
> Call trace:
> [<ffffffc000089954>] dump_backtrace+0x0/0x124
> [<ffffffc000089a88>] show_stack+0x10/0x1c
> [<ffffffc0005d15c8>] dump_stack+0x84/0xc8
> [<ffffffc0000b3f44>] warn_slowpath_common+0x98/0xd0
> [<ffffffc0000b3fc8>] warn_slowpath_fmt+0x4c/0x58
> [<ffffffc0000b9470>] memremap+0xac/0xbc
> [<ffffffc000814fe8>] arm64_enable_runtime_services+0x90/0x208
> [<ffffffc000082864>] do_one_initcall+0x88/0x1a0
> [<ffffffc000811a20>] kernel_init_freeable+0x8c/0x1f8
> [<ffffffc0005ce370>] kernel_init+0xc/0xd8
> ---[ end trace cb88537fdc8fa200 ]---
> Failed to remap EFI memory map
>
>>         if (!memmap.map) {
>>                 pr_err("Failed to remap EFI memory map\n");
>>                 return -1;
>> @@ -299,8 +298,8 @@ static int __init arm64_enable_runtime_services(=
void)
>>         memmap.map_end =3D memmap.map + mapsize;
>>         efi.memmap =3D &memmap;
>>
>> -       efi.systab =3D (__force void *)ioremap_cache(efi_system_tabl=
e,
>> -                                                  sizeof(efi_system=
_table_t));
>> +       efi.systab =3D memremap(efi_system_table, sizeof(efi_system_=
table_t),
>> +                       MEMREMAP_CACHE);
>>         if (!efi.systab) {
>>                 pr_err("Failed to remap EFI System Table\n");
>>                 return -1;
>> diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/=
smp_spin_table.c
>> index aef3605a8c47..b9caf6cd44e6 100644
>> --- a/arch/arm64/kernel/smp_spin_table.c
>> +++ b/arch/arm64/kernel/smp_spin_table.c
>> @@ -73,19 +73,19 @@ static int smp_spin_table_cpu_init(unsigned int =
cpu)
>>
>>  static int smp_spin_table_cpu_prepare(unsigned int cpu)
>>  {
>> -       __le64 __iomem *release_addr;
>> +       __le64 *release_addr;
>>
>>         if (!cpu_release_addr[cpu])
>>                 return -ENODEV;
>>
>>         /*
>>          * The cpu-release-addr may or may not be inside the linear =
mapping.
>> -        * As ioremap_cache will either give us a new mapping or reu=
se the
>> -        * existing linear mapping, we can use it to cover both case=
s. In
>> -        * either case the memory will be MT_NORMAL.
>> +        * As memremap will either give us a new mapping or reuse th=
e existing
>> +        * linear mapping, we can use it to cover both cases. In eit=
her case
>> +        * the memory will be MT_NORMAL.
>>          */
>> -       release_addr =3D ioremap_cache(cpu_release_addr[cpu],
>> -                                    sizeof(*release_addr));
>> +       release_addr =3D memremap(cpu_release_addr[cpu], sizeof(*rel=
ease_addr),
>> +                       MEMREMAP_CACHE);
>
> Likewise, the comment here is contradicted by the code in memremap_va=
lid
> (below). We'll fail to bring up secondaries if the release address fe=
ll
> in the linear mapping.

Ah, so ARM's ioremap_cache() silently handles calls to remap RAM with
a pointer to the direct mapping.  It think that's a useful property to
carry in the generic implementation.  Especially if the direct mapping
has established greater than PAGE_SIZE mappings.

>
>> +#ifdef CONFIG_ARCH_HAS_MEMREMAP
>> +/*
>> + * memremap() is "ioremap" for cases where it is known that the res=
ource
>> + * being mapped does not have i/o side effects and the __iomem
>> + * annotation is not applicable.
>> + */
>> +static bool memremap_valid(resource_size_t offset, size_t size)
>> +{
>> +       if (region_is_ram(offset, size) !=3D 0) {
>> +               WARN_ONCE(1, "memremap attempted on ram %pa size: %z=
u\n",
>> +                               &offset, size);
>> +               return false;
>> +       }
>> +       return true;
>> +}
>> +
>> +void *memremap(resource_size_t offset, size_t size, unsigned long f=
lags)
>> +{
>> +       void __iomem *addr =3D NULL;
>> +
>> +       if (!memremap_valid(offset, size))
>> +               return NULL;
>> +
>> +       /* try all mapping types requested until one returns non-NUL=
L */
>> +       if (flags & MEMREMAP_CACHE) {
>> +               if (flags & MEMREMAP_STRICT)
>> +                       addr =3D strict_ioremap_cache(offset, size);
>> +               else
>> +                       addr =3D ioremap_cache(offset, size);
>> +       }
>> +
>> +       if (!addr && (flags & MEMREMAP_WT)) {
>> +               if (flags & MEMREMAP_STRICT)
>> +                       addr =3D strict_ioremap_wt(offset, size);
>> +               else
>> +                       addr =3D ioremap_wt(offset, size);
>> +       }
>> +
>> +       return (void __force *) addr;
>> +}
>> +EXPORT_SYMBOL(memremap);
>
> Thanks,
> Mark.

Thanks Mark!
