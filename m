From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [patch 02/41] cpu alloc: The allocator
Date: Fri, 30 May 2008 07:04:55 +0200
Message-ID: <483F8AF7.9000309@cosmosbay.com>
References: <20080530035620.587204923@sgi.com> <20080530040011.084909898@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp27.orange.fr ([80.12.242.94]:55153 "EHLO smtp27.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752468AbYE3FFa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 01:05:30 -0400
In-Reply-To: <20080530040011.084909898@sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

Christoph Lameter a =E9crit :
> The per cpu allocator allows dynamic allocation of memory on all
> processors simultaneously. A bitmap is used to track used areas.
> The allocator implements tight packing to reduce the cache footprint
> and increase speed since cacheline contention is typically not a conc=
ern
> for memory mainly used by a single cpu. Small objects will fill up ga=
ps
> left by larger allocations that required alignments.
>
> The size of the cpu_alloc area can be changed via make menuconfig.
>
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> ---
>  include/linux/percpu.h |   46 +++++++++++++
>  include/linux/vmstat.h |    2=20
>  mm/Kconfig             |    6 +
>  mm/Makefile            |    2=20
>  mm/cpu_alloc.c         |  167 ++++++++++++++++++++++++++++++++++++++=
+++++++++++
>  mm/vmstat.c            |    1=20
>  6 files changed, 222 insertions(+), 2 deletions(-)
>
> Index: linux-2.6/include/linux/vmstat.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/linux/vmstat.h	2008-05-29 19:41:21.0000000=
00 -0700
> +++ linux-2.6/include/linux/vmstat.h	2008-05-29 20:15:37.000000000 -0=
700
> @@ -37,7 +37,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PS
>  		FOR_ALL_ZONES(PGSCAN_KSWAPD),
>  		FOR_ALL_ZONES(PGSCAN_DIRECT),
>  		PGINODESTEAL, SLABS_SCANNED, KSWAPD_STEAL, KSWAPD_INODESTEAL,
> -		PAGEOUTRUN, ALLOCSTALL, PGROTATED,
> +		PAGEOUTRUN, ALLOCSTALL, PGROTATED, CPU_BYTES,
>  #ifdef CONFIG_HUGETLB_PAGE
>  		HTLB_BUDDY_PGALLOC, HTLB_BUDDY_PGALLOC_FAIL,
>  #endif
> Index: linux-2.6/mm/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/mm/Kconfig	2008-05-29 19:41:21.000000000 -0700
> +++ linux-2.6/mm/Kconfig	2008-05-29 20:13:39.000000000 -0700
> @@ -205,3 +205,9 @@ config NR_QUICK
>  config VIRT_TO_BUS
>  	def_bool y
>  	depends on !ARCH_NO_VIRT_TO_BUS
> +
> +config CPU_ALLOC_SIZE
> +	int "Size of cpu alloc area"
> +	default "30000"
> +	help
> +	  Sets the maximum amount of memory that can be allocated via cpu_a=
lloc
> Index: linux-2.6/mm/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/mm/Makefile	2008-05-29 19:41:21.000000000 -0700
> +++ linux-2.6/mm/Makefile	2008-05-29 20:15:41.000000000 -0700
> @@ -11,7 +11,7 @@ obj-y			:=3D bootmem.o filemap.o mempool.o
>  			   maccess.o page_alloc.o page-writeback.o pdflush.o \
>  			   readahead.o swap.o truncate.o vmscan.o \
>  			   prio_tree.o util.o mmzone.o vmstat.o backing-dev.o \
> -			   page_isolation.o $(mmu-y)
> +			   page_isolation.o cpu_alloc.o $(mmu-y)
> =20
>  obj-$(CONFIG_PROC_PAGE_MONITOR) +=3D pagewalk.o
>  obj-$(CONFIG_BOUNCE)	+=3D bounce.o
> Index: linux-2.6/mm/cpu_alloc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6/mm/cpu_alloc.c	2008-05-29 20:13:39.000000000 -0700
> @@ -0,0 +1,167 @@
> +/*
> + * Cpu allocator - Manage objects allocated for each processor
> + *
> + * (C) 2008 SGI, Christoph Lameter <clameter@sgi.com>
> + * 	Basic implementation with allocation and free from a dedicated p=
er
> + * 	cpu area.
> + *
> + * The per cpu allocator allows dynamic allocation of memory on all
> + * processor simultaneously. A bitmap is used to track used areas.
> + * The allocator implements tight packing to reduce the cache footpr=
int
> + * and increase speed since cacheline contention is typically not a =
concern
> + * for memory mainly used by a single cpu. Small objects will fill u=
p gaps
> + * left by larger allocations that required alignments.
> + */
> +#include <linux/mm.h>
> +#include <linux/mmzone.h>
> +#include <linux/module.h>
> +#include <linux/percpu.h>
> +#include <linux/bitmap.h>
> +#include <asm/sections.h>
> +
> +/*
> + * Basic allocation unit. A bit map is created to track the use of e=
ach
> + * UNIT_SIZE element in the cpu area.
> + */
> +#define UNIT_TYPE int
> +#define UNIT_SIZE sizeof(UNIT_TYPE)
> +#define UNITS (CONFIG_CPU_ALLOC_SIZE / UNIT_SIZE)
> +
> +static DEFINE_PER_CPU(UNIT_TYPE, area[UNITS]);
>  =20
area[] is not guaranteed to be aligned on anything but 4 bytes.

If someone then needs to call cpu_alloc(8, GFP_KERNEL, 8), it might get=
=20
an non aligned result.

Either you should add an __attribute__((__aligned__(PAGE_SIZE))),
or take into account the real address of area[] in cpu_alloc() to avoid=
=20
waste of up to PAGE_SIZE bytes
per cpu.
> +
> +/*
> + * How many units are needed for an object of a given size
> + */
> +static int size_to_units(unsigned long size)
> +{
> +	return DIV_ROUND_UP(size, UNIT_SIZE);
> +}
> +
> +/*
> + * Lock to protect the bitmap and the meta data for the cpu allocato=
r.
> + */
> +static DEFINE_SPINLOCK(cpu_alloc_map_lock);
> +static DECLARE_BITMAP(cpu_alloc_map, UNITS);
> +static int first_free;		/* First known free unit */
> +
> +/*
> + * Mark an object as used in the cpu_alloc_map
> + *
> + * Must hold cpu_alloc_map_lock
> + */
> +static void set_map(int start, int length)
> +{
> +	while (length-- > 0)
> +		__set_bit(start++, cpu_alloc_map);
> +}
> +
> +/*
> + * Mark an area as freed.
> + *
> + * Must hold cpu_alloc_map_lock
> + */
> +static void clear_map(int start, int length)
> +{
> +	while (length-- > 0)
> +		__clear_bit(start++, cpu_alloc_map);
> +}
> +
> +/*
> + * Allocate an object of a certain size
> + *
> + * Returns a special pointer that can be used with CPU_PTR to find t=
he
> + * address of the object for a certain cpu.
> + */
> +void *cpu_alloc(unsigned long size, gfp_t gfpflags, unsigned long al=
ign)
> +{
> +	unsigned long start;
> +	int units =3D size_to_units(size);
> +	void *ptr;
> +	int first;
> +	unsigned long flags;
> +
> +	if (!size)
> +		return ZERO_SIZE_PTR;
> +
> +	spin_lock_irqsave(&cpu_alloc_map_lock, flags);
> +
> +	first =3D 1;
> +	start =3D first_free;
> +
> +	for ( ; ; ) {
> +
> +		start =3D find_next_zero_bit(cpu_alloc_map, UNITS, start);
> +		if (start >=3D UNITS)
> +			goto out_of_memory;
> +
> +		if (first)
> +			first_free =3D start;
> +
> +		/*
> +		 * Check alignment and that there is enough space after
> +		 * the starting unit.
> +		 */
> +		if (start % (align / UNIT_SIZE) =3D=3D 0 &&
> +			find_next_bit(cpu_alloc_map, UNITS, start + 1)
> +							>=3D start + units)
> +				break;
> +		start++;
> +		first =3D 0;
> +	}
> +
> +	if (first)
> +		first_free =3D start + units;
> +
> +	if (start + units > UNITS)
> +		goto out_of_memory;
> +
> +	set_map(start, units);
> +	__count_vm_events(CPU_BYTES, units * UNIT_SIZE);
> +
> +	spin_unlock_irqrestore(&cpu_alloc_map_lock, flags);
> +
> +	ptr =3D per_cpu_var(area) + start;
> +
> +	if (gfpflags & __GFP_ZERO) {
> +		int cpu;
> +
> +		for_each_possible_cpu(cpu)
> +			memset(CPU_PTR(ptr, cpu), 0, size);
> +	}
> +
> +	return ptr;
> +
> +out_of_memory:
> +	spin_unlock_irqrestore(&cpu_alloc_map_lock, flags);
> +	return NULL;
> +}
> +EXPORT_SYMBOL(cpu_alloc);
> +
> +/*
> + * Free an object. The pointer must be a cpu pointer allocated
> + * via cpu_alloc.
> + */
> +void cpu_free(void *start, unsigned long size)
> +{
> +	unsigned long units =3D size_to_units(size);
> +	unsigned long index =3D (int *)start - per_cpu_var(area);
> +	unsigned long flags;
> +
> +	if (!start || start =3D=3D ZERO_SIZE_PTR)
> +		return;
> +
> +	BUG_ON(index >=3D UNITS ||
> +		!test_bit(index, cpu_alloc_map) ||
> +		!test_bit(index + units - 1, cpu_alloc_map));
> +
> +	spin_lock_irqsave(&cpu_alloc_map_lock, flags);
> +
> +	clear_map(index, units);
> +	__count_vm_events(CPU_BYTES, -units * UNIT_SIZE);
> +
> +	if (index < first_free)
> +		first_free =3D index;
> +
> +	spin_unlock_irqrestore(&cpu_alloc_map_lock, flags);
> +}
> +EXPORT_SYMBOL(cpu_free);
> Index: linux-2.6/mm/vmstat.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/mm/vmstat.c	2008-05-29 19:41:21.000000000 -0700
> +++ linux-2.6/mm/vmstat.c	2008-05-29 20:13:39.000000000 -0700
> @@ -653,6 +653,7 @@ static const char * const vmstat_text[]=20
>  	"allocstall",
> =20
>  	"pgrotated",
> +	"cpu_bytes",
>  #ifdef CONFIG_HUGETLB_PAGE
>  	"htlb_buddy_alloc_success",
>  	"htlb_buddy_alloc_fail",
> Index: linux-2.6/include/linux/percpu.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/linux/percpu.h	2008-05-29 19:41:21.0000000=
00 -0700
> +++ linux-2.6/include/linux/percpu.h	2008-05-29 20:29:12.000000000 -0=
700
> @@ -135,4 +135,50 @@ static inline void percpu_free(void *__p
>  #define free_percpu(ptr)	percpu_free((ptr))
>  #define per_cpu_ptr(ptr, cpu)	percpu_ptr((ptr), (cpu))
> =20
> +
> +/*
> + * cpu allocator definitions
> + *
> + * The cpu allocator allows allocating an instance of an object for =
each
> + * processor and the use of a single pointer to access all instances
> + * of the object. cpu_alloc provides optimized means for accessing t=
he
> + * instance of the object belonging to the currently executing proce=
ssor
> + * as well as special atomic operations on fields of objects of the
> + * currently executing processor.
> + *
> + * Cpu objects are typically small. The allocator packs them tightly
> + * to increase the chance on each access that a per cpu object is al=
ready
> + * cached. Alignments may be specified but the intent is to align th=
e data
> + * properly due to cpu alignment constraints and not to avoid cachel=
ine
> + * contention. Any holes left by aligning objects are filled up with=
 smaller
> + * objects that are allocated later.
> + *
> + * Cpu data can be allocated using CPU_ALLOC. The resulting pointer =
is
> + * pointing to the instance of the variable in the per cpu area prov=
ided
> + * by the loader. It is generally an error to use the pointer direct=
ly
> + * unless we are booting the system.
> + *
> + * __GFP_ZERO may be passed as a flag to zero the allocated memory.
> + */
> +
> +/* Return a pointer to the instance of a object for a particular pro=
cessor */
> +#define CPU_PTR(__p, __cpu)	SHIFT_PERCPU_PTR((__p), per_cpu_offset(_=
_cpu))
> +
> +/*
> + * Return a pointer to the instance of the object belonging to the p=
rocessor
> + * running the current code.
> + */
> +#define THIS_CPU(__p)	SHIFT_PERCPU_PTR((__p), my_cpu_offset)
> +#define __THIS_CPU(__p)	SHIFT_PERCPU_PTR((__p), __my_cpu_offset)
> +
> +#define CPU_ALLOC(type, flags)	((typeof(type) *)cpu_alloc(sizeof(typ=
e), \
> +					(flags), __alignof__(type)))
> +#define CPU_FREE(pointer)	cpu_free((pointer), sizeof(*(pointer)))
> +
> +/*
> + * Raw calls
> + */
> +void *cpu_alloc(unsigned long size, gfp_t flags, unsigned long align=
);
> +void cpu_free(void *cpu_pointer, unsigned long size);
> +
>  #endif /* __LINUX_PERCPU_H */
>
>  =20
