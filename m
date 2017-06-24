From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Fri, 23 Jun 2017 19:01:59 -0700 (PDT)
Message-ID: <mhng-002dc1e3-4bff-43d8-b58c-a105e5643aea@palmer-si-x1c4>
References: <CAK8P3a3LVGTrBxc+GD2gFHKg-YcZ40+z0SJAuFXadqLFDrE=DQ@mail.gmail.com>
Mime-Version: 1.0 (MHng)
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3LVGTrBxc+GD2gFHKg-YcZ40+z0SJAuFXadqLFDrE=DQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, benh@kernel.crashing.org
List-Id: linux-arch.vger.kernel.org

On Wed, 07 Jun 2017 01:12:00 PDT (-0700), Arnd Bergmann wrote:
> On Wed, Jun 7, 2017 at 1:00 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> This patch adds the include files for the RISC-V port.  These are mostly
>> based on the score port, but there are a lot of arm64-based files as
>> well.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>
> It might be better to split this up into several parts, as the patch
> is longer than
> most people are willing to review at once.
>
> The uapi should definitely be a separate patch, as it includes the parts that
> cannot be changed any more later. memory management (pgtable, mmu,
> uaccess) would be another part to split out, and possibly all the atomics
> in one separate patch (along with spinlocks and bitops).

OK, we'll do this for the v3.

>
>> +
>> +/* IO barriers.  These only fence on the IO bits because they're only required
>> + * to order device access.  We're defining mmiowb because our AMO instructions
>> + * (which are used to implement locks) don't specify ordering.  From Chapter 7
>> + * of v2.2 of the user ISA:
>> + * "The bits order accesses to one of the two address domains, memory or I/O,
>> + * depending on which address domain the atomic instruction is accessing. No
>> + * ordering constraint is implied to accesses to the other domain, and a FENCE
>> + * instruction should be used to order across both domains."
>> + */
>> +
>> +#define __iormb()      __asm__ __volatile__ ("fence i,io" : : : "memory");
>> +#define __iowmb()      __asm__ __volatile__ ("fence io,o" : : : "memory");
>> +
>> +#define mmiowb()       __asm__ __volatile__ ("fence io,io" : : : "memory");
>> +
>> +/*
>> + * Relaxed I/O memory access primitives. These follow the Device memory
>> + * ordering rules but do not guarantee any ordering relative to Normal memory
>> + * accesses.
>> + */
>> +#define readb_relaxed(c)       ({ u8  __r = __raw_readb(c); __r; })
>> +#define readw_relaxed(c)       ({ u16 __r = le16_to_cpu((__force __le16)__raw_readw(c)); __r; })
>> +#define readl_relaxed(c)       ({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
>> +#define readq_relaxed(c)       ({ u64 __r = le64_to_cpu((__force __le64)__raw_readq(c)); __r; })
>> +
>> +#define writeb_relaxed(v,c)    ((void)__raw_writeb((v),(c)))
>> +#define writew_relaxed(v,c)    ((void)__raw_writew((__force u16)cpu_to_le16(v),(c)))
>> +#define writel_relaxed(v,c)    ((void)__raw_writel((__force u32)cpu_to_le32(v),(c)))
>> +#define writeq_relaxed(v,c)    ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
>> +
>> +/*
>> + * I/O memory access primitives. Reads are ordered relative to any
>> + * following Normal memory access. Writes are ordered relative to any prior
>> + * Normal memory access.
>> + */
>> +#define readb(c)               ({ u8  __v = readb_relaxed(c); __iormb(); __v; })
>> +#define readw(c)               ({ u16 __v = readw_relaxed(c); __iormb(); __v; })
>> +#define readl(c)               ({ u32 __v = readl_relaxed(c); __iormb(); __v; })
>> +#define readq(c)               ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
>> +
>> +#define writeb(v,c)            ({ __iowmb(); writeb_relaxed((v),(c)); })
>> +#define writew(v,c)            ({ __iowmb(); writew_relaxed((v),(c)); })
>> +#define writel(v,c)            ({ __iowmb(); writel_relaxed((v),(c)); })
>> +#define writeq(v,c)            ({ __iowmb(); writeq_relaxed((v),(c)); })
>> +
>> +#include <asm-generic/io.h>
>
> These do not yet contain all the changes we discussed: the relaxed operations
> don't seem to be ordered against one another and the regular accessors
> are not ordered against DMA.

Sorry, I must have forgotten to write this -- I just wanted to push out a v3
patch set without the changes to the atomics so everything else could be looked
at.  I wanted to just go through the atomics completely and fix them, as I
found a handful of problems (everything was missing the AQ and RL bits, for
example) and figured it would be best to just get them done right.

I think that's not something for after dinner on a Friday, but hopefully I'll
get to it tomorrow morning.
