Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailgate-2.ics.forth.gr ([139.91.1.5]:51284 "EHLO
        mailgate-2.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDLRGv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Apr 2019 13:06:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Fri, 12 Apr 2019 19:05:33 +0300
From: Nick Kossifidis <mick@ics.forth.gr>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel
 endianess
In-Reply-To: <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com>
References: <20190412143538.11780-1-hch@lst.de>
 <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com>
Message-ID: <fd59e6e22594f740eaf86abad76ee04d@mailhost.ics.forth.gr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, mick@ics.forth.gr, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190412160533.z2UXjzYn34tM6OrwGiIpsZUVtXrFThsznyQjiLIZXQU@z>

Στις 2019-04-12 17:53, Arnd Bergmann έγραψε:
> On Fri, Apr 12, 2019 at 4:36 PM Christoph Hellwig <hch@lst.de> wrote:
>> 
>> When removing some dead big endian checks in the RISC-V code Nick
>> suggested that we should have some generic sanity checks.  I don't 
>> think
>> we should have thos inside the RISC-V code, but maybe it might make
>> sense to have these in the generic byteorder headers.  Note that these
>> are UAPI headers and some compilers might not actually define
>> __BYTE_ORDER__, so we first check that it actually exists.
>> 
>> Suggested-by: Nick Kossifidis <mick@ics.forth.gr>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Extra checking like this is good in general, but I'm not sure I see
> exactly what kind of issue one might expect to prevent with this:
> 
> All architecture asm/byteorder.h headers either include the only
> possible option, or they check the compiler defined macros:
> 
> arch/arc/include/uapi/asm/byteorder.h:#ifdef __BIG_ENDIAN__
> arch/arm/include/uapi/asm/byteorder.h:#ifdef __ARMEB__
> arch/arm64/include/uapi/asm/byteorder.h:#ifdef __AARCH64EB__
> arch/c6x/include/uapi/asm/byteorder.h:#ifdef _BIG_ENDIAN
> arch/microblaze/include/uapi/asm/byteorder.h:#ifdef __MICROBLAZEEL__
> arch/mips/include/uapi/asm/byteorder.h:#if defined(__MIPSEB__)
> arch/nds32/include/uapi/asm/byteorder.h:#ifdef __NDS32_EB__
> arch/powerpc/include/uapi/asm/byteorder.h:#ifdef __LITTLE_ENDIAN__
> arch/sh/include/uapi/asm/byteorder.h:#ifdef __LITTLE_ENDIAN__
> arch/xtensa/include/uapi/asm/byteorder.h:#ifdef __XTENSA_EL__
> 
> Are you worried about toolchains that define those differently
> from what these headers expect? Did you encounter such a case?
> 
>       Arnd

The following architectures just include the header file without
checking for any compiler macro:

alpha: little_endian.h
csky: little_endian.h
h8300: big_endian.h
hexagon: little_endian.h
ia64: little_endian.h
m68k: big_endian.h
nios2: little_endian.h
openrisc: big_endian.h
parisc: big_endian.h
riscv: little_endian.h
s390: big_endian.h
sparc: big_endian.h
unicore32: little_endian.h
x86: little_endian.h

Of those who do check for a compiler macro, they don't use the
generic macros (__ORDER_*_ENDIAN__) but arch-specific ones.

Only two architectures (mips and xtensa) that support both big
and little endian return an error in case the endianess can't be
determined, the rest will move on without including any
of *_endian.h files.

I think it's good to have a sanity check in-place for consistency.

Regards,
Nick
