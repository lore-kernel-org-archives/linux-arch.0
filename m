From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: Fix build when __set_fixmap is absent
Date: Tue, 09 Feb 2016 17:45:53 +0100
Message-ID: <2887622.W3XSflQVAL@wuerfel>
References: <20160209143554.GA9332@leverpostej> <201602100053.LjML6D6b%fengguang.wu@intel.com> <20160209163333.GA22110@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:50302 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbcBIQqT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Feb 2016 11:46:19 -0500
In-Reply-To: <20160209163333.GA22110@leverpostej>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, Linux-Arch <linux-arch@vger.kernel.org>, Laura Abbott <labbott@fedoraproject.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>

On Tuesday 09 February 2016 16:33:34 Mark Rutland wrote:
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
> 
> If I convert that to a phys_addr_t the build goes along happily.
> 
> Should we change set_fixmap_offset back to a macro function for now, or
> is it simple/correct to change arch/um to use phys_addr_t in
> __set_fixmap?
> 

I'd vote for using phys_addr_t in arch/um.

	Arnd
