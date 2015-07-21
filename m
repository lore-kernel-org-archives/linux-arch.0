From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 05/10] arch: unify ioremap prototypes and macro aliases
Date: Tue, 21 Jul 2015 09:08:56 -0700
Message-ID: <CAPcyv4i7Sfo54koFC-KB+=YaBZpbW1dndp+DFJhwptFSTpfSVA@mail.gmail.com>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150720001759.30857.23753.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150721133457.GC8902@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36115 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088AbbGUQI6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2015 12:08:58 -0400
Received: by wicgb10 with SMTP id gb10so60311390wic.1
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2015 09:08:56 -0700 (PDT)
In-Reply-To: <20150721133457.GC8902@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Luis Rodriguez <mcgrof@suse.com>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Kani, Toshimitsu" <toshi.kani@hp.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, kbuild test robot <fengguang.wu@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Jul 21, 2015 at 6:34 AM, Christoph Hellwig <hch@lst.de> wrote:
>
> On Sun, Jul 19, 2015 at 08:18:00PM -0400, Dan Williams wrote:
> > Some archs define the first parameter to ioremap() as unsigned long,
> > while the balance define it as resource_size_t, similar confusion exists
> > for the type of the 'size' parameter.  Unify on (resource_size_t,
> > unsigned long) to enable passing ioremap function pointers.  Also, some
> > archs use function-like macros for defining ioremap aliases, but
> > asm-generic/io.h expects object-like macros, unify on the latter.
> >
> > Move all handling of ioremap aliasing (i.e. ioremap_wt => ioremap) to
> > include/linux/io.h.  Add a check to lib/devres.c to warn at compile time
> > if an arch violates type expectations.
>
> I don't think devres really has aything to do with this code.

It's one of the only cross-arch C files that is built with HAS_IOMEM.
It depends on having a common ioremap prototype later in the series.

> > Kill ARCH_HAS_IOREMAP_WC and ARCH_HAS_IOREMAP_WT in favor of just
> > testing for ioremap_wc, and ioremap_wt being defined.  This arrangement
> > allows drivers to know when ioremap_<foo> are being re-directed to plain
> > ioremap.  A later patch uses this arrangement to implement support for
> > strict mappings.
> >
> > Acked-by: Christoph Hellwig <hch@lst.de>
>
> I only ACKed this as a band-aid to get the pmem code in.  Now that
> we got that in with a less invasive hack I don't see any reasons to
> do this over doing the proper common prototypes and per-arch runtime checks
> of flags variant.

That's not too much of a setback.  I had already started to realize
that nobody really wants the ioremap_<type> variants compared to
memremap.  So rather than introduce this cleanup and deprecate
ioremap_<type> over time, let's just skip a step and start converting
to memremap() with a proper 'flags' parameter for the mapping-type
right away
