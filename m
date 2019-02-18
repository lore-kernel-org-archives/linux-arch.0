Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387848AbfBRP4O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Feb 2019 10:56:14 -0500
Date: Mon, 18 Feb 2019 15:56:07 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/2] asm-generic/io: Pass result on inX() accessor to
 __io_par()
Message-ID: <20190218155607.GA16713@fuggles.cambridge.arm.com>
References: <CAK8P3a1-CA_d+tRRKh50+7-PU14AV=9S1JUSF4d-VUxZ+DcW4g@mail.gmail.com>
 <mhng-30e76674-df9d-4689-8c77-3a3b4723ee24@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-30e76674-df9d-4689-8c77-3a3b4723ee24@palmer-si-x1c4>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andrew.murray@arm.com, catalin.marinas@arm.com, linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu
Message-ID: <20190218155607.i4cNTzY2LVBzTdL9XkVyNxHb-JqTkM4EQqlFSabjCcg@z>

On Wed, Feb 13, 2019 at 01:57:50PM -0800, Palmer Dabbelt wrote:
> On Wed, 13 Feb 2019 12:59:28 PST (-0800), Arnd Bergmann wrote:
> > On Wed, Feb 13, 2019 at 6:46 PM Will Deacon <will.deacon@arm.com> wrote:
> > 
> > > On Tue, Feb 12, 2019 at 12:55:17PM +0100, Arnd Bergmann wrote:
> > > 
> > > > For all I can see, this should not conflict with the usage of the
> > > > same macros on RISC-V, though it does make add a significant
> > > > difference, so I'd like to see an Ack from the RISC-V folks as
> > > > well (added to Cc), or possibly a change to arch/riscv/include/asm/io.h
> > > > to do a corresponding change.
> 
> Thanks, the original patches didn't make it through my filters.
> 
> > > There's already a comment in that header which says that the accesses are
> > > ordered wrt timer reads, so I don't think anything needs to change there.
> > > For consistency with the macro arguments, I could augment their __io_par to
> > > take the read value as an unused argument, if that's what you mean?
> 
> FWIW, we don't really have a way to mandate this in the ISA yet as there's
> no formal model for either CSR orderings or the IO memory space.

Ah, so you may end up needing the dependency trick too, depending on where
you land with the ISA.

> > Yes, that's what I meant, I should have been clearer there.
> 
> That sounds reasonable to me.  It looks like we can also go ahead and delete
> a bunch of arch/riscv/include/asm/io.h now that this stuff is in
> asm-generic, which would cause us to actually start using these things.  I
> didn't know this had all been moved to asm-generic otherwise I would have
> cleaned this up earlier.
> 
> I think this should do it, but this does bring up a bit of an issue: the
> RISC-V versions of reads and friends put barriers outside the loop, while
> the asm-generic version don't.  What are these actually supposed to do?

You're referring to the string accessors (e.g. insb() and readsw()), right?
arm and arm64 don't provide barriers here either, and I don't think they
should have to given that these routines are usually used to poll data
register-based FIFOs and therefore don't need to provide ordering guarantees
against DMA operations. However, this is woefully undocumented and I shall
try to address this in the next version of my memory-barriers.txt patch
relating to this area [1].

> Either way that resolves, feel free to consider something like
> 
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index b269451e7e85..378975f180a7 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -198,20 +198,20 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>  * writes.
>  */
> #define __io_pbr()	__asm__ __volatile__ ("fence io,i"  : : : "memory");
> -#define __io_par()	__asm__ __volatile__ ("fence i,ior" : : : "memory");
> +#define __io_par(v)	__asm__ __volatile__ ("fence i,ior" : : : "memory");
> #define __io_pbw()	__asm__ __volatile__ ("fence iow,o" : : : "memory");
> #define __io_paw()	__asm__ __volatile__ ("fence o,io"  : : : "memory");
> 
> -#define inb(c)		({ u8  __v; __io_pbr(); __v = readb_cpu((void*)(PCI_IOBASE + (c))); __io_par(); __v; })
> -#define inw(c)		({ u16 __v; __io_pbr(); __v = readw_cpu((void*)(PCI_IOBASE + (c))); __io_par(); __v; })
> -#define inl(c)		({ u32 __v; __io_pbr(); __v = readl_cpu((void*)(PCI_IOBASE + (c))); __io_par(); __v; })
> +#define inb(c)		({ u8  __v; __io_pbr(); __v = readb_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
> +#define inw(c)		({ u16 __v; __io_pbr(); __v = readw_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
> +#define inl(c)		({ u32 __v; __io_pbr(); __v = readl_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
> 
> #define outb(v,c)	({ __io_pbw(); writeb_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
> #define outw(v,c)	({ __io_pbw(); writew_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
> #define outl(v,c)	({ __io_pbw(); writel_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
> 
> #ifdef CONFIG_64BIT
> -#define inq(c)		({ u64 __v; __io_pbr(); __v = readq_cpu((void*)(c)); __io_par(); __v; })
> +#define inq(c)		({ u64 __v; __io_pbr(); __v = readq_cpu((void*)(c)); __io_par(__v); __v; })
> #define outq(v,c)	({ __io_pbw(); writeq_cpu((v),(void*)(c)); __io_paw(); })
> #endif
> 
> @@ -261,9 +261,9 @@ __io_reads_ins(reads, u32, l, __io_br(), __io_ar())
> #define readsw(addr, buffer, count) __readsw(addr, buffer, count)
> #define readsl(addr, buffer, count) __readsl(addr, buffer, count)
> 
> -__io_reads_ins(ins,  u8, b, __io_pbr(), __io_par())
> -__io_reads_ins(ins, u16, w, __io_pbr(), __io_par())
> -__io_reads_ins(ins, u32, l, __io_pbr(), __io_par())
> +__io_reads_ins(ins,  u8, b, __io_pbr(), __io_par(addr))
> +__io_reads_ins(ins, u16, w, __io_pbr(), __io_par(addr))
> +__io_reads_ins(ins, u32, l, __io_pbr(), __io_par(addr))
> #define insb(addr, buffer, count) __insb((void __iomem *)(long)addr, buffer, count)
> #define insw(addr, buffer, count) __insw((void __iomem *)(long)addr, buffer, count)
> #define insl(addr, buffer, count) __insl((void __iomem *)(long)addr, buffer, count)
> 
> as
> 
> Revewied-by: Palmer Dabbelt <palmer@sifive.com>
> 
> when included along with the other diff.  That way we can at least keep the
> macro signatures matching, the cleanup can come later...

Thanks, Palmer! I'll send a v2 of this patch, updated to fix up insq() as
well as the readX() macros too, since they're likely to suffer the exact
same issues as inX() in this regard.

Will

[1] https://lkml.org/lkml/2019/2/11/1803
