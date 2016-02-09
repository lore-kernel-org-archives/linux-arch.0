From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] asm-generic: Fix build when __set_fixmap is absent
Date: Tue, 9 Feb 2016 16:52:34 +0000
Message-ID: <20160209165234.GI16122@e104818-lin.cambridge.arm.com>
References: <20160209143554.GA9332@leverpostej>
 <201602100053.LjML6D6b%fengguang.wu@intel.com>
 <20160209163333.GA22110@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160209163333.GA22110@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, Linux-Arch <linux-arch@vger.kernel.org>, Laura Abbott <labbott@fedoraproject.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 09, 2016 at 04:33:34PM +0000, Mark Rutland wrote:
> > >> include/asm-generic/fixmap.h:72:6: error: conflicting types for '__set_fixmap'
> >     void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
> >          ^
> >    In file included from arch/um/include/asm/pgtable.h:11:0,
> >                     from include/linux/mm.h:67,
> >                     from include/linux/ring_buffer.h:5,
> >                     from include/linux/trace_events.h:5,
> >                     from include/trace/syscall.h:6,
> >                     from include/linux/syscalls.h:81,
> >                     from init/main.c:18:
> >    arch/um/include/asm/fixmap.h:39:13: note: previous declaration of '__set_fixmap' was here
> >     extern void __set_fixmap (enum fixed_addresses idx,
> >                 ^
> 
> The conflict is the type of 'phys'. In arch/um that's an unsigned long
> rather than a phys_addr_t as it is elsewhere.

At a quick grep, we also have:

arch/sh/include/asm/fixmap.h
arch/sh/mm/init.c
arch/sh/mm/nommu.c

> If I convert that to a phys_addr_t the build goes along happily.
> 
> Should we change set_fixmap_offset back to a macro function for now, or
> is it simple/correct to change arch/um to use phys_addr_t in
> __set_fixmap?

And sh. I prefer the static inline, though there is more effort needed
to test and get acks ;) (I really don't mind either way).

-- 
Catalin
