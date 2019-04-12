From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel endianess
Date: Fri, 12 Apr 2019 16:53:28 +0200
Message-ID: <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com>
References: <20190412143538.11780-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412143538.11780-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, mick@ics.forth.gr, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 12, 2019 at 4:36 PM Christoph Hellwig <hch@lst.de> wrote:
>
> When removing some dead big endian checks in the RISC-V code Nick
> suggested that we should have some generic sanity checks.  I don't think
> we should have thos inside the RISC-V code, but maybe it might make
> sense to have these in the generic byteorder headers.  Note that these
> are UAPI headers and some compilers might not actually define
> __BYTE_ORDER__, so we first check that it actually exists.
>
> Suggested-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Extra checking like this is good in general, but I'm not sure I see
exactly what kind of issue one might expect to prevent with this:

All architecture asm/byteorder.h headers either include the only
possible option, or they check the compiler defined macros:

arch/arc/include/uapi/asm/byteorder.h:#ifdef __BIG_ENDIAN__
arch/arm/include/uapi/asm/byteorder.h:#ifdef __ARMEB__
arch/arm64/include/uapi/asm/byteorder.h:#ifdef __AARCH64EB__
arch/c6x/include/uapi/asm/byteorder.h:#ifdef _BIG_ENDIAN
arch/microblaze/include/uapi/asm/byteorder.h:#ifdef __MICROBLAZEEL__
arch/mips/include/uapi/asm/byteorder.h:#if defined(__MIPSEB__)
arch/nds32/include/uapi/asm/byteorder.h:#ifdef __NDS32_EB__
arch/powerpc/include/uapi/asm/byteorder.h:#ifdef __LITTLE_ENDIAN__
arch/sh/include/uapi/asm/byteorder.h:#ifdef __LITTLE_ENDIAN__
arch/xtensa/include/uapi/asm/byteorder.h:#ifdef __XTENSA_EL__

Are you worried about toolchains that define those differently
from what these headers expect? Did you encounter such a case?

      Arnd
