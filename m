Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41949 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754995AbcBIRWB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 9 Feb 2016 12:22:01 -0500
Date: Tue, 9 Feb 2016 17:21:26 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] asm-generic: Fix build when __set_fixmap is absent
Message-ID: <20160209172125.GA4348@leverpostej>
References: <20160209143554.GA9332@leverpostej>
 <201602100053.LjML6D6b%fengguang.wu@intel.com>
 <20160209163333.GA22110@leverpostej>
 <20160209165234.GI16122@e104818-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160209165234.GI16122@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, Linux-Arch <linux-arch@vger.kernel.org>, Laura Abbott <labbott@fedoraproject.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Message-ID: <20160209172126.K-e5SpfXQK1-suECMWyt9VV8yCo4C7OZd0O7ypJJ31g@z>

On Tue, Feb 09, 2016 at 04:52:34PM +0000, Catalin Marinas wrote:
> On Tue, Feb 09, 2016 at 04:33:34PM +0000, Mark Rutland wrote:
> > > >> include/asm-generic/fixmap.h:72:6: error: conflicting types for '__set_fixmap'
> > >     void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
> > >          ^
> > >    In file included from arch/um/include/asm/pgtable.h:11:0,
> > >                     from include/linux/mm.h:67,
> > >                     from include/linux/ring_buffer.h:5,
> > >                     from include/linux/trace_events.h:5,
> > >                     from include/trace/syscall.h:6,
> > >                     from include/linux/syscalls.h:81,
> > >                     from init/main.c:18:
> > >    arch/um/include/asm/fixmap.h:39:13: note: previous declaration of '__set_fixmap' was here
> > >     extern void __set_fixmap (enum fixed_addresses idx,
> > >                 ^
> > 
> > The conflict is the type of 'phys'. In arch/um that's an unsigned long
> > rather than a phys_addr_t as it is elsewhere.
> 
> At a quick grep, we also have:
> 
> arch/sh/include/asm/fixmap.h
> arch/sh/mm/init.c
> arch/sh/mm/nommu.c
> 
> > If I convert that to a phys_addr_t the build goes along happily.
> > 
> > Should we change set_fixmap_offset back to a macro function for now, or
> > is it simple/correct to change arch/um to use phys_addr_t in
> > __set_fixmap?
> 
> And sh. I prefer the static inline, though there is more effort needed
> to test and get acks ;) (I really don't mind either way).

I would also prefer to make this a static inline, but it looks like we
need to sort out some cross-architecture cleanup first. I'm happy to
have a go at that.

In the meantime, so as to allow linux-next to build, and to save us from
merge hell, let's follow the usual idiom and hope that underscores will
protect us.

Hopefully this is the last time I ask this today: Arnd, Catalin, are you
happy with the below patch?

Mark.

---->8----
